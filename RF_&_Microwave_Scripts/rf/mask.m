% MASK  Mask a vector using another vector.  Include only those elements in the
%       output vector that have a nonzero entry in the mask vector.
% 
%    [Y] = MASK (input, mask) masks input using mask

function [M] = mask (vect, maskv)
M = [];
for i = 1:length(vect)
  if (maskv(i) ~= 0)
    M = [M vect(i)];
  end;
end;
