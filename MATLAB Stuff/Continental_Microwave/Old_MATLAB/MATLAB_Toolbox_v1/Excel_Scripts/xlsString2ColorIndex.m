function [color_index] = xlsString2ColorIndex(color_string)

%
% xlsString2ColorIndex(color_string) converts a color string to the Excel
%   ColorIndex #. Valid color strings are black, white, red, green, yellow,
%   blue, magenta, and cyan.
%

switch lower(color_string)
    case {'black','k'}
        color_index=1;
    case {'white','w'}
        color_index=2;
    case {'red','r'}
        color_index=3;
    case {'green','g'}
        color_index=4;
    case {'blue','b'}
        color_index=5;
    case {'yellow','y'}
        color_index=6;
    case {'magenta','m'}
        color_index=7;
    case {'cyan','c'}
        color_index=8;
    case {'gray25'}
        color_index=15;
    case {'light orange'}
        color_index=45;
    otherwise
        error([color_string,' is not a valid color string']);
end
