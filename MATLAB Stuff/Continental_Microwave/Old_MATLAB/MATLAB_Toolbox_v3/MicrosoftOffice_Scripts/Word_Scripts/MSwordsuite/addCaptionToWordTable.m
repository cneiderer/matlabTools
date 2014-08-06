function addCaptionToWordTable(tableIndex, theString)
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
    shapeInterfaceVec = wordActiveX_GLOBAL.ActiveDocument.Tables;
    numTables         = shapeInterfaceVec.Count;

catch,
    fprintf('%s: cound not query word tableture count\n', mfilename);
    return;

end

theTable = [];

if(~isempty(tableIndex)),
    theTable = min(numTables, max(1, tableIndex));
end

% prepend a ", " to the string
try,
    if(isempty(theString)),
        theString = ', table text TBR';
    else,
        theString = [', ', theString];
    end
catch,
    theString = ', table Text TBR';
end

try,

    if(~isempty(theTable)),
        tableHandle = shapeInterfaceVec.Item(theTable);
        tableHandle.Select;
    end;

    atCursor = wordActiveX_GLOBAL.Selection;

    atCursor.MoveRight;
    atCursor.TypeParagraph;

    atCursor.InsertCaption('Table', theString);
    atCursor.TypeParagraph;

catch,
    fprintf('%s: failed to append caption to word table\n', mfilename);

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
