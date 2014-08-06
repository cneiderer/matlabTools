function WEAFIL_to_HFSS

%
% WEAFIL_to_HFSS.m
%   Version 1: 2/13/2009
%   Supports WEAFIL CLD (lumped)designs only.
%
%   Version 2: 3/6/2009
%   Supports WEAFIL CLD (lumped, resonator & cover loading) designs as well
%   as WEAFIL WGD (vane, round & square iris) designs. 
%
%   Version 3: xx/xx/2009
%   Supports WEAFIL IDD tapped input designs (parallel plate, resonator, &
%   cover loading).
%
%   Version 4: xx/xx/2009
%   Supports WEAFIL CCD designs.
%
% Description:
%   Reads in a WEAFIL data file, finds the filter type, pulls filter specs,
%   and then creates the VBScript macro that will create the model in HFSS.
%
% Inputs:
%   WEAFIL data file    ->  WGD,CLD,IDD, or CCD
%
% Outputs:
%   VBScript file for HFSS  
%
% Author:
%   Curtis Neiderer, 2/12/2009
%
% Notes / Changes:
%   Note 1: 3/4/2009
%   Consider creating a gui where you select the WEAFIL data file and
%   design type to designate the parser and macro builder instead of
%   finding that info from the file.
%
%   Note 2: 3/23/2009
%   All three WGD filter design type scripts are verified and tested.  The
%   CLD lumped loading design is also validated. However, CLD resonator
%   loading and cover loading have yet to be verified as functional.
%
%   Note 3: 3/27/2009
%   CLD resonator loading design is now validated. It's built the way I
%   interpret the WEAFIL file, which could be totally wrong. I have not
%   simulated this design in HFSS yet.
%
%   Note 4: xx/xx/2009
%   IDD parallel plate loading is validated.
%
%   Note 5: xx/xx/2009
%   IDD resonator loading is validated.
%
%   Note 6: xx/xx/2009
%   IDD cover loading is validated.
%

orig_dir=cd;
WEAFIL_dir='S:\Curtis_Neiderer\WEAFIL_Files';
VBS_file_dir='S:\Curtis_Neiderer\VBScript_Files';

cd(WEAFIL_dir);
% Select WEAFIL *.dat file
[WEAFILdatafile,WEAFILdatapath]=uigetfile('*.dat',...
    'Select the WEAFIL *.dat file to make into an HFSS proj');
WEAFIL_file=fullfile(WEAFILdatapath,WEAFILdatafile);

cd(VBS_file_dir);
% Name HFSS *.hfss proj
[pathstr,default_name]=fileparts(WEAFIL_file);
[HFSSprojname,HFSSprojpath]=uiputfile('*.hfss',...
    'Choose a name and location to save the HFSS proj',...
    [default_name,'.hfss']);
HFSS_proj=fullfile(HFSSprojpath,HFSSprojname);

% Return to original directory
cd(orig_dir);

%% Open *.dat file from within MATLAB
fid=fopen(WEAFIL_file,'rt');

%% Set WEAFIL Filter Type
% filter_type=1; % -> WGD
% filter_type=2; % -> CLD
% filter_type=3; % -> IDD
% filter_type=4; % -> CCD
filter_type=input('Select the filter type [1=WGD,2=CLD,3=IDD]: ');

% %% Read in first line to get filter type
% type_line=fgetl(fid);
% filter_type=type_line(38:41);

switch filter_type
    case 1 % 'WGD'
        % Pull design specs out of WEAFIL data file
        disp('*** WEAFIL WGD Design ***')
        filter_info=parseWGD(fid);
        % Find iris type and create VBScript file for HFSS
        if strcmpi(filter_info.iris_type,'Vane') % Vane 
            disp('  -- WGD Iris Type: Vane');
            vane_iris_WGD_vbs(filter_info,HFSSprojname);
        elseif strcmpi(filter_info.iris_type,'Round') % Round
            disp('  -- WGD Iris Type: Round');
            round_iris_WGD_vbs(filter_info,HFSSprojname);
        elseif strcmpi(filter_info.iris_type,'Square') % Square
            disp('  -- WGD Iris Type: Square');
            square_iris_WGD_vbs(filter_info,HFSSprojname);
        else
            error('Could not determine the iris type used!!!')
        end
    case 2 % 'CLD'
        % Pull design specs out of WEAFIL data file
        disp('*** WEAFIL CLD Design ***');
        filter_info=parseCLD(fid);
        % Find loading type and create VBScript file for HFSS
        if strcmpi(filter_info.load_type,'Lumped') % Lumped Loading
            disp('  -- CLD Load Type: Lumped Loading');
            lumped_loading_CLD_vbs(filter_info,HFSSprojname); 
        elseif strcmpi(filter_info.load_type,'Resonator') % Resonator Loading
            disp('  -- CLD Load Type: Resonator Loading');
            resonator_loading_CLD_vbs(filter_info,HFSSprojname);
        elseif strcmpi(filter_info.load_type,'Cover') % Cover Loading
            disp('  -- CLD Load Type: Cover Loading');
            cover_loading_CLD_vbs(filter_info,HFSSprojname); 
        else
            error('Could not determine the loading type used!!!')
        end
        
    case 3 % 'IDD'
        disp('WEAFIL IDD Design:');
        % Pull design specs out of WEAFIL data file
        filter_info=parseIDD(fid);
        % Find loading type and create VBScript file for HFSS
        if strcmpi(filter_info.load_type,'Lumped') % Parallel Plate Loading
            disp('  -- IDD Load Type: Lumped Loading');
            IDD_parallel_loaded_vbs(filter_info,HFSSprojname); 
        elseif strcmpi(filter_info.load_type,'Resonator') % Resonator Loading
            disp('  -- IDD Load Type: Resonator Loading');
            IDD_resonator_loaded_vbs(filter_info,HFSSprojname);
        elseif strcmpi(filter_info.load_type,'Cover') % Cover Loading
            disp('  -- IDD Load Type: Cover Loading');
            IDD_cover_loaded_vbs(filter_info,HFSSprojname); 
        else
            error('Could not determine the loading type used!!!')
        end
        
%     case 4 % 'CCD'
%         disp('WEAFIL CCD Design:');
%         % Pull design specs out of WEAFIL data file
%         filter_info=parseCCD(fid);
%         % Find loading type and create VBScript file for HFSS
%         if
%         else
%             error('Could not determine the loading type used!!!')
%         end
        
    otherwise
        error('Filter type could not be determined!!!')
end
