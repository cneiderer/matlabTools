% PARAB    Provides  the radiation intensity  U, the antenna gain GA 
%          in dBi and the aperture efficiency (in %) for a parabolic
%          reflector. 
%
%          [U, GA, EAP] = PARAB(D,F,SG)
%
%          D is the reflector diameter, F the focal distance and SG  
%          the surface standard deviation.  All input variable must 
%          be provided in wavelength units. The radiation intensity
%          U  is  produced  by  considering  that the  reflector is 
%          illuminated uniformly.        

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [u,ga,eap] = parab(d,f,sg)

a=d/2;
c=pi*d;

% Aperture angle
th0=2*atan(a/f/2);

% Aperture efficiency
eap=2400*(sin(th0/2)^2+log(cos(th0/2)))^2*cot(th0/2)^2;

% Antenna diretivity and gain
do=eap/100*c^2*exp(-(4*pi*sg)^2);
ga=10*log10(do);

% Radiation intensity
th=pi/500:pi/500:2*pi;
e=(1+cos(th)).*(bessel(1,c*sin(th))./sin(th)/c);
u=abs(e).^2;
u=u/max(u);
