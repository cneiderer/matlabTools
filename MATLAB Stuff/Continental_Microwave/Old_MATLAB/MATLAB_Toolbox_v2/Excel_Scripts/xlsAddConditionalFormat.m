function [r] = xlsAddConditionalFormat(r,lower,upper,b_color,f_color)

%
% xlsAddConditionalFormat.m
%
% Inputs:
%   r       -   range_obj
%   lower   -   lower limit
%   upper   -   upper limit
%   b_color -   background color
%   f_color -   font color

xlCellValue=1;
xlBetween=1;

count=r.FormatConditions.Count;
if count == 3
    error('Cannot add more than three formatting conditions to a range')
end

r.FormatConditions.Add(xlCellValue,xlBetween,['=',num2str(lower)],['=',num2str(upper)]);
count=count+1;
r.FormatConditions.Item(count).Interior.ColorIndex=xlsString2ColorIndex(b_color);
r.FormatConditions.Item(count).Font.ColorIndex=xlsString2ColorIndex(f_color);
