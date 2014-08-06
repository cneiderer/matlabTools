function unit_vec = Unit(vec, dim)
%     unit_vec = Unit(vec, dim)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      This function calculates the unit vector from the input vector.
%      The input may be a matrix, in which case the user aught to specify
%      how the vectors are arranged in the matrix.  This is done through 
%      the dim input, which specifies along which dimension to perform the 
%      norm calculation.  Dim = 1 implies the input is a column vector, 
%      2 implies row vector, etc.  For example, suppose vec is a 3x2 matrix
%      containing column vectors.  Vec1 = vec(:,1) and Vec2 = vec(:,2).  If
%      vec contained row vectors, then Vec1 = vec(1,:); Vec2 = vec(2,:); 
%      Vec3 = vec(3,:);
%
%      Note, this returns an empty output if the calculation fails for any
%      reason.
%
%   Input:
%        vec  --  Input vector or matrix of vectors
%        dim  --  Dimension along which to calculate the norm
%
%   Output:
%        unit_vec -- The unit vector along the input vector
%                   
%   Required Functions:
%        NONE

%Initialize the output in case the divide calculation below fails
unit_vec = [];

if nargin < 2
   %User did not specify the dimension, so make it a stupid value for the
   %switch statement below
   dim = -999999;
end

switch dim
   case 1
      magVec   = sqrt( sum( vec.^2, dim ) );
      magVec   = ones(length(magVec), 1) * magVec;
   case 2
      magVec   = sqrt( sum( vec.^2, dim ) );
      magVec   = ones(1, length(magVec)) * magVec;
   otherwise
      %User did not specify the dimension, so we let Matlab use its default
      %value
      magVec   = sqrt( sum( vec.^2 ) );
end %switch on the specified dimension

if magVec > 0
   %else return an empty value
   unit_vec = vec ./ magVec;
end %if we have a positive magnitude

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
