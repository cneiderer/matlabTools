% Example6 
%
% Time Domain Reflectometry
% Showing how to plot impedance as a function of distance using tdr.m 
%
% A simulated input impedance measurement is made on the cascaded
% transmission lines shown below. The TDR response is then calculated.
%
% Normally the data would be a measured with a view to identifying
% and discontinuities or changes in line impedance.
% 
%        200mm      300mm     500mm          <-Length (Er=1.0)
%        50 Ohm     85 Ohm    75 Ohm         <-Characteristic Z
%  Zin>---------Z2---------Z1--------<Zload  <-Node Impedances
%
%
% Open this file and look through the comments.

% N.Tucker www.activefrance.com 2008

clc;
close all;
fprintf('\n\n\n***** Example 6 *******\n\n\n');
help example6;

% Set up an example impedance file using trl.m

% Note :-    For TDR to work the start frequency must
%            conform to the relation below :
%            StartFreq=(StopFreq/Npoints)

% Define Network Analyser style measurement params 
Npoints=201;                  % Number of points
StopFreq=6000;                % Stop frequency (MHz)
StartFreq=StopFreq/Npoints;   % Start frequency (MHz)

% Calculate frequency step (MHz)
Step=(StopFreq-StartFreq)./(Npoints-1); 

Freq=StartFreq:Step:StopFreq;  % Set up the frequency list
Zterm=term(50,Freq);           % 50 Ohm terminating impedance, vectorised over frequency
Z1=trl(75,Zterm,500,Freq,1,0); % 500mm section of 75 Ohm Tx line
Z2=trl(85,Z1,300,Freq,1,0);    % 300mm section of 85 Ohm Tx line
Zin=trl(50,Z2,200,Freq,1,0);   % 200mm section of 50 Ohm Tx line

% Perform TDR, results are plotted by tdr.m
tdr(Zin,50,1,Freq);
