function [] = PasteFigureToTag(ppt,hFigure,tag);

%
% PasteFigureToTag.m
%

for iSlide=1:ppt.Pres.Slides.Count
    Shapes=ppt.Pres.Slides.Item(iSlide).Shapes;
    
    for jShape=1:Shapes.Count
        shapetag=Shapes.Item(jShape).TextFrame.TextRange.Text;
    
        if (strcmp(upper(tag),upper(shapetag)))
            figure(hFigure);
            drawnow;
            print(hFigure,'-dbitmap');
        
            % paste in Figure
            newshape=ppt.Pres.Slides.Item(iSlide).Shapes.Paste;
            
            % compute relative scale factors to make th figure fit in the
            % specified rectangle (maintaining aspect ratio)
            scalew=Shapes.Item(jShape).Width/newshape.Width;
            scaleh=Shapes.Item(jShape).Height/newshape.Height;
            scale=min(scalew,scaleh);
            
            cx=Shapes.Item(jShape).Left+Shapes.Item(jShape).Width/2.0;
            cy=Shapes.Item(jShape).Top+Shapes.Item(jShape).Height/2.0;
            
            newshape.Left=fix(cx-newshape.Width*scale/2.0);
            newshape.Top=fix(cy-newshape.Height*scale/2.0);
            newshape.Height=fix(newshape.Height*scale);
            
            Shapes.Item(jShape).Delete;
            return;
        end
    end
end