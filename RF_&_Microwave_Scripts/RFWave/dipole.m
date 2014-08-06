% DIPOLE   Provides the radiation intensity U,  input impedance  ZIN
%          and diretivity D for normalized dipole length and radius.
%
%          [U,ZIN,D]= DIPOLE(L,A,TH0)
%
%          L  and  A  are  the  normalized dipole length and radius, 
%          respectively. TH0 defines the dipole  orientation  (0 for 
%          z-axis and 90 for the plane xy).
%

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [u,zin,d]= dipole(l,a,tho)

if nargin < 3
    tho=0;
end

% Radiation intensity and directivity
k=2*pi;
kl=k*l;
tho=pi*tho/180;
th=pi/200:pi/200:2*pi;
lth=length(th);
u=((cos(kl/2*cos(th+tho))-cos(kl/2))./(sin(th+tho)+eps)).^2;
umax=max(u);
intu=trapz(th(1:200),u(1:200).*sin(th(1:200)));
d=2*umax/intu;
u=u/umax;

% Input impedance
c=0.5772;
zo=120*pi;
ci1=ci(kl);
ci2=ci(2*kl);
ci3=ci(4*pi*a^2/l);
si1=si(kl);
si2=si(2*kl);
rr=c+log(kl)-ci1+0.5*sin(kl)*(si2-2*si1);
rr=0.5*zo/pi*(rr+0.5*cos(kl)*(c+log(kl/2)+ci2-2*ci1));
xm=2*si1+cos(kl)*(2*si1-si2);
xm=0.25*zo/pi*(xm-sin(kl)*(2*ci1-ci2-ci3));
rin=rr/sin(kl/2)^2;
xin=xm/sin(kl/2)^2;
zin=rin+j*xin;

