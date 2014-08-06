% F2K  Convert a temperature from Farenheit to Kelvin
% 
%    [K] = F2K (F) converts F into Kelvin
% 

function [K] = F2K (F)
K = C2K(F2C(F));
