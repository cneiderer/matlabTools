function resizeWordPicture(picIndex, rowColIn)
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

% ms word constant
pointsPerInch = 72;

try,
    shapeInterfaceVec = wordActiveX_GLOBAL.ActiveDocument.InlineShapes;
    numShapes         = shapeInterfaceVec.Count;

catch,
    fprintf('%s: cound not query word picture count\n', mfilename);
    return;

end

if(nargin == 0),
    thePic = numShapes;
end

if(nargin == 1),
    if(isempty(picIndex)),
        thePic = numShapes;
    end

    thePic = min(numShapes, max(1, picIndex));

    picDimIn = [3, 5];
end

if(nargin == 2),
    thePic = min(numShapes, max(1, picIndex));
    
    picDimIn    = rowColIn;
    picDimIn(1) = min(6, max(0.25, picDimIn(1)));
    picDimIn(2) = min(8, max(0.25, picDimIn(2)));
end

try,
    picHandle    = shapeInterfaceVec.Item(thePic);
    rowColPoints = picDimIn .* pointsPerInch;

    % allow arbitrary image resizing
    oldLock = picHandle.LockAspectRatio;
    picHandle.LockAspectRatio = 'msoFalse';
    
    picHandle.Height = rowColPoints(1);
    picHandle.Width  = rowColPoints(2); 

    % reset lock
    picHandle.LockAspectRatio = oldLock;

catch,
    fprintf('%s: picture did not successfully resize\n', mfilename);

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
