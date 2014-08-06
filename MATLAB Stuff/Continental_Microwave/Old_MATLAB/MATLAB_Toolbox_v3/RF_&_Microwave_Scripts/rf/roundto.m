% ROUNDTO  Round the input to a specified resolution
% 
%    [Y] = ROUNDTO (X, Resolution) rounds X to Resolution.

function [Y] = roundto (X, Resolution)

Y = round (X / Resolution) * Resolution;
