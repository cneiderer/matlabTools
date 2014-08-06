function [table] = AddTable(slide,position,rows,cols)

%
% AddTable.m
%

table=slide.Shapes.AddTable(rows,cols);
table.Left=position(1);
table.Top=position(2);
table.Width=position(3);
table.Height=position(4);