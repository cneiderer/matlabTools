function [] = ppttemplate(templateName)

%
% ppttemplate.m opens powerpoint template file
%

% Start activeX session with Powerpoint:
ppt=actxserver('PowerPoint.Application');
ppt.Visible=1;

% Open template
invoke(ppt.Presentations,'Open',templateName);

release(ppt);