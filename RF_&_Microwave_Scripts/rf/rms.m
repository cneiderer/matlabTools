% RMS  Compute the RMS value of a vector
% 
%    [y] = RMS (x) computes the RMS value of x
% 

function [y] = rms (x)
y = sqrt(mean(x.^2));
