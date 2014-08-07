function derivative = PropagateExoGroup(sv_rrc, cov_rrc, constants, radar, flags)
%     derivative = PropagateExoGroup(sv_rrc, cov_rrc, constants, radar, flags);
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculate the time derivative of an earth centered RRC state vector
%      and of an RRC covariance for EXO object.
%
%   Input:
%        sv_rrc    --  6x1 RRC state vector centered at earth center
%        cov_rrc   --  6x6 RRC covariance matrix for the current time
%        constants --  structure with specific object information fields:
%           physical_constants    --  A structure of physical constants.
%                j2               --  2nd zonal harmonic
%                mu_e             --  earth gravitational parameter
%                                     (m^3/s^2)
%                re_sq            --  square of the equatorial earth radius
%
%           map_saps
%                map_tp_sap_1047  --  process noise for EXO along velocity
%                                     vector
%                map_tp_sap_1160  --  Scale factor used to determine the
%                                     process noise associated with the
%                                     derivative of the position in the
%                                     covariance matrix
%
%        radar --  structure with specific object information fields:
%           site   --  created with 'form_site_constants'
%                twice_omega_e_x  --  2 * the earth rotation rate
%                omega_e_x_sq     --  the square of the earth rotation rate
%                up               --  3x1 unit vector in the direction of
%                                     the earth centered (ECR or ECI) z
%                                     vector, in RRC
%           funs
%                acceleration_gravity
%
%        flags     --  structure of specific flags:
%           noQ         --  A flag to indicate if desire to not use process
%                           noise.  Default value is zero, which means to
%                           use process noise
%           noBkwdProp  --  A flag to indicate if desire not to propagate
%                           backward.  Default value is one, which means to
%                           propagate forward in time
%           des_fun     --  A string to indicate what you wish to
%                           propagate.  Accepts 'sv' or 'cov'
%
%   Output:
%        derivative     --  Represents either the (6x1) time derivative of
%                           the input state vector, or the 6x6 matrix time
%                           derivative of the input covariance matrix.  If
%                           there is an error, this is empty ( = [] )
%
%   Required Functions:
%        Acceleration    --  
%        J_exo_dynamics  --  
%        Unit            --  


if strcmpi(flags.des_fun, 'sv')
   sv_rrcD = Propagate_sv(sv_rrc, constants, radar);
   derivative = sv_rrcD;
elseif strcmpi(flags.des_fun, 'cov')
   [P_prime, process_noise_terms] = Propagate_cov(sv_rrc, cov_rrc, constants, radar, flags);
   derivative = P_prime;
end %determining which sub function to call

%If error, returns empty results
return


function sv_rrcD = Propagate_sv(sv_rrc, constants, radar)

%Propagate the state vector

NSTATES = 6;

%Indicies for position and velocity in the state vector input
PSN = 1:3;
VEL = 4:6;

%Get the position and velocity vectorrs, for ease of reference
r_pos = sv_rrc(PSN,:);
vel   = sv_rrc(VEL,:);

%Get which function to call to calculate the acceleration due to gravity,
%etc.
fun = radar.funs.acceleration_gravity;

%Take care of case when sv_rrc is larger than the expected 6 state vector
[nr, nc] = size(sv_rrc);  %The number of states

if nr > NSTATES
   pad_size = nr - NSTATES;
else
   pad_size = [];
end

%Calculate the derivative of the velocity.
[acc_grav, acc_cor, acc_cen] = feval(fun, r_pos, vel, constants, radar);

%The derivative of the input
sv_rrcD  = [vel; acc_grav + acc_cor + acc_cen]; 

sv_rrcD  = [sv_rrcD; zeros(pad_size, nc)];

return





function [P_prime, process_noise_terms] = Propagate_cov(sv_rrc, cov_rrc, constants, radar, flags)

%Propagate the covariance matrix

%Constants
K1      = 1;
NSTATES = 6;

%Indicies for position and velocity in the state vector input
VEL = 4:6;

%Figure out if we need to do any extra stuff if the input is larger than a
%6x6 matrix
[nr, nc] = size(cov_rrc);

if (nr > NSTATES) && (nc > NSTATES)
   mat_pad = nr - NSTATES;
   cov_rrc = cov_rrc(1:NSTATES, 1:NSTATES);
   tmpFlag = true;
else
   tmpFlag = false;
end

%Get the position and velocity vectorrs, for ease of reference
vel   = sv_rrc(VEL,:);

if flags.maneuver==0
%Process noise values (and one random sap)
q          = constants.map_saps.map_tp_sap_1047;  %The process noise along the velocity vector
q_v        = constants.map_saps.map_tp_sap_1047; %The process noise along the vector perpendicular to the velocity vector
sf         = constants.map_saps.map_tp_sap_1160;
elseif flags.maneuver==1
%Process noise values (and one random sap)
q          = constants.map_saps.map_tp_sap_8001;  %The process noise along the velocity vector
q_v        = constants.map_saps.map_tp_sap_8001; %The process noise along the vector perpendicular to the velocity vector
sf         = constants.map_saps.map_tp_sap_1160;    
end

% flags
if exist('flags', 'var')
   if isfield(flags, 'noQ')
      noQ        = flags.noQ;  %1 implies do not use process noise
   else
      noQ        = 0;  %1 implies do not use process noise
   end
   
   if isfield(flags, 'noBkwdProp')
      noBkwdProp = flags.noBkwdProp; %1 implies do not propagate backward
   else
      noBkwdProp = 1; % % Default has no backward propagation
   end
else
   %Flags structure was not passed in, so set default values
   noQ        = 0; % Default to use standard process noise
   noBkwdProp = 1; % % Default has no backward propagation
end %if the flags structure was passed in


%Now, to work on the covariance matrix
%Get the Jacobian
F1 = J_exo_dynamics(sv_rrc, constants, radar);

processNoise = zeros(NSTATES);

if noQ == 0
   u_v = Unit(vel, K1);
   S   = q*(eye(3)-u_v*u_v') + q_v*u_v*u_v';
   
   processNoise(1:3, 1:3) = sf.*S;
   processNoise(4:6, 4:6) = S;
end

%The "derivative" of the covariance matrix.
if noBkwdProp
   P_prime = F1*cov_rrc + cov_rrc*F1' + processNoise;
else
   P_prime = F1*cov_rrc + cov_rrc*F1' - processNoise;
end

if tmpFlag
   P_primeT = zeros(nr, nc);
   P_primeT(1:NSTATES, 1:NSTATES) = P_prime;
   P_primeT(NSTATES+1:nr, NSTATES+1:nc) = zeros(mat_pad);
   
   P_prime = P_primeT;
end

process_noise_terms.qv  = q_v;
process_noise_terms.q   = q;
process_noise_terms.Q1  = processNoise;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
