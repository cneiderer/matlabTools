% EXAMPLE 2
%
% 5x5 array of half-wave dipoles 0.25 lambda over a groundplane
% X-Y spacing 0.7 lambda. Frequency 1GHz
%
% Theta Squints of 0,10,20,30 Degrees are applied in 
% the phi=90 plane.

close all
clc

help ex2

init;                    % Initialise global variables

freq_config=1e9;
lambda=3e8/freq_config;  % Calculate wavelength

% Dipole over ground parameters
len=0.5*lambda;          % Length (m)
h=0.25*lambda;           % Height above ground (m)
dipoleg_config=[len,h];  % Define vector of parameters

rect_array(5,5,0.7*lambda,0.7*lambda,'dipoleg',0); % 25-element array
list_array(0);
plot_geom3D(0,0);
plot_geom2D(0,1);
plot_squint_theta(-90,2,90,90,90,[0,10,20,30],'tot','first');

