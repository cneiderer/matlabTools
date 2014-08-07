function col_norm = column_norm(data)
%
%     col_norm = Column_Norm(data);
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Computes the length of a column vector, or of each column in
%      a matrix.
%
%   Input:
%        data  --  A column vector, or a matrix of column vectors
%
%   Output:
%        col_norm -- The length of the vector (columns of a matrix)
%                   
%   Required Functions:
%      NONE
%

if size(data,1)>1
   col_norm = sqrt( sum(data.^2, 1) );
else
   col_norm = abs(data);
end

