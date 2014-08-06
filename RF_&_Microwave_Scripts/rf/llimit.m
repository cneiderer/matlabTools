% LLIMIT  Limit a vector to a given minimum value
% 
%    [y] = LLIMIT (x,m) limits vector x to have minimum value m
% 

function [y] = llimit (x, m);
y = x;
for q = 1:length(x)
  if (x(q) < m)
    y(q) = m;
  end;
end;
