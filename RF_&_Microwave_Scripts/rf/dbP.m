% DBP  Convert a power signal into decibels
% 
%    [y] = DBP (x) converts x into decibels
% 

function [y] = dbP (x)

y = 10.*log10(abs(x));