function [this_slide] = SetSlideTitle(this_slide,title)

%
% this_slide.m
%

this_slide.Shapes.Item(1).TextFrame.TextRange.Text=title;