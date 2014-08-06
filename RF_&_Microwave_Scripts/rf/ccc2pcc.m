% CCC2PCC  Converts a complex number into magnitude and phase (in radians)
%
%	[mag, ang] = ccc2pcc(A) converts A into magnitude and phase
%
function [mag, ang] = ccc2pcc (ccc);
[ang, mag] = cart2pol (real(ccc), imag(ccc));
