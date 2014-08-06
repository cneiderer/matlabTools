function addWordPageNumbers
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

% its best to use this function after other text is added to the footer.
% so, if you use copyStringToFooter, and want to add page numbers, use
% addWordPageNumbers last.

try,
    % short name for footer access - put into primary section. if you want
    % to add to other sections, over the items .Item(1) --> .Items(k),
    % where k iterates over the count. you obtain the count as follows:
    % count = wordActiveX_GLOBAL.ActiveDocument.Sections.Count;
    footer = wordActiveX_GLOBAL.ActiveDocument.Sections.Item(1).Footers.Item('wdHeaderFooterPrimary');
    footer.PageNumbers.Add;
    
    % the page numbers are probably in the top left. We will move them to
    % the top right
    footer = footer.Range;
    
    % get the paragraphs in the footer
    paragraphs = footer.Paragraphs;
    
    % the page number will be first and the other text will follow in this
    % rouine.
    pageNumber = footer.paragraphs.Item(1);
    
    % now lets put it to the right - you can see how to align it left,
    % center or right based on the following
    pageNumber.Alignment = 'wdAlignParagraphRight';
            
catch,
    fprintf('%s: could not add footer page numbers text\n', mfilename);

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
