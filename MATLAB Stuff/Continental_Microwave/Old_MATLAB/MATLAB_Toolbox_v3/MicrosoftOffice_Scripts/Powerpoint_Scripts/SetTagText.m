function [] = SetTagText(ppt,TagText,tag)

%
% SetTagText.m
%

for iSlide=1:ppt.Pres.Slides.Count
    Shapes=ppt.Pres.Slides.Item(iSlide).Shapes;
    
    for jShape=1:Shapes.Count
        shapetag=Shapes.Item(jShape).TextFrame.TextRange.Text;
        
        if (strncmp(upper(tag),upper(shapetag),length(tag)))
            Shapes.Item(jShape).TextFrame.TextRange.Text=TagText;
            return;
        end
    end
end