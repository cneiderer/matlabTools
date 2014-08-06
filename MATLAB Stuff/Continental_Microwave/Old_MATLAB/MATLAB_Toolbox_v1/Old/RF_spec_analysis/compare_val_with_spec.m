function [spec_val] = compare_val_with_spec(measurement,xlsSheet,celltest_col,celltest_row)

%
% compare_val_with_spec.m
%
% Description:
%   Originally written as a subfunction, this script is used in both 
%   RF_spec_analysis_mod.m and add_mean_std_var_calcs.m to compare the
%   measured value or mean value of the measurements with the spec value.
%   It then conditionally colors the background and foreground of the cell
%   being compared.
%
% Inputs:
%   
% Outputs:
%
% Author:
%   Curtis Neiderer, 12/15/2008
%
% Notes / Changes:
%   
%   Change 1.1
%   Date: 12/16/2008
%   Description:
%       Added condition to test if spec_val is a character string (Usually 
%       refers to N/A or NA values). If it is a string, no coloring will
%       take place.
%

spec_col=2;
spec_row=celltest_row;
spec_val=xlsGetValue(xlsSheet,spec_col,spec_row);
spec_name=xlsGetValue(xlsSheet,spec_col-1,spec_row);

% if strcmpi(spec_val,'N/A') || strcmpi(spec_val,'NA')
if ~ischar(spec_val)

    if strcmpi(spec_name,'Min_Gain [dB]')
        
        if measurement > (1.1*spec_val)
            xlsSetCellBackground('g',xlsSheet,celltest_col,celltest_row);
        elseif (measurement <= (1.1*spec_val)) & (measurement >= spec_val)
            xlsSetCellBackground('y',xlsSheet,celltest_col,celltest_row);
        else
            xlsSetCellBackground('r',xlsSheet,celltest_col,celltest_row);
            xlsSetCellForeground('w',xlsSheet,celltest_col,celltest_row);
        end
            
    else
    
        if measurement < (0.9*spec_val)
            xlsSetCellBackground('g',xlsSheet,celltest_col,celltest_row);
        elseif (measurement >= (0.9*spec_val)) & (measurement <= spec_val)
            xlsSetCellBackground('y',xlsSheet,celltest_col,celltest_row);
        else
            xlsSetCellBackground('r',xlsSheet,celltest_col,celltest_row);
            xlsSetCellForeground('w',xlsSheet,celltest_col,celltest_row);
        end
    
    end
    
end