function [vNorm]=vec_norm(A,method)

if nargin <2
    method = 2;
end

vNorm = sqrt(sum(A.*A,method));
