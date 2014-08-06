function [table] = AddCellText(table,row,col,string,varargin)

% insert text
table.Table.Rows.Item(row).Cells.Item(col).Shape.TextFrame.TextRange.Text=string;

% Apply properties, if any
if (nargin >4) && ~isempty(varargin{1})
    
    textprops=varargin{1};
    
    if (isfield(textprops,'FontColor'))
        FontColor=rgb2ppt(textprops.FontColor);
        table.Table.Rows.Item(row).Cells.Item(col).Shape.TextFrame.TextRange.Font.Color.RGB=FontColor;
    end
    
    if (isfield(textprops,'FillColor'))
        FillColor=rgb2ppt(textprops.FillColor);
        table.Table.Rows.Item(row).Cells.Item(col).Shape.Fill.BackColor.RGB=FillColor;
        table.Table.Rows.Item(row).Cells.Item(col).Shape.Fill.ForeColor.RGB=FillColor;
        table.Table.Rows.ITem(row).Cells.Item(col).Shape.Fill.Visible='msoTrue';
    end
    
    if (isfield(textprops,'Alignment'))
        if (strcmp(upper(textprops.Alignment),'LEFT')
            table.Table.Rows.Item(row).Cells.Item(col).Shape.TextFrame.TextRange.ParagraphFormat.Alignment='ppAlignLeft';
        elseif (strcmp(upper(textprops.Alignment),'RIGHT')
            table.Table.Rows.Item(row).Cells.Item(col).Shape.TextFrame.TextRange.ParagraphFormat.Alignment='ppAlignRight';
        elseif (strcmp(upper(textprops.Alignment),'CENTER')
            table.Table.Rows.Item(row).Cells.Item(col).Shape.TextFrame.TextRange.ParagraphFormat.Alignment='ppAlignCenter';
        end
    end
    
    table.Table.Rows.Item(row).Cells.Item(col).Shape.TextFrame.VerticalAnchor='msoAnchorMiddle';
    
    if (isfield(textprops,'FontSize'))
        table.Table.Rows.Item(row).Cells.Item(col).Shape.TextFrame.TextRange.Font.Size=textprops.FontSize;
    end
    
    if isfield(textprops,'CellWidth')
        table.Table.Columns.Item(col).Width=textprops.CellWidth;
    end
    
    if isfield(textprops,'CellHeight')
        table.Table.Rows.Item(row).Height=textprops.CellHeight;
    end
end