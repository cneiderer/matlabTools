% DBV  Convert a voltage signal into decibels
% 
%    [y] = DBV (x) converts x into decibels
% 

function [y] = dbV (x)

y = 20.*log10(abs(x));