function READ_ME_HOW_TO_USE
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

% example function - yes you should run it at the matlab command line....

% initialize word
% open multiple word documents
% for each document:
%    initialize various word styles
%    create a default cover page
%    create the headers and footers
%    insert some text with various (or default) sizes, colors and settings
%    create and resize some graphs from matlab with a caption
%    create and resize some tables from matlab with a caption
%    insert line breaks and page breaks
%    save the resulting documents
%    close the documents
% close word

% at one point, every function was being used in a report generator. since
% then, some of the functions were modifed but not tested against all
% possible scenarios. so, if you find a problem, send a comment to the
% mathworks site and I'll update the suite as necessary. - michael

clc;
close all


% we will open 5 documents
nDoc = 5;

% we will save them in the current working directory
% I don't check for read permissions etc....
savePath = pwd;
if(savePath(end) ~= filesep),
    savePath = [savePath, filesep];
end

% default headers and footers - you don't need these but they are nice if
% you want to put your organizations name here...............
headerText = 'DEFAULT HEADER TEXT';
footerText = 'DEFAULT FOOTER TEXT';

% initialize the word globals - you must run this first
initWordGlobals; 

% query the windows registery, find and execute ms word
% notice there are no parameters to pass.
try,
    openWord; % <-- no parameters in OR out.....
catch,
    fprintf('oops\n');
    return;
end
% normally I put all the code into a huge try catch block but
% I did it above instead

% iterate over each word document
for docIndex=1:nDoc,
    
    % create a document name - I used "00000x.doc", 
    docName = sprintf('%s%06d.doc', savePath, docIndex);
    
    % open the document
    wDoc(docIndex) = openWordDoc(docName);
    
    % choose the document to activate (it receives inputs etc)
    % we could choose any document to activate. we choose them in order
    % because I am lazy and its is late...
    wordDocActivate(wDoc(docIndex));
    
    % setup the headers and footers - you can skip this
    copyStringToHeader(headerText);
    copyStringToFooter(footerText);
    
    % set the default heading styles for Header 1, Header 2, etc.
    setDefaultHeadingStyles;
    
    % create the default style structure for regular text
    defaultCS = createStyleStruct;
    
    % create a fancy style struct for bold text
    fontName   = 'Ariel';
    fontSize   = ceil(6+12*rand);
    fontBold   = true;
    
    fancyCS = createStyleStruct(fontName, fontSize, fontBold);
    
    % create an ultra fancy style struct using the above with italic and
    % double underlines and color (mike you tease!)
    fontItalic = true;
    
    % add the underline count: (0, 1, or 2)
    fontUnderline = 2;
    
    % create a red-blue font, use matlab's color scheme    
    r = floor(256 * rand);
    g = floor(256 * rand);
    b = floor(256 * rand);
    
    fontColor = [r, g, b]; % the matlab font color
        
    % create the font
    superfancyCS = createStyleStruct(fontName, fontSize, fontBold, ...
        fontItalic, fontUnderline, fontColor);
    
    % using our styles, send some text to each document
    
    % create some header strings
    headerString1 = sprintf('Document %d, Heading level 1', docIndex);
    headerString2 = sprintf('Document %d, Heading level 2', docIndex);
    headerString3 = sprintf('Document %d, Heading level 3', docIndex);
        
    % write the headers using the above text strings
    setHeadingText(1, headerString1);
    setHeadingText(2, headerString2);
    setHeadingText(3, headerString3);
    
    % you will probably use the 'copyStringToWord' more than anything else
    % open it up and see how I wrote its algorithm....
    
    % copy some default font text - one line break before and none after
    % that is the [1, 0] thingy at the end
    nLine = ceil(rand * 10);
    for plText=1:nLine,
        lineOtext = sprintf('this is plain text line %d of %d', ...
            plText, nLine);  % <- notice there is no new line [\n] here...
        copyStringToWord(lineOtext, [1, 0]);
    end
            
    % send some text with fancy formatting - one line break before, none
    % after - ditto about thingy
    nLine = ceil(rand * 10);
    for plText=1:nLine,
        lineOtext = sprintf('this is bold text line %d of %d', ...
            plText, nLine);  % <- notice there is no new line [\n] here...
        
        copyStringToWord(lineOtext, [1, 0], fancyCS);
    end
    
    % send some text with super fancy formatting - one line break before, 
    % two after - the [1, 2] thingy
    nLine = ceil(rand * 10);
    for plText=1:nLine,
        lineOtext = sprintf('this is super fancy text line %d of %d', ...
            plText, nLine);  % <- notice there is no new line [\n] here...

        % dynamic changes to font structure.....
        superfancyCS = createStyleStruct(fontName, fontSize-4 + 2*plText, ...
            fontBold, fontItalic, fontUnderline, fontColor);

        copyStringToWord('this is fancy text. ', [1, 2], superfancyCS);
    end
    
    % create a figure in matlab
    myFigure = figure;
    
    % springs for plots....
    t = linspace(0, 8*pi, 1000);
    x = cos(t);
    y = docIndex .* sin(t);
    z = t.^(1+docIndex);
   
    pHnd = plot3(x, y, z);
    grid on
    
    % rotate it randomly
    view((rand - 0.5) * 180, (rand - 0.5) * 180);
    
    % example plot
    plotColor = rand(1, 3);
    set(pHnd, 'color', plotColor, 'linewidth', 3);
    
    % simple labels
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    
    % title
    tHnd = title(sprintf('example plot for document %d', docIndex));
    
    % match plot and title colors.....
    set(tHnd, 'color', plotColor, 'fontsize', 14);
    
    % stuff the figure into word AND resize it so that it looks nice and
    % also include a caption so you can create a table of figures if you
    % want to later (must be done manually).
    
    % rows by cols inches ie 2 x 3 inches and sized to document by index...
    picSizeInches = [2+docIndex/2, 3+docIndex/3];  
    
    % create a caption
    picCaption = sprintf('this is a simple figure caption for a figure in doc %d', docIndex);
    
    % copy the figure along with the caption and use words auto-indexing for
    % the captions -- Yes that's right, auto captioning (oh mike!)
    copyFigToWord(picSizeInches, myFigure, picCaption);
        
    % let's send the matlab image again but this time with all defaults
    % ie. there will be a default caption.
    copyFigToWord;  % <- no parameters here...
    
    % close all matlab figure
    close all; 
    
    % insert a page break into the active document word
    insertWordPageBreak;

    % now lets create a matlab matrix - you MUST create a text cell array
    myMatrix = cell(3,5); % <- 3 rows (vertical) X 5 cols (horizontal)
    
    % populate it with simple text
    for row=1:size(myMatrix, 1),
        for col=1:size(myMatrix, 2),
            
            % PRINT text into the cells of the matlab cell array 
            myMatrix{row, col} = sprintf('Value: %03d', 10*row + col);
        end
    end
        
    % shove the text matrix (cell array) into word with a caption
    % this is a tight table
    makeTight = true;  % <- this means the cell snugs against the text
    copyTableToWord(myMatrix, 'this is a tight table', makeTight);
    
    % this is a loose table
    makeTight = false; % <- this means the cell is not snug aginst the text
    copyTableToWord(myMatrix, 'this is a loose table', makeTight);

    % copy the text cell array into word. include a space before and after
    % that [1, 1] thingy again...
    copyStringToWord('That''s all folks !!', [1, 1]);

    % save the document to the pwd
    saveWordDoc(wDoc(docIndex));
    
    % close the word doc
    closeWordDoc(wDoc(docIndex));
    
end

% shutdown word
closeWord;


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
