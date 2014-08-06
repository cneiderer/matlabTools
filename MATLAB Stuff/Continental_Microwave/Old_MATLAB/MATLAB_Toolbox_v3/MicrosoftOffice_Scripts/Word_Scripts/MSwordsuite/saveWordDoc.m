function wordDoc = saveWordDoc(wordDoc)
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
    index = strfind(wordDoc.fileName, '.doc');
    
    if(isempty(index)),
        wordDoc.fileName = [wordDoc.fileName, '.doc'];
    
    else,
        index = index(end);
        if((length(wordDoc.fileName) - index) ~= 3),
            wordDoc.fileName = [wordDoc.fileName, '.doc'];
        end
    
    end

    if(~exist(wordDoc.fileName,'file'))
        invoke(wordDoc.handle,'SaveAs', wordDoc.fileName, 1);
        
    else
        invoke(wordDoc.handle,'Save');
    
    end

catch,
    fprintf('%s: word not save correctly\n', mfilename);
    
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
