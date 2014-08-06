function [] = ppttext(slideIndex,objectName,textData)

%
% ppttext.m places text into textbox region
%

% Go to correct slide
invoke(ppt.ActiveWindow.View,'GotoSlide',slideIndex);

% Find correct object
currentSlide=get(ppt.ActiveWindow.View,'Slide');
slideShapes=get(currentSlide,'Shapes');
slideShapesCount=get(slideShapes,'Count');

for slideShapesIndex=1:slideShapesCount,
    shape=invoke(slideShapes,'Item',slideShapesIndex);
    shapeName=get(shape,'Name');
    
    % place text
    if strcmp(shapeName,objectName),
        set(get(get(shape,'TextFrame'),'TextRange'),'Text',textData);
        break;
    end
end

release(ppt);