function [acc_grav, acc_cor, acc_cen] = Acceleration(r_pos, vel, constants, radar)
%     [acc_grav, acc_cor, acc_cen] = Acceleration(r_pos, vel, constants, radar)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculates accelerations due to gravity and rotating frame.
%
%   Input:
%        r_pos      --  position vector (3x1) in RRC measured
%                       from the center of the Earth
%        vel        --  velocity vector (3x1) in RRC
%        constants
%           physical_constants.j2     --  2nd zonal harmonic
%           physical_constants.mu_e   --  earth gravitational parameter
%                                         (m^3/s^2)
%           physical_constants.re_sq  --  square of the equatorial
%                                         earth radius
%        radar      --  Structure of system constants.  Required fields:
%           site.twice_omega_e_x  --  2 * the earth rotation rate
%           site.omega_e_x_sq     --  the square of the earth rotation rate
%           site.up               --  3x1 unit vector in the direction of
%                                     the earth centered (ECR or ECI) z
%                                     vector, in RRC
%
%   Output:
%        acc_grav  --  gravity acceleration
%        acc_cor   --  corriolis acceleration
%        acc_cen   --  centrepital acceleration
%
%   Required Functions:
%        J2_grav

%The input, r_pos, is already earth centered in the RRC coordinate
%system.  This means the position vector represents a vector in RRC from
%the center of the earth to the object.

twice_omega_e_x  = radar.site.twice_omega_e_x;
omega_e_x_sq     = radar.site.omega_e_x_sq;
uP               = radar.site.up;

%Calculate Coriolis and Centrifugal accelerations to account for rotating
%Earth
acc_cor  = -twice_omega_e_x * vel;
acc_cen  = -omega_e_x_sq * r_pos;

%Calculate gravity using spherical harmonic expansion
acc_grav = J2_grav(r_pos, uP, constants);

return

%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
