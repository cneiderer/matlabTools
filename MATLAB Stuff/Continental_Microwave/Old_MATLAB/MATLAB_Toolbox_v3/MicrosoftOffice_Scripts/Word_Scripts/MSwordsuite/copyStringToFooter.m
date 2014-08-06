function copyStringToFooter(theString, theStyle, theAlignment)
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
    
    % alignment is left, center or right. defaults to center
    try,
        alignStr = 'wdAlignParagraphCenter';

        theAlignment = lower(theAlignment);
        if(strcmp(theAlignment, 'l') || strcmp(theAlignment, 'left')),
            alignStr = 'wdAlignParagraphLeft';
        end
        if(strcmp(theAlignment, 'r') || strcmp(theAlignment, 'right')),
            alignStr = 'wdAlignParagraphRight';
        end
        
    catch,
        alignStr = 'wdAlignParagraphCenter';
    end
    
    % check for a style structure, if its the empty matrix, clear it
    if(exist('theStyle', 'var')),
        if(isempty(theStyle)),
            clear('theStyle');
        end
    end
    
    % if no style structure, create one 
    if(~exist('theStyle', 'var')),
        theFont      = 'Ariel';
        theSize      = 12;
        bold         = true;
        italic       = false;
        numUnderline = 0;
        colorRGB     = [0, 0, 0];

        % create a default style structure - error checking done here
        theStyle = createStyleStruct(theFont, theSize, bold, italic, numUnderline, colorRGB);
    end

    % short names for easy access
    % note, you can monkey with the Item('wdHeaderFooterPrimary') for
    % alternative footer locations such as first page, even pages etc.
    footer = wordActiveX_GLOBAL.ActiveDocument.Sections.Item(1).Footers.Item('wdHeaderFooterPrimary').Range;
    font   = footer.Font;
    
    % set the text
    footer.Text = theString;
    
    % set the style
    font.Name      = theStyle.fontName;
    font.Size      = theStyle.fontSize;
    font.Bold      = theStyle.fontBold;
    font.Italic    = theStyle.fontItalic;
    font.Underline = theStyle.fontUnderline;
    font.Color     = theStyle.fontColor;
    
    % set the alignment
    footer.Paragraphs.Alignment = alignStr;
    
catch,
    fprintf('%s: could not copy footer text\n', mfilename);

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
