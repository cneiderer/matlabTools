% HELICAL  Provides the radiation intensity U, the gain GA (in dBi),  
%          the input impedance ZIN and the front-back ratio  FBR (in
%          dB) for a helical antenna. 
%
%          [U, GA, ZIN, FBR] = HELICAL(D,ALPHA,N)
%
%          D  is helical diameter in wavelength,  ALPHA is the pitch 
%          angle in degree and  N the number of turns.  Values of  D 
%          must  be  within  the  range  0.24 < D < 0.42  and  alpha 
%          12 < ALPHA < 14 degrees. 
%

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [u,ga,zin,fbr] = helical(d,alp,n)

if n < 4
    error('N must be greater than 3.');
end
k=2*pi;
alp=alp*pi/180;
c=pi*d;
a=d/2;
s=c*tan(alp);
l=s/sin(alp);
aux=(2*n+1)/2/n;
p=l/(s+aux);

% Radiation intensities
th=0:pi/(pi*100):2*pi-pi/(pi*100);
psi=2*pi*(s*cos(th)-l/p);
AF=sin(0.5*pi/n)*sin(n*psi/2)./sin(psi/2);
e=AF.*cos(th);

u=e.^2;
u=u/max(u);

% Antenna gain
ga=10*log10(15*c^2*n*s);

% Input impedance and front-back ratio
zin=140*c;
fbr=10*log10(u(1)/u(314));

