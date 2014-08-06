% Example11 
%
% Showing how to plot impedances imported from a file 
% exported from Sonnet Lite. Also demonstrated is tdr.m
% for differential transmission lines.
%
% The file is a 4-Port S-param model of a pair of differential 
% (balanced) striplenes lines. 
%
% The impedance of the balanced transmission lines is
% proportional to their spacing : Wider = Higher Impedance
%
%
% In this example the 4-port S-parameters are loaded in using loadsonnet4.m
% The differential impedance is then calculated from the S-params.
% This differential impedance is then used with tdr.m to obtain the 
% differential line impedance as a function of distance along the line. 
%
% Port Defn's                       Coupled Stripline Configuration
%             Stripline 1               ___________________   __
%    P1>========================<P2          ___   ___        __ 0.762mm Er=3.48
%    P3>========================<P4     ___________________   __ 0.762mm Er=3.48
%             Stripline 2              
%                                        Linewidths 1&2=1.65mm
%      <- Physical len = 100mm ->        Line Separation=1.00mm 
%
%         Electric len = 100*sqrt(Er)       Impedance given by Sonnet
%                      = 100*sqrt(3.48)     When ports were driven in common mode.
%                      = 186.6 mm           i.e. Using P(1),P(1),P(2) & P(3)
%                                           was 17.2 Ohms (midband)
%                               
%
%
% Notes: Although the port impedances that Sonnet uses for the S-param
%        measurements are 50 Ohms, the characteristic impedance when 
%        treated as a common mode structure is 25 Ohms.
%
%        i.e. Zo=25 for the impedance and TDR displays.
%
%        Also, for the TDR display, 100mm of 25 Ohm line has been inserted
%        in front of the balanced line using the trl.m function. This is
%        to avoid placing a discontinuity at the exact point where the impulse
%        function is applied in the time (distance) domain. The amount of line
%        extension is arbitrary, but should satisfy the relation below, see tdr.m
%        for explanations of TDR Range and Resolution.
%
%           TDR Resolution Distance < Line Extension < TDR Range Dist 
%
%        Refer to examples 6 and 7, these both have sections of line of 
%        characteristic impedance (50 Ohm in this case) at the input, 
%        for the same reason as above.
%
%
%
% The pathname in the loadsonnet(pathname) call must point to a data file
% e.g. C:\matlab\toolbox\rfutils_s\data06.son
% Depending on your installation directory, this may need to be
% changed, see loadsonnet.m calls in this script.
%
% Open this file and look through the comments.

% N.Tucker www.activefrance.com 2008

clc;
close all;
fprintf('\n\n\n***** Example 10 *******\n\n\n')
help example10;


[S11,S12,S13,S14,S21,S22,S23,S24,...
S31,S32,S33,S34,S41,S42,S43,S44,Freq]=loadsonnet4('c:\matlab\toolbox\rfutils_s\data06.son');

% Try file data07.son instead of data06.son in above pathname.
% It is for a 2-section differential transmission line, with 
% an impedance step. Approx common mode impedance values :
% Section1 = 22 Ohms, Section2 = 20 Ohms.
% Set Er=6 for the data07.son example, see below.

Er=3.48;                               % Set dielectric constant
Zo=25;                                 % Select Zo=25 Ohms for the common mode drive.

% Convert standard S-params to Mixed mode S-params

[Sd1d1,Sd1d2,Sd2d1,Sd2d2,...
 Sd1c1,Sd1c2,Sd2c1,Sd2c2,...
 Sc1d1,Sc1d2,Sc2d1,Sc2d2,...
 Sc1c1,Sc1c2,Sc2c1,Sc2c2] = s2mm(S11,S12,S13,S14,...
                                 S21,S22,S23,S24,...
                                 S31,S32,S33,S34,...
                                 S41,S42,S43,S44);

Zcomm=((1+Sc1c1)./(1-Sc1c1)).*Zo;      % Convert Sc1c1 to commmon mode impedance.

smith(1,Zo);                           % Draw Smith Chart
smdrawc(Zcomm,Zo,'r-');                % Plot Zcomm on chart

rlossc(Zcomm,Freq,Zo,'r-');            % Plot Zcomm as Return Loss

Zcomm1=trl(Zo,Zcomm,100,Freq,Er,0);    % Add 100mm line of characteristic impedance,
                                       % so discontinuities are not at measurement plane.

tdr(Zcomm1,Zo,Er,Freq);                % Perform the TDR
