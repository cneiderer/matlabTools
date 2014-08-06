function F2 = J_boost_dynamics10(sv_rrc, constants, radar)
%     F2 = J_boost_dynamics10(sv_rrc, constants, radar)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculates the Jacobian for a 10-state boosting dynamical
%      model.  Based on Blackman's thrust acceleration model.
%
%   Input:
%        sv_rrc     --  10-state vectors in RRC coordinates (10X1)
%        constants  --  A structure.  The following fields are used.
%           physical_constants
%               mu_e               --  earth gravitational parameter (m^3/s^2)
%           map_saps
%                map_tp_sap_6010  --  Time constant for the inclination
%                                     angle
%                map_tp_sap_6045  --  Time constant for the curvature angle
%        radar
%           site
%               omega_e_x_sq       --  omega_e_X_EC squared
%               twice_omega_e_x    --  2 * omega_e_X
%
%   Output:
%        F2        --  Jacobian matrix (10x10)
%                   
%   Required Functions:
%        Unit      --  
%        Cross3    --  
%


twice_omega_e_x  = radar.site.twice_omega_e_x;
omega_e_X2       = radar.site.omega_e_x_sq;
mu_e             = constants.physical_constants.mu_e;
tau_i            = constants.map_saps.map_tp_sap_6010;
tau_c            = constants.map_saps.map_tp_sap_6045;


r_rrc  = sv_rrc(1:3,1);
v_r    = sv_rrc(4:6,1);
thetaI = sv_rrc(7);  %Theta i, in radians.
thetaC = sv_rrc(8);  %Theta c, in radians.
alpha  = sv_rrc(9);  %alpha, magnitude of thrust acceleration.
i_sp   = sv_rrc(10);

r_norm = norm(r_rrc);
u_r    = r_rrc/r_norm;

v_norm = norm(v_r);

%Unit vectors in the "V" frame
e1 = Unit(v_r, 1);
e2 = Cross3(r_rrc, v_r, 1);
e3 = Cross3(e1, e2, 1);

%Form some usefull matricies
%A skew symmetric matrix using the velocity vector
skewV = [0 -v_r(3) v_r(2); v_r(3) 0 -v_r(1); -v_r(2) v_r(1) 0];

%A skew symmetric matrix using the position vector
skewP = [0 -r_rrc(3) r_rrc(2); r_rrc(3) 0 -r_rrc(1); -r_rrc(2) r_rrc(1) 0];

%A skew symmetric matrix using the e1 vector
skewe1 = [0 -e1(3) e1(2); e1(3) 0 -e1(1); -e1(2) e1(1) 0];

%A skew symmetric matrix using the e2 vector
skewe2 = [0 -e2(3) e2(2); e2(3) 0 -e2(1); -e2(2) e2(1) 0];

%A matrix calculation that occurs many times
eyeMe2 = eye(3) - e2*e2';

%**************************************************************************
%               Start forming the Jacobian
%**************************************************************************

%Looking at the acceleration term.
%First, the derivative of gravity vector with respect to position
dg_dR_RRC = mu_e * (3*u_r*u_r' - eye(3)) / (r_norm^3);

%Next, the derivative of thrust acceleration with respect to position
de1_dR_ECR = zeros(3);

temp    = Cross3(r_rrc, v_r, 0);
tempMag = sqrt( sum(temp.^2, 1) );

de2_dR_ECR = (-1/tempMag) * eyeMe2 * skewV;

de3_dR_ECR = (-1/tempMag) * skewe1 * eyeMe2 * skewV;

term1 = cos(thetaC) .* de1_dR_ECR;
term2 = sin(thetaC) .* de2_dR_ECR;
term3 = sin(thetaI) .* de3_dR_ECR;

dT_dR_ECR = alpha .* (cos(thetaI) .* ( term1 + term2 ) + term3);


%Finally, the derivative of the acceleration with respect to position
dG_dR_ECR = dg_dR_RRC + dT_dR_ECR - omega_e_X2;


%Now, calculate the derivative of the acceleration vector with respect to
%velocity
%First, the derivative of thrust acceleration with respect to velocity
de1_dV_RRC = (1/v_norm) .* (eye(3) - e1*e1');
de2_dV_RRC = (1/tempMag) .* eyeMe2 * skewP;
de3_dV_RRC = -1 .* skewe2 * de1_dV_RRC + skewe1 * de2_dV_RRC;

term1 = cos(thetaC) .* de1_dV_RRC;
term2 = sin(thetaC) .* de2_dV_RRC;
term3 = sin(thetaI) .* de3_dV_RRC;

dT_dV_RRC = alpha .* (cos(thetaI) .* ( term1 + term2 ) + term3);
dG_dV_RRC = dT_dV_RRC - twice_omega_e_x;

dG_y7  = alpha .* ( -sin(thetaI) .* ...
    (cos(thetaC).*e1 + sin(thetaC).*e2) + cos(thetaI).*e3 );

%Corrected dG_y8 and dG_y9
dG_y8  = alpha .* ( cos(thetaI) .* ...
    (-sin(thetaC).*e1 + cos(thetaC).*e2) );
 
dG_y9  = ( cos(thetaI) .* ...
    (cos(thetaC).*e1 + sin(thetaC).*e2) + sin(thetaI).*e3 );

dG_y10 = [0 0 0]';

F2_33 = zeros(4);

F2_33(1,1) = -1/tau_i;
F2_33(2,2) = -1/tau_c;
F2_33(3,3) = 2*alpha/i_sp;
F2_33(3,4) = -(alpha^2)/(i_sp^2);

F2 = zeros(10);

F2(1, 4)   = 1;
F2(2, 5)   = 1;
F2(3, 6)   = 1;

F2(4:6, 1:3)     = dG_dR_ECR ;
F2(4:6, 4:6)     = dG_dV_RRC;
F2(4:6, 7)       = dG_y7;
F2(4:6, 8)       = dG_y8;
F2(4:6, 9)       = dG_y9;
F2(4:6, 10)      = dG_y10;
F2(7:10, 7:10)   = F2_33;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
