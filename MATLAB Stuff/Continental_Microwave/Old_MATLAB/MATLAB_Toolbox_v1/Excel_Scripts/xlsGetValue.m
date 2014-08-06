function [val] = xlsGetValue(sheet,col,row)

%
% xlsGetValue.m returns the value of a single cell
%

val=xlsGetRange(sheet,col,row,col,row);
val=val.Value;