function [] = setup_toolbox_paths_ver2

% Set your toolbox path
% toolbox_path='C:\MATLAB_Toolbox';
toolbox_path='S:\Curtis_Neiderer\MATLAB_Toolbox';
% Add your toolbox path to the matlab path
addpath(toolbox_path);
% Change directory to your toolbox
cd(toolbox_path);

% Get all directory paths
xx=1;
dir_paths={toolbox_path};
overall_path_list=[];
while xx
    
    overall_path_list=update_overall_path_list(overall_path_list,dir_paths);
    
    % Find directories within dir_paths
    [dir_paths]=find_dir_paths(dir_paths);
    overall_path_list=update_overall_path_list(overall_path_list,dir_paths);
    
    % Test new dir_paths list for existence of directories within
    [dir_paths]=test_paths_for_dirs(dir_paths);
    
    % If updated dir_paths isempty, set xx=0 to exit while loop
    if isempty(dir_paths)
        xx=0;
    end
    
end

% Add toolbox directories to path & display
disp('Toolbox directories added to MATLAB path: ')
for yy=1:length(overall_path_list)  
    addpath(overall_path_list{yy});
    disp(['--Added: ',overall_path_list{yy}])
end



%% ---------- %% Sub-Functions %% ---------- %%

% ----- update_overall_path_list.m ----- %
function [overall_path_list] = update_overall_path_list(overall_path_list,dir_paths)

overall_path_list=[overall_path_list;dir_paths];

% ----- find_dir_paths ----- %
function [dir_paths_new] = find_dir_paths(dir_paths)

for kk=1:length(dir_paths)

    % Get directory list
    dir_list=dir(dir_paths{kk});

    % Sort out actual directories from files
    actual_dirs={};
    for ii=1:length(dir_list)
        if dir_list(ii).isdir && (~strcmp(dir_list(ii).name,'.') && ~strcmp(dir_list(ii).name,'..'))
            actual_dirs{end+1,1}=dir_list(ii).name;
        end
    end

    % Form directory paths for output
    dir_paths_new={};
    if ~isempty(actual_dirs)
        for jj=1:length(actual_dirs)
            dir_paths_new{end+1,1}=fullfile(dir_paths{kk},actual_dirs{jj});
        end
    end
    
end

% ----- test_paths_for_dirs.m ----- %

function [dir_paths_updated] = test_paths_for_dirs(dir_paths)

% Test dir_paths for directories
dir_paths_updated={};
for jj=1:length(dir_paths)

    dir_list=dir(dir_paths{jj});

    % Sort out actual directories from files
    actual_dirs={};
    for ii=1:length(dir_list)
        if dir_list(ii).isdir && (~strcmp(dir_list(ii).name,'.') && ~strcmp(dir_list(ii).name,'..'))
            actual_dirs{end+1,1}=dir_list(ii).name;
        end
    end

    if ~isempty(actual_dirs)
        for zz=1:length(actual_dirs)
            dir_paths_updated{end+1,1}=fullfile(dir_paths{jj},actual_dirs{zz});
        end
    end
            
end