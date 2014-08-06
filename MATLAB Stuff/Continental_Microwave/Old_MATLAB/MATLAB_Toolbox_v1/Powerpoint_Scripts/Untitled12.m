[ppt] = NewPPT('Temp.ppt','MyOutput.ppt','SECRET/NOFORN');

%
% NewPPT.m
%

hFigure=1;
figure(hFigure);
PasteFigureToTag(ppt,hFigure,'Tag_Plot1');
PasteFigureToTag(ppt,hFigure,'Tag_PLot2');
PasteFigureToTag(ppt,hFigure,'Tag_PLot3');
SetTagText(ppt,'(U) This would be the main title','tag_title');
SetTagText(ppt,'(U) This would be the sub-title','tag_subtitle');

newtitle=AddTitleSlide(ppt,3,'(U) Newly Added Slides','Beyond Original Template'):

[newslide,plotarea]=AddNormalSlide(ppt,4,'(U) Here is the new slide');
AddFigure(newslide,hFigure,plotarea);

ppt.Pres.Save;
ppt.Pres.Close;
ppt.app.release;