function [] = AddBullett(shape,bullet,indent)

%
% AddBullett.m
%
% Example of usage:
%   shape=AddTextRect(slide,'text',[36,126,648,150]);
%   AddBullett(shape,'more text',1);
%

thisline=shape.TextFrame.TextRange.Lines.Count;
shape.TextFrame.TextRange.Lines.InsertAfter([bullet,13]);
shape.TextFrame.TextRange.Lines(thisline+1).IndentLevel=indent;