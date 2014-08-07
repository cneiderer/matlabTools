function range = Compute_range(data)
%     range = Compute_range(data)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Computes the range (length) of a column vector, or of each column in
%      a matrix.
%
%   Input:
%        data  --  A column vector, or a matrix of column vectors
%
%   Output:
%        range -- The length of the vector (columns of a matrix)
%                   
%   Required Functions:
%      NONE
%

range = sqrt( sum(data.^2, 1) );

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
