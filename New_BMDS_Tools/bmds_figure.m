function [f] = bmds_figure(n,holdit)
%
% BMDS_FIGURE
%   Creates a figure with a white background and hold on enabled (based on
%   an input flag)
%
% Inputs:
%   n       -   figure number
%   holdit  -   enable hold on flag
%
% Outputs:
%   f       -   figure handle
%
% Author:
%

if nargin >= 1
    f=figure(n);
else
    f=figure;
end

if nargin > 1
    if ~holdit
        clf(f);
    end
else
    clf(f);
end

hold on;
set(get(f,'CurrentAxes'),'Color',[1,1,1]);
set(f,'Color',[1,1,1]);
set(f,'InvertHardCopy','off');