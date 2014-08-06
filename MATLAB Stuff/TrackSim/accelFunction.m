function [yDot]= accelFunction (t,y,whatever,constants,radar);
% ---------------------------------------------
%
%
%   [yDot]= accelFunction (t,y);
% ---------------------------------------------

%Get the position and velocity vectorrs, for ease of reference
r_pos        = y(1:3,:);
vel          = y(4:6,:);



if t>400 && t<460
    t0=400;
    Isp=2100;
    alpha_0=20;
    alpha_r=1./((1/alpha_0)-(t-t0)/Isp);
elseif t>460 && t<480
    t0=120;
    Isp=2100;
    alpha_r=8;
elseif t>525 && t<575
    t0=120;
    alpha_r=3;
elseif t>280.5 && t<286
    t0=120;
    alpha_r=3;
else
    alpha_r=0;
end

theta_i=0;
theta_c=0;

%Unit vectors in the "V" frame
e1 = Unit(vel, 1);
e2 = Cross3(r_pos, vel, 1);
e3 = Cross3(e1, e2, 1);

%Calculate the "residual" acceleration terms
[acc_grav, acc_cor, acc_cen] = feval('Acceleration', r_pos+radar.site.r0_rrc, vel, constants, radar);

%Calculate the thrust acceleration, in RRC
a_thrust     = alpha_r .* ...
    ( cos(theta_i) * ( cos(theta_c) .* e1 + sin(theta_c) .* e2 ) + ...
    sin(theta_i) .* e3 );

yDot = ...
    [vel;
    a_thrust + acc_grav + acc_cor + acc_cen;];