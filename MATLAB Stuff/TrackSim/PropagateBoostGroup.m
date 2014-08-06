function derivative = PropagateBoostGroup(sv_rrc, cov_rrc, constants, radar, flags)
%     derivative = PropagateBoostGroup(sv_rrc, cov_rrc, constants, radar, flags);
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculate the time derivative of an earth centered RRC state vector
%      and of an RRC covariance for a boosting object using a 10 state
%      filter.  If there is an error, this function returns an empty 
%      matrix.
%
%        sv_rrc    --  10x1 RRC state vector centered at earth center
%        cov_rrc   --  10x10 RRC covariance matrix for the current time
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
%                map_tp_sap_6010  --  Time constant for the inclination
%                                     angle
%                map_tp_sap_6011  --  The process noise for theta i, the
%                                     inclination angle
%                map_tp_sap_6012  --  The process noise for theta c, the
%                                     curvature angle
%                map_tp_sap_6013  --  The process noise for alpha, the
%                                     magnitude of the thrust acceleration
%                map_tp_sap_6014  --  The process noise for Isp, the
%                                     specific impulse
%                map_tp_sap_6045  --  Time constant for the curvature angle
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
%        derivative     --  Represents either the (10x1) time derivative of
%                           the input state vector, or the 10x10 matrix time
%                           derivative of the input covariance matrix.  If
%                           there is an error, this is empty ( = [] )
%
%   Required Functions:
%        Acceleration        --  
%        J_boost_dynamics10  --  
%        Unit                --  

derivative = [];

if strcmpi(flags.des_fun, 'sv')
   sv_rrcD    = Propagate_sv(sv_rrc, constants, radar);
   derivative = sv_rrcD;
elseif strcmpi(flags.des_fun, 'cov')
   P_prime    = Propagate_cov(sv_rrc, cov_rrc, constants, radar, flags);
   derivative = P_prime;
end %determining which sub function to call

%If error, returns empty results
return


function sv_rrcD = Propagate_sv(sv_rrc, constants, radar)

%Propagate the state vector

NSTATES = 10;

%Indicies for position and velocity in the state vector input
PSN = 1:3;
VEL = 4:6;

%Ensure that sv_rrc is the proper size
[nr, nc] = size(sv_rrc);  %The number of states

if nr ~= NSTATES
   error('PropagateBoostGroup: Input is not of 10 states');
end

if nc ~= 1
   disp(['PropagateBoostGroup: Currently unable to support ' num2str(nc) ' number of vectors']);
   sv_rrcD = [];
   return
end %if the user passed in too many vectors

%Get the position and velocity vectorrs, for ease of reference
r_pos        = sv_rrc(PSN,:);
vel          = sv_rrc(VEL,:);
theta_i      = sv_rrc(7);
theta_c      = sv_rrc(8);
a_thrust_mag = sv_rrc(9);
I_sp         = sv_rrc(10);

tau_i        = constants.map_saps.map_tp_sap_6010;
tau_c        = constants.map_saps.map_tp_sap_6045;

%Get which function to call to calculate the acceleration due to gravity,
%etc.
fun = radar.funs.acceleration_gravity;

%Unit vectors in the "V" frame
e1 = Unit(vel, 1);
e2 = Cross3(r_pos, vel, 1);
e3 = Cross3(e1, e2, 1);

%Calculate the "residual" acceleration terms
[acc_grav, acc_cor, acc_cen] = feval(fun, r_pos, vel, constants, radar);

%Calculate the thrust acceleration, in RRC
a_thrust     = a_thrust_mag .* ...
    ( cos(theta_i) * ( cos(theta_c) .* e1 + sin(theta_c) .* e2 ) + ...
        sin(theta_i) .* e3 );
%
sv_rrcD = ...
   [vel;
   a_thrust + acc_grav + acc_cor + acc_cen;
   -theta_i/tau_i;
   -theta_c/tau_c;
   (a_thrust_mag^2)/I_sp;
   0];
%
return %Propagate_sv





function [P_prime, process_noise_terms] = Propagate_cov(sv_rrc, cov_rrc, constants, radar, flags)

%Propagate the covariance matrix

%Constants
K1      = 1;
NSTATES = 10;

%Indicies for position and velocity in the state vector input
VEL = 4:6;

%Figure out if we need to do any extra stuff if the input is larger than a
%10x10 matrix
[nr, nc] = size(cov_rrc);

if (nr > NSTATES) && (nc > NSTATES)
   mat_pad = nr - NSTATES;
   cov_rrc = cov_rrc(1:NSTATES, 1:NSTATES);
   tmpFlag = true;
else
   tmpFlag = false;
end

%Process noise values (and one random sap)
q          = constants.map_saps.map_tp_sap_1047;  %The process noise along the velocity vector
q_v        = constants.map_saps.map_tp_sap_1047; %The process noise along the vector perpendicular to the velocity vector
q_thetai   = constants.map_saps.map_tp_sap_6011;
q_thetac   = constants.map_saps.map_tp_sap_6012;
q_alpha    = constants.map_saps.map_tp_sap_6013;
q_beta     = constants.map_saps.map_tp_sap_6014;

%Scale factor used to determine the process noise associated with the
%derivative of the position in the covariance matrix
sf         = constants.map_saps.map_tp_sap_1160;

% flags
if exist('flags', 'var')
   if isfield(flags, 'noQ')
      noQ        = flags.noQ;  %1 implies do not use process noise
   else
      noQ        = 0;  %use process noise
   end
   
   if isfield(flags, 'noBkwdProp')
      noBkwdProp = flags.noBkwdProp; %1 implies do not propagate backward
   else
      noBkwdProp = 1; % Default has no backward propagation
   end
else
   %Flags structure was not passed in, so set default values
   noQ        = 0; % Default to use standard process noise
   noBkwdProp = 1; % Default has no backward propagation
end %if the flags structure was passed in


%Get the position and velocity vectorrs, for ease of reference
vel   = sv_rrc(VEL,:);

%Unit vector along the velocity vector
u_v = Unit(vel, K1);

%Now, to work on the covariance matrix
%Get the Jacobian
F2 = J_boost_dynamics10(sv_rrc, constants, radar);

processNoise = zeros(NSTATES);

if ~noQ
   %Wish to use process noise
   P_22 = diag([q_thetai q_thetac q_alpha q_beta]);

   S    = q*(eye(3)-u_v*u_v') + q_v*u_v*u_v';
   
   processNoise(1:3, 1:3)   = sf.*S;
   processNoise(4:6, 4:6)   = zeros(3);
   processNoise(7:10, 7:10) = P_22;
end

%The "derivative" of the covariance matrix.
if noBkwdProp
   P_prime = F2*cov_rrc + cov_rrc*F2' + processNoise;
else
   P_prime = F2*cov_rrc + cov_rrc*F2' - processNoise;
end

if tmpFlag
   %Do this if we are using more states in our largest filter than this
   %model contains
   P_primeT                             = zeros(nr, nc);
   P_primeT(1:NSTATES, 1:NSTATES)       = P_prime;
   P_primeT(NSTATES+1:nr, NSTATES+1:nc) = zeros(mat_pad);
   
   P_prime = P_primeT;
end

process_noise_terms.qv  = q_v;
process_noise_terms.q   = q;
process_noise_terms.Q1  = processNoise;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
