% Example8 
%
% Showing how to plot input and transmission parameters,
% imported from a CITI file using citi2s.m
%
% The pathname in the citi2s(pathname)call must point to a CITI file
% e.g. C:\matlab\toolbox\rfutils_s\data04.d2
% Depending on your installation directory, this may need to be
% changed, see citi2s.m calls in this script.
%
%  The files need to be for a 2-port measurement saved with 
% 'Data Only', 'ASCII' options set.
%
% Open this file and look through the comments.

% N.Tucker www.activefrance.com 2008

clc;
close all;
fprintf('\n\n\n***** Example 8 *******\n\n\n')
help example8;

[S11,S21,S12,S22,Freq]=citi2s('C:\matlab\toolbox\rfutils_s\data04.d2');

Zport1=s2z(S11,50); % Convert S11 to complex impedance 

% Plot Zport1 on a smith chart 
smith(1,50);                
smdrawc(Zport1,50,'r-');    
smarker1(Zport1,Freq,50,2000,1);

% Plot Zport1 as Return Loss
rlossc(Zport1,Freq,50,'r-');
rmarker1(Zport1,Freq,50,2000,1);

% Plot Insertion Loss
ilossc(S21,Freq,50,'r-');
imarker1(S21,Freq,50,2000,1);

% Plot Phase Delay
phdelayc(S21,Freq,50,'r-');
phmarker1(S21,Freq,50,2000,1);
