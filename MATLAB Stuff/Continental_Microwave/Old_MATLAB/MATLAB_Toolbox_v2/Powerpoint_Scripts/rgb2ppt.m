function [ppt_color] = rgb2ppt(rgb)

%
% rgb2ppt.m converts r,g,b values in the 0-255 range to the rgb value
%   required by powerpoint objects
%
% ppt_color=rgb2ppt(rgb), where rgb is the vector [r,g,b], 
%   with 0<= r,g & b <256
% 

r=rgb(1);
g=rgb(2);
b=rgb(3);

ppt_color=single(r+256*g+256*256*b);