% BINOMIALTRANSFORMER  Design a multisection binomial impedance transformer
% 
%    [Z] = BINOMIALTRANSFORMER (Zl, Z0, N) designs an N section binomial
%            transformer to match a Zl load to a Z0 line.
% 

function [Z] = binomialtransformer (Zl, Z0, N)

Z = Z0;

for num = 1:N,
  Z = [Z Z(num)*exp(2^(-N)*nchoosek(N,num-1)*log(Zl/Z0))];
end;

Z = Z(2:length(Z));