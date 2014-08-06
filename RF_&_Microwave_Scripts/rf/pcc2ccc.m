% PCC2CCC  Convert the polar input into a complex number
%
%    [pcc] = PCC2CCC (mag, ang) converts the polar input into a complex number
% 

function [pcc] = pcc2ccc (mag, ang);
[x, y] = pol2cart (ang, mag);
pcc = x + j * y;
