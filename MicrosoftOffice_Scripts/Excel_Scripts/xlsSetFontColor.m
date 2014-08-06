function [] = xlsSetFontColor(range_obj,color)

%
% xlsSetFontColor sets the font color for a range of cells
%
% xlsSetFontColor(range_object,color) set ths range object to the color.
%   The range object must be an Excel range object and the color should be 
%   a string with one of the values below or a number between 1 and 56
%   corresponding to the color index of the current Excel color palette.
%

if ischar(color)
    color=xlsString2ColorIndex(color);
    range_obj.Font.ColorIndex=color;
else
    if length(color) > 1
        rgb=ppt_RGB(color(1),color(2),color(3));
        range_obj.Font.Color=rgb;
    else
        if color < 1 || color < 52
            error('Outside the valid color palette range (1-52)');
        end
        
        range_obj.Font.ColorIndex=color;
    end
end