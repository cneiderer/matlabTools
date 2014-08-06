function [] = ppt_titleslide(filename,title,subtitle)

%
% ppt_titleslide(filename,title,subtitle) creates a title slide in a
%   powerpoint presentation with the given title and an optional subtitle
%

ppt=actxserver('PowerPoint.Application');

if ~exist(filename,'file')
    op=invoke(ppt.Presentations,'Add');
%     invoke(op,'SaveAs',filename,1);
    op.ApplyTemplate('\\bmdna00\home\neiderc\matlab_analysis\bmds_toolbox\ppt_template_folder\bmds_template.ppt')
else
    op=invoke(ppt.Presentations,'Open',filename,[],[],0);
end

new_slide=invoke(op.Slides,'Add',1,1);
set(new_slide.Shapes.Title.TextFrame.TextRange,'Text',title);

if exist('subtitle') & ~strcmp(subtitle,'')
    set(new_slide.Shapes.Item(2).TextFrame.TextRange,'Text',subtitle);
end

if ~exist(filename,'file')
    invoke(op,'SaveAs',filename,1);
else
    invoke(op,'Save');
end

invoke(op,'Close');

% invoke(ppt,'Quit');
release(ppt);