% ISEVEN  Tests if a number or vector is even
% 
%    [T] = ISEVEN (x) returns 1 if x is even, 0 otherwise
% 

function [T] = iseven (x)

T = ones(1,length(x));

for num = 1:length(x),
	if (x(num) ~= 2*floor(x(num)/2)),
		T(num) = 0;   
	end;
end;