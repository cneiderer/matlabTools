% OMATCH   Provides VSWR, reflection coefficient and input impedance
%          for a omega matching structure.
%
%	       [VSWR, RHO, ZIN] = OMATCH(LD,LG,AD,AG,D,Cs,Cp,F,ZD)
%
%          LD and LG are the dipole and gamma rod lengths, AD and AG
%          are the dipole and gamma rod diameters,  D is the spacing
%          between the dipole and the rod.  All  dimensions  must be 
%          given in  meters.  The  shunt and series capacitances  Cs
%          and  Cp must be provided in pF whereas the frequency F is
%          in  MHz.  The desired input impedance  ZD is optional, if 
%          nothing  is  provided  the  default  value  of  50 Ohm is
%          assumed. 

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil
     
function [vswr, rho, zin] = omatch(ld,lg,ad,ag,d,Cs,Cp,f,zd)

if nargin < 9
    zd=50;
end

% Some initial parameters
lbd=300/f;
u=ag/ad;
v=d/ad;
n=acosh((v^2-u^2+1)/2/v)/acosh((v^2+u^2-1)/2/v/u);
% Fator de Divisao de Corrente
alpha=log(v)/(log(v)-log(u));

% Two wired line impedance
zo=60*log(d^2/ad/ag);

% Dipole impedance 
ae=log(ad)+(u^2*log(u)+2*u*log(v))/(1+u)^2;
[ud,za,dd]=dipole(ld/lbd,ae/lbd,0);

% Omega match impedance
beta=2*pi/lbd; 
if Cp==0
    Cp=1e-32;
end
zc=1/(j*2*pi*f*Cp*1e-6)    
zt=j*zo*tan(beta*lg);
zt=1./(1./zt+1/zc);
zin=(1+n)^2*zt*za/((1+n)^2*za+2*zt)+1/(j*2*pi*f*Cs*1e-6);

% VSWR and reflection coef.
rho=(zin-zd)./(zin+conj(zd))*conj(zd)/zd;
mrho=abs(rho);
vswr=(1+mrho)./(1-mrho);
