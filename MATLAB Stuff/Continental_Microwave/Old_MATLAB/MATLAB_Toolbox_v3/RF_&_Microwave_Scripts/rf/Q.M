% Q  Compute the Q function
% 
%    [y] = Q (x) computes Q(x)=1/2*erfc(x/sqrt(2))
% 

function [y] = Q(x)
y = 0.5*erfc(x/sqrt(2));