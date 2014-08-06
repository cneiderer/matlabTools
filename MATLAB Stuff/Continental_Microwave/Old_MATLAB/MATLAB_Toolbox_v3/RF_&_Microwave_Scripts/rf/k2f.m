% K2F  Convert a temperature from Kelvin to Farenheit
% 
%    [F] = K2F (K) converts K into Farenheit
% 

function [F] = K2F (K)
F = C2F(K2C(K));
