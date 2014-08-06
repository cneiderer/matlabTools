function [] = xlsSetColorOk(sheet,col,row)

%
% xlsSetColorOk.m sets the cell fore/background to yellow with black text
%

range_obj=xlsGetRange(sheet,col,row,col,row);
xlsSetBackgroundColor(range_obj,[255,255,0]);
xlsSetFontColor(range_obj,[0,0,0]);
