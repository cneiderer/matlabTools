% GMATCHS  Provides the gamma rod length in meters and the capacitor
%          value in pF for a gamma matching structure.
%
%	       [LG, C] = GMATCHS(L,A,D,F,ZD)
%
%          L is the dipole length, A is the dipole diameter and D is
%          the spacing  between  the dipole  and  the gamma rod. All 
%          dimensions  must  be given in meters and the  frequency F
%          in  MHz.  The desired  input  impedance  is  optional, if 
%          nothing  is  provided  the  default  value  of  50 Ohm is 
%          used. Finally, the rod diameter is assumed to be equal to
%          A.

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [lg,C] = gmatchs(l,a,d,f,zd)

if nargin < 5
    zd=50;
end

% Some initial parameters
lbd=300/f;
a=a/2;
u=1;
v=d/a;
n=1;

% Two wired line impedance
zo=120*log(v);

% Dipole impedance 
ln=l/lbd;
ae=sqrt(a*d);
an=ae/lbd;
[ud,za,dd]=dipole(ln,an,0);

% Gamma rod length and capacitance for the series capacitor
lgn=0.001:0.001:ln/2;
zt=j*zo*tan(2*pi*lgn);
zin=2*zt*za./(2*za+zt);
rin=real(zin);
xin=imag(zin);
[z,inx]=min(abs(rin-zd));
C=1e6/(2*pi*f*xin(inx));
lg=lgn(inx)*lbd;
