% GAUSSFILT  Design a Gaussian Low-Pass Filter
%
%	[B, A] = GAUSSFILT(BW, N)
%    BW is the 3-dB bandwidth with 1.0 being 1/2 the
%    sampling frequency.  N is the number of taps.
%
%
function [B, A] = GaussFilt(BW, N)

NF = N

alpha = sqrt(log(2)/2)/BW;
F = 0.0:1/(NF-1):1.0;
M = exp(-alpha^2*F.^2);
[B,A] = yulewalk (N , F , M)
