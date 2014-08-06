function result = calcWordColor(varargin)
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

result = 0;

try,
    if(nargin == 1),
        rgb = varargin{1};
    elseif(nargin == 3),
        rgb = [varargin{1}, varargin{2}, varargin{3}];
    else,
        fprintf('%s: rquires a 3-vector or 3 scalars as input\n', mfilename);
        return;
    end;
    
    result = bitshift(rgb(3), 8);
    result = bitor(result, rgb(2));
    result = bitshift(result, 8);
    result = bitor(result, rgb(1));
    
catch,
    result = 0;
    fprintf('%s: failed to calculate word color\n', mfilename);
    
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
