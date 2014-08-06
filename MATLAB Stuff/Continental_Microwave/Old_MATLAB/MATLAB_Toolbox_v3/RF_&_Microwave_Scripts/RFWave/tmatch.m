% TMATCH   Provides VSWR, reflection coefficient and input impedance
%          for a T matching structure.
%
%	       [VSWR, RHO, ZIN] = TMATCH(LD,LT,AD,AT,D,C,F,ZD)
%
%          LD and LT are the dipole and total T rods lengths, AD and         
%          AT are the dipole and  T rods diameters, D is the spacing
%          between the dipole and the rods. All  dimensions  must be 
%          given in meters. The capacitance C must be provided in pF
%          and the frequency F in MHz.  The desired  input impedance
%          is optional, if nothing is provided the default value  of
%          300 Ohm is assumed. 

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [vswr, rho, zin] = tmatch(ld,lt,ad,at,d,C,f,zd)

if nargin < 8
    zd=300;
end

% Some initial parameters
at=at/2;
ad=ad/2;
lbd=300/f;
u=at/ad;
v=d/ad;
n=acosh((v^2-u^2+1)/2/v)/acosh((v^2+u^2-1)/2/v/u);

% Two wired line impedance
zo=60*log(d^2/ad/at);

% Dipole impedance 
ae=log(ad)+(u^2*log(u)+2*u*log(v))/(1+u)^2;
[ud,za,dd]=dipole(ld/lbd,ae/lbd,0);

% T match impedance
beta=2*pi/lbd; 
zt=j*zo*tan(beta*lt/2);
zin=2*(1+n)^2*zt*za/((1+n)^2*za+2*zt)+2/(j*2*pi*f*C*1e-6)

% VSWR and reflection coef.
rho=(zin-zd)./(zin+conj(zd))*conj(zd)/zd;
mrho=abs(rho);
vswr=(1+mrho)./(1-mrho);
