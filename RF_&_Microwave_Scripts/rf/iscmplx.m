% ISCMPLX  Tests if a number or array is complex
% 
%    [T] = ISCMPLX (x) returns 1 if x is complex, 0 otherwise
% 

function [T] = iscmplx (x)

T = 1;

if (x == real(x)),
	T = 0;   
end;   