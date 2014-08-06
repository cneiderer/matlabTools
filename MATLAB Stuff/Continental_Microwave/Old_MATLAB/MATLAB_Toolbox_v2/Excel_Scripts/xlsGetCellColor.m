function [color] = xlsGetCellColor(sheet,col,row)

%
% xlsGetCellColor.m returns the color of a single cell
%

val=xlsGetRange(sheet,col,row,col,row);
[r,g,b]=ppt_Color2RGB(val.Interior.Color);
color=[r,g,b];