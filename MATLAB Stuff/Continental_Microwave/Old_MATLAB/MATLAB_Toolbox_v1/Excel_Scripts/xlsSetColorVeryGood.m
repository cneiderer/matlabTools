function [] = xlsSetColorVeryGood(sheet,col,row)

%
% xlsSetColorVeryGood.m sets the cell fore/background to bright green with
%   black text
%

range_obj=xlsGetRange(sheet,col,row,col,row);
xlsSetBackgroundColor(range_obj,[0,255,0]);
xlsSetFontColor(range_obj,[0,0,0]);
