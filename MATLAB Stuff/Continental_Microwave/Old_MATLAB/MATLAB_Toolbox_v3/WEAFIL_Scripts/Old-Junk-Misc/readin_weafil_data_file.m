function [] = readin_weafil_data_file(varargin)

%
% readin_weafil_data_file.m
%

if naragin==2
    WEAFIL_file=varargin{1};
    HFSS_proj=varargin{2};
elseif nargin==1
    WEAFIL_file=varargin{1};
elseif narargin==0
    [filename,filepath]=uigetfile('*.dat','Select the WEAFIL *.dat file');
    WEAFIL_file=fullfile(filepath,filename);
end

%% Open file from within MATLAB
fid=fopen(WEAFIL_file,'rt');

%% Read in first line to get filter type
type_line=fgetl(fid);
filter_type=type_line(38:40);

switch filter_type
    case 'WGD'
        filter_info=parseWGD(fid);
    case 'CLD'
        filter_info=parseCLD(fid);
        
        %% Create *.vbs file for HFSS
        if strcmpi(filter_info.load_type,'Lumped')
            lumped_loading_vbs(filter_info,HFSS_proj);
        elseif strcmpi(filter_info.load_type,'Resonator')
            resonator_loading_vbs(filter_info,HFSS_proj);
        elseif strcmpi(filter_info.load_type,'Cover')
            cover_loading_vbs(filter_info,HFSS_proj); 
        end
        
    case 'IDD'
        filter_info=parseIDD(fid);
    otherwise
        error('Filter type was not determined correctly')
end
