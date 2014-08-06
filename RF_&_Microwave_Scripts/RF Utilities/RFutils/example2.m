% Example2 
%
% Showing how to plot impedances using scomb.m and smdrawc.m
% using lumped elements as an example.
%
% Open this file and look through the comments.

% N.Tucker www.activefrance.com 2008

clc;
close all;
fprintf('\n\n\n***** Example 2 *******\n\n\n');
help example2;
% Set up some variables to use in the example
Zo=50;             % 50 ohm impedance for smith chart
Freq=800:10:1000;  % Frequency vector 100 to 1000 MHz in 10MHz steps
Z1=(10+8*j);       % Single value load impedance

% Generate a realistic imedance locii for Zload by transforming
% Z1 through a short section of transmission line of slightly different
% impedance to the single value Z1. The single value Z1 is vectorised 
% by trl.m over the range of frequencies in Freq.

Zload=trl((Z1+2+2*j),Z1,600,Freq,1,0); 

% Calculate impedance with lumped components
Z1=lseries(Zload,2e-9,Freq);  % 2.0nH series inductor
Zin=cshunt(Z1,6.5e-12,Freq);  % 6.5pF shunt capacitor


% Plot the results on a smith / admittance chart (figure3 default)
scomb(1,50);            % Plot Smith Chart at scale=1 and Zo=50 Ohms
smdrawc(Zload,50,'g-'); % Plot the load impedance Zload using Zo=50 Ohms
smdrawc(Z1,50,'c-');    % Plot intermediate impedance Z1 using Z0=50 Ohms
smdrawc(Zin,50,'r-');   % Plot the impedance Zin using Zo=50 Ohms 
smarker1(Zload,Freq,Zo,880,1);  % Put marker No.1 on Zload at 880 MHz
smarker1(Z1,Freq,Zo,880,2);     % Put marker No.2 on Z1 at 880 MHz
smarker1(Zin,Freq,Zo,880,3);    % Put marker No.3 on Zin at 880 MHz

