function [] = xlsSetCellVal(value,sheet,col,row)

%
% xlsSetCellVal.m
%

range_obj=xlsGetRange(sheet,col,row,col,row);
range_obj.Value=value;