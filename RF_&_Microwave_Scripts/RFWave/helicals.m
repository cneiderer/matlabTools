% HELICALS Provides the diameter D and turn spacing S in wavelength,
%          the number of turns  N and the front-back ratio FBR in dB
%          for a helical antenna. 
%
%          [D, S, N, FBR] = HELICALS(GA,ZIN)
%
%          GA  is  the  antenna  gain in  dBi and  ZIN  is the input 
%          impedance within the range 105 < ZIN < 186 Ohms.
%

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [d,s,n,fbr] = helicals(ga,zin)

c=zin/140;
alp=13/180*pi;
s=c*tan(alp);
d=c/pi;
l=s/sin(alp);
k=2*pi;

% Number of turns
ga=10^(ga/10);
n=ceil(ga/(15*c^2*s));

% Relative current wave velocity
aux=(2*n+1)/2/n;
p=l/(s+aux);

% Radiation intensities
th=0:pi/(pi*100):2*pi-pi/(pi*100);
psi=2*pi*(s*cos(th)-l/p);
AF=sin(0.5*pi/n)*sin(n*psi/2)./sin(psi/2);
e=AF.*cos(th);

u=e.^2;
u=u/max(u);

% Front-back ratio
fbr=10*log10(u(1)/u(314));

