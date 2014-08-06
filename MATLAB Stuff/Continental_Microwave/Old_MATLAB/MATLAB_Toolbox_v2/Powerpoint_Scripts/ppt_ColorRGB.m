function [r,g,b] = ppt_ColorRGB(ppt_color)

%
% ppt_ColorRGB.m converts r,g,b values in the 0-255 range to the rgb value
%   required by powerpoint objects
%
% rgb=ppt_RGB(r,g,b) where 0<= r,g & b <256
%

b=floor(ppt_color/(256^2));
ppt_color=ppt_color-(b*256^2);
g=floor(ppt_color/256);
r=ppt_color-(g*256);