function [out_val] = copyObject2ppt(ole_object,ppt_slide)

%
% copyObject2ppt.m copies any valid OLE object to a powerpoint slide
%
% copyObject2ppt(ole_object,ppt_slide) copies OLE object into the
%   ppt_slide as an OLE object
%

ole_object.Copy();
[out_val]=ppt_slide.Shapes.PasteSpecial(10); % 10 means paste as an OLE object