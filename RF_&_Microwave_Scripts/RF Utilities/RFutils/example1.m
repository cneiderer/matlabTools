% Example1 
%
% Showing how to plot impedances using smith.m and smdrawc.m
% using an impedance matching transformer as an example.
%
% Open this file and look through the comments.

% N.Tucker www.activefrance.com 2008

clc;
close all;
fprintf('\n\n\n***** Example 1 *******\n\n\n');
help example1;
% Set up some variables to use in the example
Zo=50;             % 50 ohm impedance for smith chart
Freq=800:10:1000;  % Frequency vector 100 to 1000 MHz in 10MHz steps
Z1=(10+8*j);       % Single value load impedance

% Generate a realistic imedance locii for Zload by transforming
% Z1 through a short section of transmission line of slightly different
% impedance to the single value Z1. The single value Z1 is vectorised 
% by trl.m over the range of frequencies in Freq.
Zload=trl((Z1+2+2*j),Z1,600,Freq,1,0); 

% Set up the parameters for the impedance matching transformer
% Try experimenting with different values.
ZoT=20;            % Transmission line transformer impedance (ohms)
l=38;              % Length of transmission line (mm)
Er=2.2;            % Dielectric constant for transmission line
LdB=0.1;           % Loss for transmission line (dB/m)

% Calculate impedance looking into transmission line
Zin=trl(ZoT,Zload,l,Freq,Er,LdB);  

% Plot the results on admittance chart (figure2 default)
sadmit(1,50);           % Plot Admittance Chart at scale=1 and Zo=50 Ohms
smdrawc(Zload,50,'g-'); % Plot the load impedance Zload using Zo=50 Ohms
smdrawc(Zin,50,'r-');   % Plot the impedance Zin using Zo=50 Ohms 
samarker1(Zload,Freq,Zo,880,1);  % Put marker No.1 on Zload at 880 MHz
samarker1(Zin,Freq,Zo,880,2);    % Put marker No.2 on Zin at 880 MHz

% Plot the results on a smith chart (figure1 default)
smith(1,50);            % Plot Smith Chart at scale=1 and Zo=50 Ohms
smdrawc(Zload,50,'g-'); % Plot the load impedance Zload using Zo=50 Ohms
smdrawc(Zin,50,'r-');   % Plot the impedance Zin using Zo=50 Ohms 
smarker1(Zload,Freq,Zo,880,1);  % Put marker No.1 on Zload at 880 MHz
smarker1(Zin,Freq,Zo,880,2);    % Put marker No.2 on Zin at 880 MHz

