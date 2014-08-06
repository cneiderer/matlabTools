function [] = max_flat_gMatrix_values(varargin)

%
% max_flat_gMatrix_values
%
% Description:
%   Creates the g_matrix of element values for doubly terminated maximally
%   flat filters.
%
% Inputs:
%   num_sec     -> the number of sections/elements
%
% Outputs:
%   g_matrix    -> displays the g_matrix to the command line
%
% Author:
%   Curtis Neiderer, 01/09/2009
%

if nargin==1
    num_sec=varargin{1};
else
    num_sec=15;
end

g_matrix=zeros(num_sec,num_sec+1); % hardcoded for (num_elements+1,num_elements)
for ii=1:num_sec % hardcoded 1:num_elements
    for jj=1:ii  
        
        % Calculate element value
        g_matrix(ii,jj)=2*sin(((2*jj-1)*pi)/(2*ii));
        g_matrix_cell{ii,jj}=2*sin(((2*jj-1)*pi)/(2*ii));
        
        if jj==ii
            g_matrix(ii,jj+1)=1;
            g_matrix_cell{ii,jj+1}=1;
        end
    
    end
end

% Display the element values
disp(g_matrix)