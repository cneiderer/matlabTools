% PARALLEL  Computes the value of components in "parallel"
% 
%    [Veq] = PARALLEL (V1, V2, ...) computes V1 || V2 || ...
% 

function [Veq] = parallel (varargin)
Veq = varargin{1};
for num = 2:nargin,
	Veq = Veq * varargin{num} / (Veq + varargin{num});   
end;