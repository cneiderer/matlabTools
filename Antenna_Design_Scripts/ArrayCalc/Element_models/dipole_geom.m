function geom=dipole_geom()
% Geometry definition for dipole element
%
% Usage: geom=dipole_geom()

global dipole_config

dlen=dipole_config(1,1);
geom(1:3,1)=[-0.5*dlen ; 0  ;0  ]; % Left hand end
geom(1:3,2)=[ 0.5*dlen ; 0  ;0  ]; % Right hand end

