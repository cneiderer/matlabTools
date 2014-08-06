% OMATCHS  Provides  the gamma  rod  length in meters and the series
%          capacitor value in pF for a omega matching structure.
%
%	       [LG, CS] = OMATCHS(L,A,D,F,CP,ZD)
%
%          L is the dipole length, A is the dipole diameter and D is
%          the spacing  between  the dipole  and  the gamma rod. All 
%          dimensions  must  be given in meters and the  frequency F
%          in  MHz.  CP is the shunt capacitor in  pF.  The  desired
%          input impedance ZD is optional,  if nothing  is  provided
%          the  default  value  of  50 Ohm is used. Finally, the rod
%          diameter is assumed to be equal to A.

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [lg,Cs] = omatchs(l,a,d,f,Cp,zd)

if nargin < 6
    zd=50;
end

% Some initial parameters
lbd=300/f;
u=1;
v=d/a;
n=1;

% Two wired line impedance
zo=120*log(v);

% Dipole impedance 
ae=log(a*d)/2;
[ud,za,dd]=dipole(l/lbd,ae/lbd,0);

% Gamma rod length and capacitance for the series capacitor
if Cp==0
    Cp=1e-32;
end
lgn=0.00001:0.00001:0.05;
zc=1/(j*2*pi*f*Cp*1e-6)    
zt=j*zo*tan(2*pi*lgn);
zt=1./(1./zt+1/zc);
zin=2*zt*za./(2*za+zt);
rin=real(zin);
xin=imag(zin);
[z,inx]=min(abs(rin-zd));
Cs=1e6/(2*pi*f*xin(inx));
lg=lgn(inx)*lbd;

