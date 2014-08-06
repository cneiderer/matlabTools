% ISODD  Tests if a number or vector is odd
% 
%    [T] = ISODD (x) returns 1 if x is odd, 0 otherwise
% 

function [T] = isodd (x)

T = ones(1,length(x));

for num = 1:length(x),
	if (x(num) == 2*floor(x(num)/2)),
		T(num) = 0;   
	end;
end;