function copyStringToWord(theString, theLineBreaks, styleStruct)
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
    if(~exist('theLineBreaks', 'var')),
        theLineBreaks = [0, 0];
    end

    try,
        theLineBreaks = round(theLineBreaks);

        if(length(theLineBreaks) > 2)
            theLineBreaks = theLineBreaks(1:2);
        end

        % limited it to [0....10]
        theLineBreaks(1) = max(min(theLineBreaks(1), 10), 0);
        theLineBreaks(2) = max(min(theLineBreaks(2), 10), 0);

    catch,
        theLineBreaks = [0, 0];
        fprintf('%s - bad line break vector, defaulting to [0, 0]\n', mfilename);

    end

    % hard line breaks before string - if any
    for k1=1:theLineBreaks(1),
        wordActiveX_GLOBAL.Selection.TypeParagraph;
    end

    % current selection start
    startSelection = wordActiveX_GLOBAL.Application.Selection.Start;

    % the actual text
    try,
        wordActiveX_GLOBAL.Selection.TypeText(theString);
        endSelection = wordActiveX_GLOBAL.Application.Selection.Start;

    catch,
        endSelection = [];
        fprintf('%s - bad string...ignoring\n', mfilename);

    end

    % adjust the newly copied string
    if(~exist('styleStruct', 'var')),
        styleStruct = createStyleStruct;
    end
    
    % update the style of the string
    updateStyleString(startSelection, endSelection, styleStruct);
    
    % unselect current text
    wordActiveX_GLOBAL.Selection.Start = wordActiveX_GLOBAL.Selection.End; 

    % hard line breaks after string
    for k1=1:theLineBreaks(2)
        wordActiveX_GLOBAL.Selection.TypeParagraph;
    end

catch,
    fprintf('%s: string copy to word not fully successful\n', mfilename);

end

function updateStyleString(startIndex, endIndex, theStyle)
global wordActiveX_GLOBAL;

if(isempty(endIndex)), return; end

try,
    sel = wordActiveX_GLOBAL.Application.Selection;
    sel.Start = startIndex;
    sel.End   = endIndex;

    fontHandle = sel.Font;

    try,
        fontHandle.Name = theStyle.fontName;

    catch,
    end

    try,
        fontHandle.Size = theStyle.fontSize;

    catch,
    end

    try,
        fontHandle.Bold = theStyle.fontBold;
    catch,
    end

    try,
        fontHandle.Italic = theStyle.fontItalic;
    catch,
    end

    try,
        u = theStyle.fontUnderline;

        % numeric choice: 0, 1, 2. defaults to
        if(isnumeric(u)),
            switch(u),
                case {1},
                    uStr = 'wdUnderlineSingle';
                case{2},
                    uStr = 'wdUnderlineDouble';
                otherwise,
                    uStr = 'wdUnderlineNone';
            end
            
            fontHandle.Underline = uStr;
        end

        % string version
        if(ischar(u)),
            fontHandle.Underline = u;
        end

    catch,
    end

    try,
        fontHandle.Color = theStyle.fontColor;
    catch,
    end

catch,
    fprintf('%s: failed to reset font %d\n', mfilename);

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
