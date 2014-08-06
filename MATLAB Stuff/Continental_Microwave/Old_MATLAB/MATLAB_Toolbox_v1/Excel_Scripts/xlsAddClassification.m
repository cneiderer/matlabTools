function xlsAddClassification(range,classification,varargin)

%
% xlsAddClassification.m adds classification text and colors it in an Excel
%   range
%
% xlsAddClassification(range,classification) inserts the classification
%   text (converted to uppercase) into the Excel range passed in.
%
% xlsAddClassification(range,classification,fontcolor,bgcolor) inserts the
%   classification text (convertedx to uppercase) into the Excel range
%   passed in and sets the font color and background color.
%

font_color='red';
bg_color='blue';

if nargin >= 3
    font_color=varargin{1};
    if nargin >= 4
        bg_color=varargin{2};
    end
end

range.Merg();
range.Value=upper(classification);
range.Font.FontStyle='Bold';

xlsSetFontColor(range,font_color);
xlsSetBackgroundColor(range,bg_color);
