% FDIPOLES Provides the  dipole  length in meters and the capacitors
%          values in pF for a folded dipole.
%
%	       [LT, C] = FDIPOLES(A,F,ZD)
%
%          A is the dipole diameter in meters and F is the frequency 
%          in  MHz.  The desired  input  impedance  is  optional, if 
%          nothing  is provided  the  default  value  of  300 Ohm is 
%          used. 

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [l,C] = fdipoles(a,f,zd)

if nargin < 3
    zd=300;
end

% Some initial parameters
lbd=300/f;
u=1;
v=0.1/a;
n=1;

% Two wired line impedance
zo=120*log(v);

% Dipole impedance
ln=0.01:0.01:0.5;
a=log(a*0.1)/2;
c=0.5772;
eta=120*pi;
kl=2*pi*ln;
ci1=ci(kl);
ci2=ci(2*kl);
ci3=ci(4*pi*a^2./ln);
si1=si(kl);
si2=si(2*kl);
rr=c+log(kl)-ci1+0.5*sin(kl).*(si2-2*si1);
rr=0.5*eta/pi*(rr+0.5*cos(kl).*(c+log(kl/2)+ci2-2*ci1));
xm=2*si1+cos(kl).*(2*si1-si2);
xm=0.25*eta/pi*(xm-sin(kl).*(2*ci1-ci2-ci3));
rin=rr./sin(kl/2).^2;
xin=xm./sin(kl/2).^2;
za=rin+j*xin;

% Dipole length and capacitance for the two capacitors
zt=j*zo*tan(pi*ln);
zin=4*zt.*za./(2*za+zt);
rin=real(zin);
xin=imag(zin);
plot(ln,rin);grid;
[z,inx]=min(abs(rin-zd));
C=1e6/(pi*f*xin(inx));
l=ln(inx)*lbd;

