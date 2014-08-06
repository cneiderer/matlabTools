% ADBV  Convert a decibel signal into an amplitude signal
% 
%    [y] = ADBV (x) converts x into an amplitude signal
% 

function [y] = adbV (x)

y = 10.^(x/20);