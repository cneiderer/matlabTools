% CHEBPOLY Evaluate Chebyshev polynomial
%
%  [Y]=CHEBPOLY(N, X) Evaluates the Nth Chebyshev polynomial at X

function Y = chebpoly(N,X)

X = X(:).';                    

T(1,:) = X;
T(2,:) = 2.*X.^2 - 1;

for num = 3:N
  T(num,:) = 2.*X.*T(num-1,:)-T(num-2,:);
end;

Y = T(N,:);