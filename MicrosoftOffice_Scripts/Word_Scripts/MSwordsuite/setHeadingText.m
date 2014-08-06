function setHeadingLevel(theLevel, theText)
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

% reset the heading style to Heading 1, Heading 2, ..., Heading 9
% otherwise reset to 'normal'

try,
    if(ischar(theLevel)),
        theLevel = 0;
    end
    
    theLevel = min(theLevel, 9);
    theLevel = max(theLevel, 0);
    
    if(theLevel == 0),
        theStyle = 'normal';
    else,
        theStyle = sprintf('Heading %d', theLevel);
    end
        
    startSelection = wordActiveX_GLOBAL.Application.Selection.Start;
    endSelection   = startSelection;
    wordActiveX_GLOBAL.Application.Selection.End = endSelection;
    wordActiveX_GLOBAL.Selection.TypeParagraph;

    startSelection = wordActiveX_GLOBAL.Application.Selection.Start;
    wordActiveX_GLOBAL.Selection.TypeText(theText);
    endSelection   = wordActiveX_GLOBAL.Application.Selection.End;

    wordActiveX_GLOBAL.Selection.Style = theStyle;

    wordActiveX_GLOBAL.Selection.TypeParagraph;
    
    wordActiveX_GLOBAL.Selection.Style = 'normal';

    
catch
    fprintf('%s: could not set heading level\n', mfilename);

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
