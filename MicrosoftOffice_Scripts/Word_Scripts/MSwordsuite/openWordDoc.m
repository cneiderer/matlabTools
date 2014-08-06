function wordDoc = openWordDoc(fileName)
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
global wordSavePath_GLOBAL;

if(~exist('fileName', 'var')),
    wordDoc.fileName = [wordSavePath_GLOBAL, datestr(datevec(now), 30), '.doc'];

else,
    wordDoc.fileName = fileName;
end

try,
    if(~exist(wordDoc.fileName,'file')),
        try,
            wordDoc.handle = invoke(wordActiveX_GLOBAL.Documents, 'Add');
        catch,
            fprintf('%s: could not create document\n', mfilename);
        end

    else
        try,
            wordDoc.handle = invoke(wordActiveX_GLOBAL.Documents, 'Open', wordDoc.fileName);
        catch,
            fprintf('%s: could not open document\n', mfilename);
        end            
    
    end
    
catch,
    fprintf('%s: word not ready\n', mfilename);

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
