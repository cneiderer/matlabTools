function copyTableToWord(dataCell, captionText, makeTight)
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

% copy cell -->string<-- data to a word table
% if makeTight == 1, the table will stretch to fill the contents
% if makeTight == 0, the table is already maximum size

try,
    % data cell dimensions
    [nRow, nCol] = size(dataCell);

    % make room at the current cursor location
    wordActiveX_GLOBAL.Selection.TypeParagraph;
    
    skinny = true;
    try,
        if(makeTight == 0),
            skinny = false;
        end
    catch,
    end
    
    if(skinny == true),
        wordActiveX_GLOBAL.ActiveDocument.Tables.Add(wordActiveX_GLOBAL.Selection.Range, nRow, nCol, 1, 1);
    else,
        wordActiveX_GLOBAL.ActiveDocument.Tables.Add(wordActiveX_GLOBAL.Selection.Range, nRow, nCol, 1, 0);
    end
    
    % copy the cell text
    for rowIndex = 1:nRow,
        for colIndex = 1:nCol,
            matlabString = dataCell{rowIndex, colIndex};

            % only simple text copy
            wordActiveX_GLOBAL.Selection.TypeText(matlabString);
            wordActiveX_GLOBAL.Selection.MoveRight;
        end
    end
            
    % add the table caption - inf default for last table
    addCaptionToWordTable(inf, captionText);
    
        
catch,
    fprintf('%s: failed to copy table\n', mfilename);

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
