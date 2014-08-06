function [] = setup_toolbox_paths

% Set your toolbox path
toolbox_path='S:\Curtis_Neiderer\MATLAB_Toolbox';
% Add your toolbox path to the matlab path
addpath(toolbox_path);
% Change directory to your toolbox
cd(toolbox_path);

% Get list of toolbox directories
dir_list=dir(toolbox_path);

% Sort directories to be added to the path
dir_names={};
for i=1:length(dir_list)
    if dir_list(i).isdir && (~strcmp(dir_list(i).name,'.') && ~strcmp(dir_list(i).name,'..'))
        dir_names{end+1,1}=dir_list(i).name;
    end
end

% Add toolbox directories to path
for j=1:length(dir_names)  
    addpath(fullfile(cd,dir_names{j}));
end


