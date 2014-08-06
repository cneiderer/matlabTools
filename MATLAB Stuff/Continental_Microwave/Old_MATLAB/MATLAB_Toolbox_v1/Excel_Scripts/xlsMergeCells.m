function [r] = xlsMergeCells(sheet,col1,row1,col2,row2)

%
% xlsMergeCells.m
%

r = xlsGetRange(sheet,col1,row1,col2,row2);
r.Merge;