% SINEAPPROX  Generates a clipped sine wave and an approximation to it.
% 
%    [EXACT, APPROX] = SINEAPPROX (Time, Frequency, Amplitude, ClipAmp) 
%        Generates the clipped sine wave and an approximation to it at
%        times given by Time.
% 

function [EXACT, APPROX] = SINEAPPROX(T, F, A, C)

Tr = asin(C/A)/pi/F;
APPROX = PulseSource(T, Tr, Tr, 1/2/F - Tr, 1/F, -Tr/2, C, -C);
EXACT = llimit(ulimit(A*sin(2*pi*F*T), C), -C);