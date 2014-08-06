function [] = xlsSetCellForeground(color,sheet,col,row)

%
% xlsSetCellForeground.m
% 
% xlsSetCellForeground(color,sheet,col,row) sets the foreground color of the cells described
%   by the col and row of the specified sheet
%
% xlsSetCellForeground(color,sheet,range_obj) sets the foreground color of
%   the xls range object passed in 
%

if isinterface(col)
    range_obj=col;
else
    range_obj=xlsGetRange(sheet,col,row,col,row);
end

xlsSetFontColor(range_obj,color);
