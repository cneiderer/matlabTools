% ADBP  Convert a decibel signal into a power signal
% 
%    [y] = ADBP (x) converts x into a power signal
% 

function [y] = adbP (x)

y = 10.^(x/10);