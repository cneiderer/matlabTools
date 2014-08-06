function addCaptionToWordFigure(picIndex, theString)
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
    shapeInterfaceVec = wordActiveX_GLOBAL.ActiveDocument.InlineShapes;
    numShapes         = shapeInterfaceVec.Count;

catch,
    fprintf('%s: cound not query word picture count\n', mfilename);
    return;

end

thePic = [];

if(~isempty(picIndex)),
    thePic = min(numShapes, max(1, picIndex));
end
% prepend a ", " to the string
try,
    if(isempty(theString)),
        theString = ', figure text TBR';
    else,
        theString = [', ', theString];
    end
catch,
    theString = ', figure Text TBR';
end

try,

    if(~isempty(thePic)),
        picHandle = shapeInterfaceVec.Item(thePic);
        picHandle.Select;
    end;

    atCursor = wordActiveX_GLOBAL.Selection;

    atCursor.MoveRight;
    atCursor.TypeParagraph;

    atCursor.InsertCaption('Figure', theString);
    atCursor.TypeParagraph;

catch,
    fprintf('%s: failed to append caption to word figure\n', mfilename);

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
