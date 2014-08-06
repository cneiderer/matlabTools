function [] = xlsSetCellBackground(color,sheet,col,row)

%
% xlsSetCellBackground(color,sheet,col,row) sets the background color of
%   the cells described by the col and row of the specified sheet
% xlsSetCellBackground(color,sheet,range_obj) sets the background color of
%   the xls range object passed in
%

if isinterface(col)
    range_obj=col;
else
    range_obj=xlsGetRange(sheet,col,row,col,row);
end

xlsSetBackgroundColor(range_obj,color);