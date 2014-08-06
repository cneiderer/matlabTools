function insertWordPageBreak
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
    wordActiveX_GLOBAL.Selection.InsertBreak;
    
catch,
    fprintf('%s: could not insert hard page break\n', mfilename);
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
