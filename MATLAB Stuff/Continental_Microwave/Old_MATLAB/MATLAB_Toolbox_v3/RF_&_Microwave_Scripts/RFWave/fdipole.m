% FDIPOLE  Provides VSWR, reflection coefficient and input impedance
%          for a folded dipole.
%
%	       [VSWR, RHO, ZIN] = FDIPOLE(L,A,D,C,F,ZD)
%
%          L is the dipole length, A is the dipole diameter and D is 
%          the  folding  spacing.  All dimensions  must  be given in 
%          meters.  The capacitance C must be provided in pF and the 
%          frequency  F  in  MHz.  The  desired  input  impedance is 
%          optional, if nothing is provided the default value of 300
%          Ohm is assumed. 

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [vswr, rho, zin] = fdipole(l,a,d,C,f,zd)


if nargin < 6
    zd=300;
end

% Some initial parameters
lbd=300/f;
u=1;
v=d/a;
n=1;;

% Two wired line impedance
zo=120*log(d/a);

% Dipole impedance 
ae=log(a*d)/2;
[ud,za,dd]=dipole(l/lbd,ae/lbd,0);

% Folded dipole match impedance
beta=2*pi/lbd; 
zt=j*zo*tan(beta*l/2);
zin=4*zt*za/(2*za+zt)+2/(j*2*pi*f*C*1e-6);

% VSWR and reflection coef.
rho=(zin-zd)./(zin+conj(zd))*conj(zd)/zd;
mrho=abs(rho);
vswr=(1+mrho)./(1-mrho);
