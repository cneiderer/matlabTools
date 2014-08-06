% IMR  Calculate image rejection ratio given amplitude and phase mismatch
% 
%    [y] = IMR (a, p) returns the image rejection given by a system with
%          amplitude ratio a and phase difference p radians.
% 

function [y] = IMR(a, p)

y = 1 + 2 .* a ./ (1 + a.^2) .* cos(p);
y = y ./ (1 - 2 .* a ./ (1 + a.^2) .* cos(p));
y = 10.*log10(y);
