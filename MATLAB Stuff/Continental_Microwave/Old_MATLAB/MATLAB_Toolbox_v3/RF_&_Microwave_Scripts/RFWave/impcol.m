
% IMPMUT Provides the mutual impedance between dipoles placed
%        side by side.
%
%        Z21 = IMPCOL(H,L)
%
%        H is the dipole distance, center to center, and L the dipole length, both
%        must be given in wavelength.
% 

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function Z21i = impcol(h,l)

lam=1;
k=2*pi/lam;
v0=k*h;
v1=2*k*(h+l);
v2=2*k*(h-l);
v3=(h.^2-l.^2)/h.^2;
Rcos=-15*cos(v0).*(-2*ci(2*v0)+ci(v1)+ci(v2)-log(v3));
Rsin=15*sin(v0).*(2*si(2*v0)-si(v1)-si(v2));
R21m=Rcos+Rsin;
Xcos=-15*cos(v0).*(2*si(2*v0)-si(v1)-si(v2));
Xsin=15*sin(v0).*(2*ci(2*v0)-ci(v1)-ci(v2)-log(v3));
X21m=Xcos+Xsin;
Z21m=R21m+j*X21m;
Z21i=Z21m*1/((sin(k*l/2))^2);
