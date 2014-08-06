function excite_element(elnumber,Pwr,Pha)
% Set element phase and Amplitude
%
% Usage: excite_element(elnumber,Pwr,Pha)
%
% elnumber..Element number
% Pwr.......Pwr (dB)
% Pha.......Phase (Deg)

global array_config;

Amplitude=10^(Pwr/20);       % Set amplitude in linear volts
Phase=Pha/180*pi;            % Set phase in radians

array_config(1,5,elnumber)=Amplitude;
array_config(2,5,elnumber)=Phase;

fprintf('Element %i excitation : %3.2f dB   %3.2f Deg\n',elnumber,Pwr,Pha);