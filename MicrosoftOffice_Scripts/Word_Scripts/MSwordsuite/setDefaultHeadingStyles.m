function setDefaultHeadingStyles
% ---------------------------------------------------------------------
% |You may use this code for anything. However, if you do use it or   |
% |modify it or incorporate it into any project or product or service |
% |the result shall be subject to GPLv3 and you must include this     |
% |header and footer notice.                                          |
% |                                                                   |
% |GNU GENERAL PUBLIC LICENSE -- Version 3, 29 June 2007              |
% |see http://www.gnu.org/licenses/gpl.html                           |
% |                                                                   |
% |michaelB brost -- December 23, 2008                                |
% ---------------------------------------------------------------------
global wordActiveX_GLOBAL;

% number of heading levels to modify
nStylesChanged = 5;

try,
    % some interesting defaults.
    styleStruct.fontName      = 'Arial';
    styleStruct.fontSize      = 18;
    styleStruct.fontBold      = true;
    styleStruct.fontItalic    = false;
    
    % color -- some other choices
    styleStruct.fontColor     = 'wdColorAutomatic';
    %styleStruct.fontColor     = calcWordColor([0, 255, 0]);
    %styleStruct.fontColor     = calcWordColor([255, 0, 0]);
    
    % underline - other choices
    styleStruct.fontUnderline = 'wdUnderlineNone';    
    %styleStruct.fontUnderline = 'wdUnderlineSingle';
    %styleStruct.fontUnderline = 'wdUnderlineDouble';

    % set as default for first 4 heading levels
    styleStruct = repmat(styleStruct, [nStylesChanged, 1]);

    % decrease the font size by 2 from font size in heading 1
    % perform similar changes for color, boldness etc 
    for k1=2:nStylesChanged,
        styleStruct(k1).fontSize = styleStruct(1).fontSize - (k1 - 1) * 2;
    end

    % now apply the new styles
    for headingLevel=1:nStylesChanged,
        applyStyle(headingLevel, styleStruct(headingLevel));
    end

catch,
    fprintf('%s: failed to initialize heading styles\n', mfilename);

end


% -------------------- helper function --------------------- %
function applyStyle(theLevel, theStyle)
global wordActiveX_GLOBAL;

try,
    headingString = sprintf('Heading %d', theLevel);
    styleHandle   = getWordStyle(headingString);
    fontHandle    = styleHandle.Font;

    try,
        fontHandle.Name = theStyle.fontName;

    catch,
        fprintf('%s: invalid font name\n', mfilename);

    end

    try,
        fontHandle.Size = theStyle.fontSize;

    catch,
        fprintf('%s: invalid font size\n', mfilename);

    end

    try,
        fontHandle.Bold = theStyle.fontBold;

    catch,
        fprintf('%s: invalid font boldness\n', mfilename);

    end

    try,
        fontHandle.Italic = theStyle.fontItalic;

    catch,
        fprintf('%s: invalid font italic\n', mfilename);

    end

    try,
        fontHandle.Underline = theStyle.fontUnderline;

    catch,
        fprintf('%s: invalid font underline\n', mfilename);

    end

    try,
        fontHandle.Color = theStyle.fontColor;

    catch,
        fprintf('%s: invalid font color\n', mfilename);

    end

catch,
    fprintf('%s: failed to reset heading %d\n', theLevel);

end



% ---------------------------------------------------------------------
% |You may use this code for anything. However, if you do use it or   |
% |modify it or incorporate it into any project or product or service |
% |the result shall be subject to GPLv3 and you must include this     |
% |header and footer notice.                                          |
% |                                                                   |
% |GNU GENERAL PUBLIC LICENSE -- Version 3, 29 June 2007              |
% |see http://www.gnu.org/licenses/gpl.html                           |
% |                                                                   |
% |michaelB brost -- December 23, 2008                                |
% ---------------------------------------------------------------------
