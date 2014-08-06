% TMATCHS  Provides the  T rods lengths in meters and the capacitors
%          values in pF for a T matching structure.
%
%	       [LT, C] = TMATCHS(L,A,D,F,ZD)
%
%          L is the dipole length, A is the dipole diameter and D is
%          the  spacing  between  the  dipole  and  the T rods.  All 
%          dimensions  must  be given in meters and the  frequency F
%          in  MHz.  The desired  input  impedance  is  optional, if 
%          nothing  is provided  the  default  value  of  300 Ohm is 
%          used. Finally, the rod diameter is assumed to be equal to
%          A.

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [lt,C] = tmatchs(l,a,d,f,zd)

if nargin < 5
    zd=300;
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
ae=sqrt(a*d);
ln=l/lbd;
an=ae/lbd;
[ud,za,dd]=dipole(ln,an,0);

% T rods length and capacitance for the two capacitors
%ltn=0.001:0.001:0.25;
ltn=0.001:0.001:ln/2;
zt=j*zo*tan(2*pi*ltn);
zin=4*zt*za./(2*za+zt);
rin=real(zin);
xin=imag(zin);
[z,inx]=min(abs(rin-zd));
C=1e6/(pi*f*xin(inx));
lt=ltn(inx)*lbd;

