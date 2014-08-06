% ADBM  Convert a dbm signal into a power signal (Watts)
% 
%    [y] = ADBM (x) converts x into a power signal
% 

function [y] = adbm (x)

y = 10.^((x-30)/10);