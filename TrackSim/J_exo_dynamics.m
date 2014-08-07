function F2 = J_exo_dynamics(sv_rrc, constants, radar)
%  F2 = J_exo_dynamics(sv_rrc, constants, radar)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculate the Jacobian of 6-state exoatmospheric dynamics
%
%   Input:
%        sv_rrc                     --  6-state vectors in RRC coordinates,
%                                       where the position has been
%                                       modified to represent the vector
%                                       from earth center.
%
%        constants                  --  Structure of system constants.
%                                       Required fields:
%           physical_constants      --  A structure of physical constants.
%              mu_e                 --  Earth gravitational parameter 
%                                       (m^3/s^2)
%
%        radar
%           site                    --  Site specific values.  Created with 
%                                       'form_site_constants'
%              twice_omega_e_x      --  two times omega_e_x, done to
%                                       eliminate repeated calculations in
%                                       later functions
%              omega_e_x_sq         --  square of omega_e_x
%
%   Output:
%        F2                         --  Jacobian matrix				
%
%   Required Functions:
%        None

twice_omega_e_x  = radar.site.twice_omega_e_x;
omega_e_x_sq     = radar.site.omega_e_x_sq;
mu_e             = constants.physical_constants.mu_e;


r_rrc  = sv_rrc(1:3,1);
r_norm = norm(r_rrc);
u_r    = r_rrc/r_norm;

dG_dR_RRC = mu_e*( 3*u_r*u_r'-eye(3) ) / (r_norm^3) - omega_e_x_sq;

dG_dV_RRC = -1.*twice_omega_e_x;

%The jacobian matrix
F2 = [zeros(3) eye(3); dG_dR_RRC dG_dV_RRC];

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
