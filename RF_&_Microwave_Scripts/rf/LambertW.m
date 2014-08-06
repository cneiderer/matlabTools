% LAMBERTW  Calculates Lambert's W function, the inverse of A = x*exp(x)
% 
%    [W] = LAMBERTW (A) 

function [W] = lambertw (A)

W = fzero(inline('x*exp(x)-A','x','A'),0,[],A);

