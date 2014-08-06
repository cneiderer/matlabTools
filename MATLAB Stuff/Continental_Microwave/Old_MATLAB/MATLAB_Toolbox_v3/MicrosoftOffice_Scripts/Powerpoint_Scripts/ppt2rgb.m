function [rgb] = ppt2rgb(ppt_color)

%
% ppt2rgb.m converts r,g,b values in the 0-255 range to the rgb value
%   required by powerpoint objects
%
% rgb=ppt_RGB(r,g,b) where 0<= r,g & b <256
%

ppt_color=double(ppt_color);
b=floor(ppt_color/256^2);
ppt_color=mod(ppt_color,256^2);
g=floor(ppt_color/256);
r=mod(ppt_color,256);
rgb=[r,g,b];