function copyFigToWord(figDimIn, figHandle, figCaption)
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

try,
    inRow = figDimIn(1);
    inCol = figDimIn(2);
catch,
    inRow = 3;
    inCol = 5;
end

if(~exist('figHandle', 'var')),
    figHandle = gcf;
else,
    if(isempty(figHandle)),
        figHandle = gcf;
    end
end

if(~exist('figCaption', 'var')),
    figCaption = '';
else,
    if(isempty(figCaption)),
        figCaption = '';
    end
end

try,
    print -dmeta;

    endOfDocument = get(wordActiveX_GLOBAL.activedocument.content,'end');
    wordActiveX_GLOBAL.Application.Selection.Start = endOfDocument;
    wordActiveX_GLOBAL.Application.Selection.End   = endOfDocument;
        
    wordActiveX_GLOBAL.Selection.Style = 'normal';

    wordActiveX_GLOBAL.Selection.Paste;
    
    % inf will force the last picture to be selected
    resizeWordPicture(inf, [inRow, inCol]);

    %wordActiveX_GLOBAL.Selection.TypeParagraph;

    % [] is default for current location
    addCaptionToWordFigure([], figCaption);

catch,
    fprintf('%s - figure not copied to word correctly\n', mfilename);

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
