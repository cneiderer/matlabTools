function T_ECI_ECR = get_T_eci_ecr(year, day, UT, constants)
%
%     T_ECI_ECR = Get_T_eci_ecr(year, day, UT, constants)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Coordinate converstion from ECI to ECR
%
%   Input:
%        year  --  year (e.g. 1988)
%        day   --  day  (day of year, integer, Jan 1 = 1),
%        UT    --  Universal Time = hours since midnight along Greenwich
%                  Meridian; 0<=UT<=24, (1XN)
%        constants  -- structure of system constants.  Required fields:
%           GMST_k
%           physical_constants
%              deg_to_rad
%
%   Output:
%        T_ECI_ECR  --  ECI to ECR position transformation matrix
%                   
%   Required Functions:
%        GMST_angle
%


GMST = constants.physical_constants.deg_to_rad * GMST_angle(year, day, UT, constants.GMST_k);

n_UT = length(UT);
n_T  = 3 * n_UT;

T_ECI_ECR = zeros(3,n_T);

T_ECI_ECR(3,[3:3:n_T]) = ones(1,n_UT);
T_ECI_ECR(1,[1:3:n_T]) = cos(GMST);
T_ECI_ECR(1,[2:3:n_T]) = sin(GMST);
T_ECI_ECR(2,[2:3:n_T]) = T_ECI_ECR(1,[1:3:n_T]);
T_ECI_ECR(2,[1:3:n_T]) = -T_ECI_ECR(1,[2:3:n_T]);

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
