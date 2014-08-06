% EXAMPLE 1
% 
% Single rectangular patch
% Freq = 2.45GHz
% Er   = 3.43 (Rogers 4350)
% h    = 1.6mm
%
% Shows directivity calculation, 
% multiple theta cuts and 3D pattern.

close all
clc

help ex1

init;                      % Initialise global variables

freq_config=2.45e9;        % Specify frequency
lambda=3e8/freq_config;    % Calculate wavelength

patchr_config=design_patchr(3.43,1.6e-3,freq_config);
single_element(0,0,0,'patchr',0,0);
plot_geom3D(1,0);
list_array(0);

calc_directivity(5,15);
plot_theta(-90,2,90,[0,45,90],'tot','first');
plot_pattern3D(5,15,'tot','no');

