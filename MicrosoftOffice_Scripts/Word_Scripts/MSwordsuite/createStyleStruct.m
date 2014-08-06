function theStyle = createStyleStruct(font, theSize, bold, italic, numUnderline, colorRGB),
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

try,
    theStyle.fontName = font;
catch,
    theStyle.fontName = 'Ariel';
end

try
    theStyle.fontSize = max(8, min(72, theSize));
catch,
    theStyle.fontSize = 12;
end

try,
    theStyle.fontBold = bold;
catch,
    theStyle.fontBold = false;
end

try
    theStyle.fontItalic = italic;
catch,
    theStyle.fontItalic = false;
end

try,
    theStyle.fontUnderline = min(2, max(0, numUnderline));
catch,
    theStyle.fontUnderline = 0;
end


try
    theStyle.fontColor = calcWordColor(colorRGB);
catch,
    %theStyle.fontColor = 'wdAutomatic';
    theStyle.fontColor = 0; % black
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
