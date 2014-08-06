% Example9 
%
% Showing how to plot impedances imported from an S2P file 
% exported from RFsim99
%
% The pathname in the loads2p(pathname)call must point to a S2P file
% e.g. C:\matlab\toolbox\rfutils_s\data05.s2p
% Depending on your installation directory, this may need to be
% changed, see loads2p.m calls in this script.
%
% Open this file and look through the comments.

% N.Tucker www.activefrance.com 2008

clc;
close all;
fprintf('\n\n\n***** Example 9 *******\n\n\n')
help example9;

[S11,S21,S12,S22,Freq]=loads2p('C:\matlab\toolbox\rfutils_s\data05.s2p');

Zport1=s2z(S11,50); % Convert S11 to complex impedance 

% Plot Zport1 on a smith chart 
smith(1,50);                
smdrawc(Zport1,50,'r-');    
smarker1(Zport1,Freq,50,1063,1);

% Plot Zport1 as Return Loss
rlossc(Zport1,Freq,50,'r-');
rmarker1(Zport1,Freq,50,1063,1);

% Plot Insertion Loss
ilossc(S21,Freq,50,'r-');
imarker1(S21,Freq,50,1063,1);

% Plot Phase Delay
phdelayc(S21,Freq,50,'r-');
phmarker1(S21,Freq,50,1063,1);

% Plot Group Delay
gdelayc(S21,Freq,50,'r-');
gmarker1(S21,Freq,50,1063,1);
