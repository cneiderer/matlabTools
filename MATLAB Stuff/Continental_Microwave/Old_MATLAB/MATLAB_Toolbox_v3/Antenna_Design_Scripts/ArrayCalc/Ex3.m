% EXAMPLE 3
% 
% Interpolated half-wave Dipole pattern rotated 35Deg 
% about the Yaxis. Freq = 300 MHz
%
% Source files are :  dipole.nec   The NEC2 model used to generate data
%                     dipole.out   Data for interpolation 
%
% Nec data has been calculated in 10deg steps in theta and phi.
% Demonstrates the use of the 'interp' element type

close all
clc

help ex3

init;                      % Initialise global variables

lambda=3e8/freq_config;    % Calculate wavelength

loadnecpat1('dipole');
load pattern1;

place_element(1,0,0,0,0,0,0,'interp',0,0);
yrot_array(35,1,3);
calc_directivity(10,10);
list_array(0);             % List array details
plot_geom3d(1,0);
plot_theta(-180,5,180,[0,45,90],'tot','none');
plot_pattern3d(10,10,'tot','no');