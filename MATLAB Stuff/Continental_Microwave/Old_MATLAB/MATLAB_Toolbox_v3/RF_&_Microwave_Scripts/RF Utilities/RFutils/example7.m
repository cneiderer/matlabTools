% Example7 
%
% Time Domain Reflectometry
% Showing how to plot impedance as a function of distance using tdr.m 
%
% A simulated input impedance measurement is made on the cascaded
% transmission lines shown below. The TDR response is then calculated
%
% Normally the data would be a measured with a view to identifying
% and discontinuities or changes in line impedance.
% 
%      500mm             500mm             500mm         <-Length 
%      50 Ohm            50 Ohm            50 Ohm        <-Characteristic Z
%  Zin>-------Z4---x---Z4-------Z2---x---Z1-------<load  <-Node Impedances
%                  ^                 ^
%             5pF Shunt C       10nH Series L            <-Lumped discontinuity
%
% Open this file and look through the comments.

% N.Tucker www.activefrance.com 2008

clc;
close all;
fprintf('\n\n\n***** Example 7 *******\n\n\n');
help example7;

% Set up an example impedance file using trl.m

% Note :-    For TDR to work the start frequency must
%            conform to the relation below :
%            StartFreq=(StopFreq/Npoints)

% Define Network Analyser style measurement params 
Npoints=201;                   % Numer of points
StopFreq=13500;                % Stop frequency (MHz)
StartFreq=StopFreq/Npoints;    % Start frequency (MHz)



% Calculate frequency step (MHz)
Step=(StopFreq-StartFreq)./(Npoints-1); 

Zo=50;
Er=1.0;

Freq=StartFreq:Step:StopFreq;  % Set up the frequency list
Zterm=term(Zo,Freq);           % 50 Ohm terminating impedance, vectorised over frequency
Z1=trl(Zo,Zterm,500,Freq,1,0); % 500mm section of 50 Ohm Tx line
Z2=lseries(Z1,10e-9,Freq);     % 10nH series inductance
Z3=trl(Zo,Z2,500,Freq,1,0);    % 500mm section of 50 Ohm Tx line
Z4=cshunt(Z3,5e-12,Freq);      % 5pf shunt capacitance
Zin=trl(Zo,Z4,500,Freq,1,0);   % 500mm section of 50 Ohm Tx line

% Perform TDR, results are plotted by tdr.m
tdr(Zin,Zo,Er,Freq);
