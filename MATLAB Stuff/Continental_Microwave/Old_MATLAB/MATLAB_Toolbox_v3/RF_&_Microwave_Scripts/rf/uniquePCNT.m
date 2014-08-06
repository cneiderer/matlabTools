% UNIQUEPCNT Set unique, ignoring roundoff error.
%
%   UNIQUEPCNT(A, PCNT) for the array A returns the same values as in A but
%   with no repetitions (within PCNT percent).  A will also be sorted.
%

function [b] = uniquepcnt(a, PCNT)

% Convert matrices and rectangular empties into columns
if length(a) ~= prod(size(a)) | (isempty(a) & any(size(a)))
   a = a(:);
end
  
b = unique(sort(a));
a = [b(1)];

for num = 2:length(b),
   if ((b(num) - b(num - 1)) >= PCNT/100*b(num)),
      a = [a;b(num)];
   end;   
end;

b = a;