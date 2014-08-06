% DBM  Convert a power signal (Watts) into dbm
% 
%    [y] = DBM (x) converts x into dbm
% 

function [y] = dbm (x)

y = 10.*log10(abs(x/1E-3));