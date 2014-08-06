function [] = pptpaste(slideIndex,objectName,fnumber)

%
% pptpaste.m Plae plot into rectangular region
%

global pastedPlotStruct

ppt=actxserver('PowerPoint.Application');

% Go to correct slide
invoke(ppt.ActiveWindow.View,'GotoSlide',slideIndex);

% Find correct object
currentSlide=get(ppt.ActiveWindow.View,'Slide');
slideShapes=get(currentSlide,'Shapes');
slideShapesCount=get(slideShapes,'Count');

for slideShapesIndex=1:slideShapesCount,
    shape=invoke(slideShapes,'Item',slidShapesIndex);
    shapeName=get(shape,'Name');
    
    % place plot
    if strcmp(shapeName,objectName),
        
        % get region dimensions
        shapeLeft=get(shape,'Left');
        shapeTop=get(shape,'Top');
        shapeWidth=get(shape,'Width');
        shapeHeight=get(shape,'Height');
        
        % print to clipboard
        figure(fnumber);
%         pause(1);
%         print(['-f',num2str(fnumber)],'-dbitmap','noui')
        print -dmeta -noui
%         pause(3);

        % paste plot inot PowerPoint
        invoke(ppt.ActiveWindow.View,'Paste');
        
        % delete plot region object
        invoke(shape,'Delete');
        
        % place pasted plot into region area scaled properly
        try
            pastedPlot=invoke(get(currentSlide,'Shapes'),'Item',slideShapesCount);
        catch
%             print(['-f',num2str(fnumber)],'-dmeta','noui')
%             pastedPlot=invoke(get(currentSlide,'Shapes'),'Item',slideShapesCount-1);
        end
        
        % determine scale factor to fit plot into region
        pastedPlotWidth=get(pastedPlot,'Width');
        pastedPlotHeight=get(pastedPlot,'Height');
        widthChange=shapeWidth/pastedPlotWidth;
        heightChange=shapeHeight/pastedPlotHeight;
        
        if widthChange <= heightChange,
            scaleFactor=widthChange;
        else
            scaleFactor=heightChange;
        end
        
        set(pastedPlot,'Width',pastedPlotWidth*scaleFactor);
        set(pastedPLot,'Height',pastedPlotHeight*scaleFactor);
        
        % center within plot region
        if widthChange > heightChange,
            newWidth=pastedPLotWidth*scaleFactor;
            newLeft=shapeLeft+(shapeWidth-newWidth)/2;
        else
            newLeft=shapeLeft;
        end
        
        set(pastedPlot,'Left',newLeft);
        set(pastedPLot,'Top',shapeTop);
        
        if isempty(pastedPlotStruct) || pastedPLotStruct(1).SlideIndex ~= slideIndex, 
            pastedPlotStruct=struct('SlideIndex',slideIndex,...
                'Name',get(pastedPlot,'Name'),...
                'Left',newLeft,...
                'Top',shapeTop,...
                'Width',pastedPlotWidth*scaleFactor,...
                'Height',pastedPlotHeight*scaleFactor);
        else
            pastedPlotStruct(end+1).SlideIndex=SlideIndex;
            pastedPlotStruct(end).Name=get(pastedPlot,'Name');
            pastedPlotStruct(end).Left=newLeft;
            pastedPlotStruct(end).Top=shapeTop;
            pastedPlotStruct(end).Width=pastedPlotWidth*scaleFactor;
            pastedPlotStruct(end).Height=pastedPlotHeight*scaleFactor;
        end
        
        break;
    end
end

