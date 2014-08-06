% ULIMIT  Limit a vector to a given maximum value
% 
%    [y] = ULIMIT (x,m) limits vector x to have maximum value m
% 

function [y] = ulimit (x, m);
y = x;
for q = 1:length(x)
  if (x(q) > m)
    y(q) = m;
  end;
end;
