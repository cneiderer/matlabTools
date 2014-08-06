function [] = pptsave(pptName)

%
% pptsave.m saves the powerpoint report specified
%

ppt=actxserver('PowerPoint.Application');
activePresentation=ppt.ActivePresentation;

% if ~exist(pptName,'file')
%     % Save file as new:
    invoke(activePresentation,'SaveAs',pptName,1);
% else
%     % Save existing file:
%     invoke(activePresentation,'Save');
% end

% % Close the presentation window:
% invoke(activePresentation,'Close');

% % Quit Powerpoint
% invoke(ppt,'Quit');

% Close Powerpoint and terminate activeX:
delete(ppt);

clear global pastedPlotStruct