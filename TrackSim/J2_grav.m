function g = J2_grav(p, uP, constants)
%     g = J2_grav(p, uP, constants)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculates the gravity vector based on position in RRC coordinates
%      measured from earth center.
%
%   Input:
%        p          --  position vectors 3 x 1 in RRC coordinates measured
%                       from the center of the Earth
%        uP         --  3x1 unit vector in the direction of the earth
%                       centered (ECR or ECI) z vector, in RRC 
%        constants  --  Structure of system constants.  Required fields:
%           physical_constants.j2     --  2nd zonal harmonic
%           physical_constants.mu_e   --  earth gravitational parameter
%                                         (m^3/s^2)
%           physical_constants.re_sq  --  square of the equatorial
%                                         earth radius
%
%   Output:
%        g -- 3x1 gravity gradient vector
%
%   Required Functions:
%        None.
%


% Physical constants
J2    =   constants.physical_constants.j2;
mu_e  =   constants.physical_constants.mu_e;
re_sq =   constants.physical_constants.re_sq;


magP  =   sqrt( sum( p.^2 ) );
uR    =   p ./ magP;

rSq   =   magP * magP;

cPhi  =   dot(uR, uP);

c1    =   5.0 .* cPhi.^2 - 1; 

Outerm = -mu_e / rSq;

Legendre_Grad_2 = 3.0 * cPhi;
Legendre_Grad_3 = 1.5 * c1;

Re_Rn_2 = re_sq / rSq;

K1 = Outerm * (1.0 - J2 * Re_Rn_2 * Legendre_Grad_3);
K2 = Outerm * (-J2 * Re_Rn_2 * Legendre_Grad_2);

g = K1 .* uR - K2 .* uP;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
