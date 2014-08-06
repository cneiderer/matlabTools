% GMATCH   Provides VSWR, reflection coefficient and input impedance
%          for a gamma matching structure.
%
%	       [VSWR, RHO, ZIN] = GMATCH(LD,LG,AD,AG,D,C,F,ZD)
%
%          LD and LG are the dipole and gamma rod lengths, AD and AG
%          are the dipole and gamma rod diameters,  D is the spacing
%          between the dipole and the rod.  All  dimensions  must be 
%          given in meters. The capacitance C must be provided in pF
%          and the frequency F in MHz.  The desired  input impedance
%          is optional, if nothing is provided the default value  of
%          50 Ohm is assumed. 

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [vswr, rho, zin] = gmatch(ld,lg,ad,ag,d,C,f,zd)

if nargin < 8
    zd=50;
end

% Some initial parameters
ag=ag/2;
ad=ad/2;
lbd=300/f;
u=ag/ad;
v=d/ad;
n=acosh((v^2-u^2+1)/2/v)/acosh((v^2+u^2-1)/2/v/u);
% Fator de Divisao de Corrente
alpha=log(v)/(log(v)-log(u));

% Two wired line impedance
zo=60*log(d^2/ad/ag);

% Dipole impedance 
ae=exp(log(ad)+(u^2*log(u)+2*u*log(v))/(1+u)^2);
[ud,za,dd]=dipole(ld/lbd,ae/lbd,0);

% Gamma match impedance
beta=2*pi/lbd; 
zt=j*zo*tan(beta*lg);
zin=(1+n)^2*zt*za/((1+n)^2*za+2*zt)+1/(j*2*pi*f*C*1e-6);

% VSWR e Coef. de Reflexao
rho=(zin-zd)./(zin+conj(zd))*conj(zd)/zd;
mrho=abs(rho);
vswr=(1+mrho)./(1-mrho);
