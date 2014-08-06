% PINKFILT  Generate filter coefficients for a 'pink noise' filter.
%
%		[a] = PINKFILT (alpha, numtaps)
%			generates a NUMTAPS denominator for the FIR filter which filters white noise to
%			give a PSD of 1/(f^alpha).
%
%			This function is closely based on the work presented in "Discrete Simulations
%			of Colored Noise and Stochastic Processes and 1/f^alpha Power Law Noise
%			Generation," N. Jeremy Kasdin, Proceedings of the IEEE, Vol. 83, No. 5, May 1995.

function [a] = pinkfilt (alpha, numtaps)

a = zeros(1,numtaps);
a(1) = 1;
for temp = 2:numtaps,
   a(temp) = (temp - 2 - (alpha/2)) * a(temp - 1) / (temp - 1);
end;