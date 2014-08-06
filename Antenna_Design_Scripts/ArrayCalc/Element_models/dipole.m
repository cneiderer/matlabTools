function Etot=dipole(theta_in,phi_in)
% Calculates total E-field pattern for dipole as a function
% of theta and phi.
%
% Usage: Etot=dipole(theta,phi)
%
% Dipole length is defined in global variable dipole_config
% initialised in init.m
%
% length.....Length of dipole (m)
%
% Reference C.A. Balanis 2nd edition page 153

global freq_config;
global dipole_config;

dlen=dipole_config;

lambda=3e8/freq_config;
k=2*pi/lambda;


% Convert array local element coords into dipole model coords.
% Conversion is ccw rotation about the y-axis.

[xff,yff,zff]=sph2cart1(999,theta_in,phi_in);
xffd=-zff;
yffd=yff;
zffd=xff;
[r,th,ph]=cart2sph1(xffd,yffd,zffd);

% Dipole pattern function ref C.Balanis
F1=cos((k*dlen/2)*cos(th));
F2=cos(k*dlen/2);
Ftheta=(F1-F2)./sin(th);

Etot=Ftheta;
