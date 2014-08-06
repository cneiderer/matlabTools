% F2C  Convert a temperature from Farenheit to Centigrade
% 
%    [C] = F2C (F) converts F into Centigrade
% 

function [C] = F2C (F)
C = 5/9*(F - 32);
