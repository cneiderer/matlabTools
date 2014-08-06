function [cti_file_list] = get_cti_files

%
% get_cti_files.m
%
% Description:
%   Prompts user to select sets of *.cti files for analysis, then creates a
%   detailed file list
%
% Inputs:
%   Prompted internally for *.cti file selection
%
% Outputs:
%   cti_file_list   ->  passed back to spec_analysis_calc.m
%
% Author:
%   Curtis Neiderer, 1/6/2009
%
% Notes / Changes:
%   Date: 1/13/2009
%   Change 1.1
%       Added capability to select *.s2p files as well as *.cti files
%   Date: 1/13/2009
%   Change 1.2
%       Added capability to select a single file as well as a set of files
%


xx=1;
cnt=0;
while xx
    
    cnt=cnt+1;
    
    % Select set of *.cti or *.s2p files for analysis
    clear load_filenames loadfiles_path
    [load_filenames,loadfiles_path]=uigetfile({'*.cti';'*.s2p'},...
        'Select the "*.cti" or "*.s2p" files to be analyzed:',...
        'MultiSelect','on');

    % Test to make sure you selected a set of files
    if ~iscell(load_filenames) && ~isstr(load_filenames)
        xx=0;
        warning('You did not select a set *.cti files')
        
        % More files (Y/N)???
        xx=select_another_set_of_cti_files;
        
    else    
        if isstr(load_filenames)
            load_cti_files(cnt).filenames=load_filenames;
        else
            load_cti_files(cnt).filenames=load_filenames';
        end
        load_cti_files(cnt).path=loadfiles_path;
        
        % Find system name from load_path
        path_breaks=regexpi(loadfiles_path,'\');
        system_name=path_breaks(3)+1:path_breaks(4)-1;
        load_cti_files(cnt).system_name=loadfiles_path(system_name);
        
        % Find data type from load_path
        path_breaks=regexpi(loadfiles_path,'\');
        data_type=path_breaks(end-1)+1:path_breaks(end)-1;
        load_cti_files(cnt).data_type=loadfiles_path(data_type);

        % Display the path you just selected
        disp(['--Selected Path: ',loadfiles_path])
        disp(['  System Name: ',loadfiles_path(system_name)])
        disp(['  Data Type: ',loadfiles_path(data_type)])
        
        % More files (Y/N)???
        xx=select_another_set_of_cti_files;
        
    end
        
end


test=0;


% Format for output
cti_file_list=[];
cnt2=0;
if exist('load_cti_files','var')

    for ii=1:length(load_cti_files)
        if isstr(load_cti_files(ii).filenames)
            cnt2=cnt2+1;
            cti_file_list{cnt2,1}=fullfile(load_cti_files(ii).path,load_cti_files(ii).filenames);
            cti_file_list{cnt2,2}=load_cti_files(ii).path;
            cti_file_list{cnt2,3}=load_cti_files(ii).filenames;
            cti_file_list{cnt2,4}=load_cti_files(ii).system_name;
            cti_file_list{cnt2,5}=load_cti_files(ii).data_type;

            % Find band_name and polarization
            [band_name,center_freq,polarization]=get_file_info(load_cti_files(ii).filenames);
            cti_file_list{cnt2,6}=band_name;
            cti_file_list{cnt2,7}=center_freq;
            cti_file_list{cnt2,8}=polarization;
        else
            for jj=1:length(load_cti_files(ii).filenames)
                cnt2=cnt2+1;
                cti_file_list{cnt2,1}=fullfile(load_cti_files(ii).path,load_cti_files(ii).filenames{jj});
                cti_file_list{cnt2,2}=load_cti_files(ii).path;
                cti_file_list{cnt2,3}=load_cti_files(ii).filenames{jj};
                cti_file_list{cnt2,4}=load_cti_files(ii).system_name;
                cti_file_list{cnt2,5}=load_cti_files(ii).data_type;

                % Find band_name and polarization
                [band_name,center_freq,polarization]=get_file_info(load_cti_files(ii).filenames{jj});
                cti_file_list{cnt2,6}=band_name;
                cti_file_list{cnt2,7}=center_freq;
                cti_file_list{cnt2,8}=polarization;
            end
        end
    end

    %% Save detailed file list as *.mat file
    save_or_not=save_file_list(cti_file_list);
%     save(fullfile('S:\Curtis_Neiderer\MATLAB_Toolbox\',['selected_file_list_',datestr(now,1),'.mat']),'cti_file_list');

else
   disp('-- No files were selected for analysis') 
end


test=1;


%% --------------- %% Sub-Functions %% --------------- %%

% 
function [load_more] = select_another_set_of_cti_files

% Load more files (Y/N)???
yy=1;
while yy
    more_files=input('Would you like to select another set of files (Y/N)? ','s');
    if strcmpi(more_files,'Y') || strcmpi(more_files,'Yes') || isempty(more_files)
        load_more=1;
        yy=0;
    elseif strcmpi(more_files,'N') || strcmpi(more_files,'No')
        load_more=0;
        yy=0;
    else
        warning('Your answer does not match "Y" or "N", please try again.')
        load_more=1;
        yy=1;
    end
end


% 
function [decision] = save_file_list(cti_file_list)

% (Y/N)???
yy=1;
while yy
    collected_input=input('Would you like to save your selected files into a *.mat file (Y/N)? ','s');
    if strcmpi(collected_input,'Y') || strcmpi(collected_input,'Yes') || isempty(collected_input)
        decision=1;
        yy=0;
        
        % Choose name and location to save *.mat file
        [list_name,list_path]=uiputfile('*.mat','Save detailed file list as *.mat file',['selected_file_list_',datestr(now,1),'.mat']);
        save(fullfile(list_path,list_name),'cti_file_list');
        
    elseif strcmpi(collected_input,'N') || strcmpi(collected_input,'No')
        decision=0;
        yy=0;
    else
        warning('Your answer does not match "Y" or "N", please try again.')
        decision=1;
        yy=1;
    end
end

%
function [band_name,center_freq,polarization] = get_file_info(current_filename)

% Find polarization 
if ~isempty(strfind(upper(current_filename),'RH'))
    polarization='RH';
elseif ~isempty(strfind(upper(current_filename),'LH'))
    polarization='LH';
else
    error(['Could not determine the polarization of: ',current_filename])
end

% Find center_freq & band_name
switch 1
    case ~isempty(strfind(current_filename,'14.615'))
        center_freq=14.615;
        band_name='Ku-CDL RL';
    case ~isempty(strfind(current_filename,'15.25'))
        center_freq=15.25;
        band_name='Ku-CDL FL';
    case ~isempty(strfind(current_filename,'10.3'))
        center_freq=10.3;
        band_name='X-CDL RL';
    case ~isempty(strfind(current_filename,'15.19'))
        center_freq=15.19;
        band_name='N-CDL OL';
    case ~isempty(strfind(current_filename,'14.665'))
        center_freq=14.665;
        band_name='N-CDL IL';
    case ~isempty(strfind(current_filename,'11.85'))
        center_freq=11.85;
        band_name='Intelsat DL';
    case ~isempty(strfind(current_filename,'9.85'))
        center_freq=9.85;
        band_name='X-CDL FL';
    case ~isempty(strfind(current_filename,'14.125'))
        center_freq=14.125;
        band_name='Intelsat UL';
    otherwise
        disp('center_freq and band_name could not be determined from the file name')
end