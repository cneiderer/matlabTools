function [rgb] = ppt_RGB(r,g,b)

%
% ppt_RGB.m converts r,g,b values in teh 0-255 range to the rgb value
%   required by powerpoint objects
%
% rgb=ppt_RGB(r,g,b) where 0<= r,g & b <256
%

rgb=r+256*g+256*256*b;