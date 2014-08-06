% Example10 
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
%                      = 100*sqrt(3.48)     When ports were driven differentially.
%                      = 186.6 mm           i.e. Using P(1),P(-1),P(2) & P(3)
%                                           was 65.9 Ohms
%                               
%
%
% Notes: Although the port impedances that Sonnet uses for the S-param
%        measurements are 50 Ohms, the characteristic impedance when 
%        treated as a differential structure is 100 Ohms.
%
%        i.e. Zo=100 for the impedance and TDR displays.
%
%        Also, for the TDR display, 100mm of 100 Ohm line has been inserted
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
% an impedance step. Approx differential impedance values :
% Section1 = 66 Ohms, Section2 = 75 Ohms. 
% Set Er=6 for the data07.son example, see below.

Er=3.48;                               % Set dielectric constant for line
Zo=100;                                % Select Zo=100 Ohms for differential structure             

Sd1d1=0.5*(S11-S13-S31+S33);           % Evaluate mixed mode S-param for : 
                                       % Differential excitation, Differential response.

Zdiff=((1+Sd1d1)./(1-Sd1d1)).*Zo;      % Convert Sd1d1 to complex differential impedance.

smith(1,Zo);                           % Draw Smith Chart               
smdrawc(Zdiff,Zo,'r-');                % Plot Zdiff on chart

rlossc(Zdiff,Freq,Zo,'r-');            % Plot Zdiff as Return Loss

Zdiff1=trl(Zo,Zdiff,100,Freq,Er,0);    % Add 100mm line of characteristic impedance,
                                       % so discontinuities are not at measurement plane.

tdr(Zdiff1,Zo,Er,Freq);                % Perform TDR
