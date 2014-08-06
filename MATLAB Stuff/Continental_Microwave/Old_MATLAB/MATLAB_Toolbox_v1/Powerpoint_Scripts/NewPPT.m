function [pres] = NewPPT(template_path,file_name,pres)

%
% NewPPT.m
%
% Opening and applying template 
%

% 'pres' is an already-open presentation; if we have one, then skip this 
if ~exist('pres','var') || isempty(pres) || pres==0
    ppt=actxserver('PowerPoint.Application');
    
    % Activate Powerpoint and then minimize it
    ppt.Activate;
    ppt.WindowState=2;
    
    if exist(file_name,'file')==2 % going to add slides to this presenation
        pres=invoke(ppt.Presentations,'Open',file_name,[],[],-1);
    else % make a new presentation
        pres=invoke(ppt.Presenations,'Add');
        pres.ApplyTemplate(template_path);
    end
end

