function ECR = eci2ecr(ECI, aligned, delT, constants)
%
%     ECR = Eci_ecr(ECI, aligned, delT, constants)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Coordinate converstion from ECI to ECR
%
%   Input:
%        ECI      --  position or position/velocity or pos/vel/acc vectors
%                     in ECI (3XN) or (6XN) or (9XN)
%        aligned  --  structure of when the radar was last aligned.
%                     Following fields are required:
%           year  --  year (e.g. 1988)
%           day   --  day  (day of year, integer, Jan 1 = 1),
%           UT    --  Universal Time = hours since midnight along Greenwich
%                     Meridian; 0<=UT<=24, (1XN)
%        constants.physical_constants  -- structure of system constants.  Required fields:
%           GMST_k
%           physical_constants
%              deg_to_rad
%              omega_e_X_EC
%              omega_e_X2_EC
%
%   Output:
%        ECR  --  position or position/velocity or pos/vel/acc vectors
%                 vectors in ECR coordinates (3XN) or (6XN) or (9XN)
%                   
%   Required Functions:
%        Get_T_eci_ecr
%

year = aligned.year_aligned;
day  = aligned.day_aligned;
UT   = aligned.hour_aligned + delT;

T_ECI_ECR     = get_T_eci_ecr(year, day, UT, constants);
[m_ECI,n_ECI] = size(ECI);

if (n_ECI~=length(UT));
   disp('ECI_ECR: Warning! Dimensions of ECI and UT do not agree!')
end;

if m_ECI == 3;
   ECI_pos = ECI(1:3,:);
   ECR     = [T_ECI_ECR.*(ones(3,1)*ECI_pos(:)')] * kron(eye(n_ECI),ones(3,1));
elseif m_ECI == 6;
   ECI_pos       = ECI(1:3,:);
   ECI_vel       = ECI(4:6,:);
   ECI_pos_omega = constants.physical_constants.omega_e_X_EC * ECI_pos;

   ECR = [T_ECI_ECR.*(ones(3,1)*ECI_pos(:)');
      T_ECI_ECR.*(ones(3,1)*(ECI_vel(:)-ECI_pos_omega(:))')]*kron(eye(n_ECI),ones(3,1));
elseif m_ECI == 9;
   ECI_pos = ECI(1:3,:);
   ECI_vel = ECI(4:6,:);
   ECI_acc = ECI(7:9,:);

   ECI_pos_omega  = constants.physical_constants.omega_e_X_EC*ECI_pos;
   ECI_vel_omega  = 2*constants.physical_constants.omega_e_X_EC*ECI_vel;
   ECI_pos_omega2 = constants.physical_constants.omega_e_X2_EC*ECI_pos;

   ECR = [T_ECI_ECR.*(ones(3,1)*ECI_pos(:)');
        T_ECI_ECR.*(ones(3,1)*(ECI_vel(:)-ECI_pos_omega(:))');
        T_ECI_ECR.*(ones(3,1)*(ECI_acc(:)-ECI_vel_omega(:)+ECI_pos_omega2(:))')]*kron(eye(n_ECI),ones(3,1));
else
   error('ECI_ECR: incorrectly dimensioned input!!!');
end;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
