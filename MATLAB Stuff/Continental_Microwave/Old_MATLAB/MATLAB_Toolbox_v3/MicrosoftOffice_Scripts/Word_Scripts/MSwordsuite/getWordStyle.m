function docStyle = getWordStyle(reqStyle),
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

docStyle = [];

try,
    if(ischar(reqStyle)),
        styleIndex = getWordStyleIndex(reqStyle);
    
    else,
        styleIndex = reqStyle;
    
    end

    styleHandle = wordActiveX_GLOBAL.ActiveDocument.Styles;

    nStyles = styleHandle.Count;
    
    % force into accepted range
    styleIndex = max(1, min(nStyles, styleIndex));

    docStyle = styleHandle.Item(styleIndex);
    
catch,
    fprintf('%s: could not get doc style\n', mfilename);
    
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
