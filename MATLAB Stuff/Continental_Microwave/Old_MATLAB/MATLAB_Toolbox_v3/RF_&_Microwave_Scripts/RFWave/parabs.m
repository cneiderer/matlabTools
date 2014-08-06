% PARABS   Provides  the  diameter  D and  the focal  distance F in 
%          wavelength for parabolic reflector.
%
%          [D, F] = PARABS(GA,SG)
%
%          GA is the antenna gain in DBi and SG the surface standard
%          deviation in wavelength. 

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [d,f] = parabs(ga,sg)

eap=0.8288;
th0=1.1624;

% Reflector diameter 
do=10^(ga/10);
c=sqrt(do/(eap*exp(-(4*pi*sg)^2)));
d=c/pi;

% Focal distance
f=d/4*tan(th0/2);

