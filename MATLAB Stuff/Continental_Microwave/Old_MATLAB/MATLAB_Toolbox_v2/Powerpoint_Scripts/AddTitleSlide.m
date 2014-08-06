function  [new_slide] = AddTitleSlide(pres,pres_title,pres_subtitle)

%
% AddTitleSlide.m
%

new_slide=pres.Slides.Add(pres.Slides.Count+1,'pptLayoutTitle');
set(new_slide.Shapes.Title.TextFrame.TextRange,'Text',pres_title);

if exist('pres_subtitle','var') && ~isempty(pres_subtitle)
    set(new_slide.Shapes.Item(2).TextFrame.TextRange,'Text',pres_subtitle);
end