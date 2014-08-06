function styleIndex = getWordStyleIndex(theStyle)
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

styleIndex = [];

try,
    styleHandle = wordActiveX_GLOBAL.ActiveDocument.Styles;
    
    nStyles = styleHandle.Count;
    
    tempStyle = lower(theStyle);
    
    for styleIndex=1:nStyles,
        docStyle = lower(styleHandle.Item(styleIndex).NameLocal);
        
        if(strcmp(tempStyle, docStyle) == true),
            return;
        end
    end
    
    styleIndex = [];
    
catch,
    fprintf('%s: failed to find style ''%s''\n', mfilename, theStyle);

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
