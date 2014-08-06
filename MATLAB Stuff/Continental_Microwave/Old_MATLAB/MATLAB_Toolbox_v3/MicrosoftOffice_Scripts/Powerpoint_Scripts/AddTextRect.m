function [newshape] = AddTextRect(slide,text,textareain,varargin)

%
% AddTextRect.m
%

textarea=fix(textareain);
newshape=slide.Shapes.AddTextbox('msoTextOrientationHorizontal',...
    textarea(1),textarea(2),textarea(3),textarea(4));

if (nargin==4)
    textprops=varargin{1};
    if (isfield(textprops,'Border'))
        if (strcmp(upper(textprops.Border),'ON'))
            newshape.Line.Visible='msoTrue';
        elseif (strcmp(upper(textprops.Border), 'OFF'))
            newshape.Line.Visible='msoFalse';
        end
    end
    
    if (isfield(textprops,'FillColor'))
        FillColor=rgb2ppt(textprops.FillColor);
        newshape.Fill.BackColor.RGB=FillColor;
        newshape.Fill.ForeColor.RGB=FillColor;
        newshape.Fill.Visible='msoTrue';
    end
    
    if(isfield(textprops,'Alignment'))
        if (strcmp(upper(textprops.Alignment),'LEFT'))
            newshape.TextFrame.TextRange.ParagraphFormat.Alignment='ppAlignLeft';
        elseif (strcmp(upper(textprops.Alignment),'RIGHT'))
            newshape.TextFrame.TextRange.ParagraphFormat.Alignment='ppAlignRight';
        elseif (strcmp(upper(textprops.Alignment),'CENTER'))
            newshape.TextFrame.TextRange.ParagraphFormat.Alignment='ppAlignCenter';
        end
    end
    
    if (isfield(textprops,'FontColor'))
        FontColor=rgb2ppt(textprops.FontColor);
        newshape.TextFrame.TextRange.Font.Color.RGB=FontColor;
    end
    
    if (isfield(textprops,'FontSize'))
        newshape.TextFrame.TextRange.Font.Size=textprops.FontSize;
    end
end