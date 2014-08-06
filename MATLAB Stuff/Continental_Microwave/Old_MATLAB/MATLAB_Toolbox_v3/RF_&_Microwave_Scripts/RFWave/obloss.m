% OBLOSS   Provides the radio link attenuation  ATT (in dB) due to a
%          a  rounded obstacle and the Fresnel radius  RF  (in m) at 
%          the obstacle plane.
%
%	       [ATT, RF] = OBLOSS(D,DO,F,H,RC)
%
%          D  is the radio link length  and  DO the distance between 
%          the transmitter  and obstacle,  both in kilometers.  F is 
%          the operating frequency in  MHz.  H is the height between 
%          the line of sight  and the top of the obstacle whereas RC
%          is  the curvature  radius of the obstacle,  both variable
%          must be provided in meters. If RC is equal to zero or not
%          given, the obstacle will be consider as a knife edge.
%          

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [att,rf]=obloss(d,do,f,h,rc)

if nargin < 5
    rc=0;
end

% Initial setup
f=f*1e6;
d=d*1e3;
d1=do*1e3;
d2=d-d1;
c=3e8;
lb=c/f;

% Fresnel radius
rf=sqrt(d1*d2*lb/d);

if h/rf < -0.56
    att=0;
else
    % Constant alpha
    alfa=lb^(2/3)*rc^(1/3)/rf;

    % Constant v and rho
    v=sqrt(2)*h/rf;
    rho=(1/pi)^(1/6)*alfa;

    % Obstacle attenuation
    if ((v>=-0.8)&(v<0)),
        av=20*log10(0.5-0.62*v);
    elseif ((v>=0)&(v<1)),
        av=20*log10(0.5*exp(-0.95*v));
    elseif (v>=1)&(v<2.4),
        av=20*log10(0.4-sqrt(0.1184-(0.38-0.1*v)^2));
    elseif (v>=2.4),
        av=20*log10(0.225/v);
    end
    if rho>=1.4,
        error('It is not possible to compute the obstacle loss for these values.');
    else
        arho=6+7.19*rho-2.02*rho^2+3.63*rho^3-0.75*rho^4;
    end   
    vr=v*rho;
    if vr<2,
        u=(43.6+23.5*vr)*log10(1+vr)-6-6.7*vr;
    else
        u=22*vr-20*log10(vr)-14.13;
    end
    att=-av+arho+u;
end







