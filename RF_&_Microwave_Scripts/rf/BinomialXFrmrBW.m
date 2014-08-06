% BINOMIALXFRMRBW  Calculate the bandwidth of a binomial transformer
% 
%    [BW] = BINOMIALXFRMRBW (Zl, Z0, N, GammaM) calcultaes the relative bandwidth
%            of an N section binomial transformer matching a Zl load to a Z0 line.
%
%            An optional fifth parameter 'PLOT' plots the input reflection 
%            coefficient versus normalized frequency.
% 

function [BW] = binomialxfrmrbw (Zl, Z0, N, GammaM, varargin)

A = 2^(-N)*abs((Zl-Z0)/(Zl+Z0));

BW = 2 - 4/pi*acos(1/2*(GammaM/A)^(1/N));

if nargin > 4,
  Theta = 0:0.01:pi;
  Gamma = A.*(1+exp(-2.*j.*Theta)).^N;
  plot(Theta*2/pi, abs(Gamma));
  title('Input Reflection Coefficient versus Normalized Frequency');
  xlabel('Normalized Frequency');
  ylabel('Input Reflection Coefficient Magnitude');
end;  