function [workbook] = xlsOpen(excel,filename)

%
% xlsOpen.m
%

if exist(filename,'file')
    workbook=excel.Workbooks.Open(filename);
else
    workbook=xlsAddNewWorkbook(excel,filename);
end