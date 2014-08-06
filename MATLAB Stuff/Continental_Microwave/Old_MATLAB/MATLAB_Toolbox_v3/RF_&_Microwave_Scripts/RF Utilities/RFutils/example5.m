% Example5 
%
% Showing how to plot impedances imported from a CITI file 
% using citi.m
%
% The pathname in the citi1(pathname)call must point to a CITI file
% e.g. C:\matlab\toolbox\rfutils\data01.d1
% Depending on your installation directory, this may need to be
% changed, see citi1.m calls in this script.
%
% The example CITI files are for three test dipole antennas.
% The files need to be for a 1-port measurement saved with 
% 'Data Only', 'ASCII' options set.
%
% Open this file and look through the comments.

% N.Tucker www.activefrance.com 2008

clc;
close all;
fprintf('\n\n\n***** Example 5 *******\n\n\n')
help example5;

[Z1,Freq]=citi1('C:\matlab\toolbox\rfutils\data01.d1');
[Z2,Freq]=citi1('C:\matlab\toolbox\rfutils\data02.d1');
[Z3,Freq]=citi1('C:\matlab\toolbox\rfutils\data03.d1');

% Plot the results on a smith chart (figure1 default)
smith(1,50);            % Plot Smith Chart at scale=1 and Zo=50 Ohms
smdrawc(Z1,50,'r-');    % Plot the impedance Z1 using Zo=50 Ohms 
smdrawc(Z2,50,'g-');    % Plot the impedance Z2 using Zo=50 Ohms
smdrawc(Z3,50,'c-');    % Plot the impedance Z3 using Zo=50 Ohms

% Plot results as Return Loss
rlossc(Z1,Freq,50,'r-');
rldrawc(Z2,Freq,50,'g-');
rldrawc(Z3,Freq,50,'c-');