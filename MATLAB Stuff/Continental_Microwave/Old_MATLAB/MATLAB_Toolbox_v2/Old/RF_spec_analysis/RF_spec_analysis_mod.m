function [system_data] = RF_spec_analysis_mod

%
% RF_spec_analysis_mod.m
%
% Description:
%   This m-file is basically a wrapper script that runs around the meat of
%   Brent's RFSpecAnalysis.m script.  It ask you to choose an excel file
%   to add the data to as well as allows you to choose multiple cti files
%   for analysis at once.  Other than that it basically formats and stores 
%   the results into a struct and calls RF_spec_analysis_xls.m, which
%   writes the results into the specified excel spreadsheet.
%
% Inputs:
%   - *.cti files to be loaded  ->  select multiple files from same
%                                   directory
%   - nstep  ->  defines the number of frequency steps you wish to move the
%                window over inside the frequency band of interest.
%
% Outputs:
%   - system_data  ->  system data measurements stored in structure
%   - excel spreadsheet  ->  via RF_spec_analysis_xls.m
%
% Author:
%   Curtis Neiderer, 12/9/2008
% 
% Notes / Changes:
%   This script was written in a very quick and dirty manner.  It can be
%   greatly improved, especially when it comes to being more user-friendly,
%   which I plan to do when I have time in the future.
%

%% Select excel workbook to edit
[saveas_file,saveas_path]=uigetfile('*.xls','Select the .xls file to be amended:');
if saveas_file==0
    saveas_filepath=[];
else
    saveas_filepath=fullfile(saveas_path,saveas_file);
end

%%
yy=1;
while yy

    %% Select the system files to be loaded
    [load_filenames,load_path]=uigetfile('*.cti','Select the .cti files to be analyzed:',...
        'MultiSelect','on');

    %% Test to make sure you selected a set of files
    if ~iscell(load_filenames)
        warndlg('You did not select a set of .cti files to be analyzed, program will now terminate')
        break;
    end

    %%
    system_data=struct('filename',[],'filepath',[],'system_name',[],'results',[]);
    for zz=1:length(load_filenames)

        % Record file name & path
        system_data(zz).filename=load_filenames{zz};
        system_data(zz).filepath=load_path;

        % Find system name from filepath
        path_breaks=regexpi(load_path,'\');
        system_name=path_breaks(3)+1:path_breaks(4)-1;
        system_data(zz).system_name=load_path(system_name);

        % Is system Tx or Rx???
        if findstr(load_path,'TX')
            data_type='Tx';
        elseif findstr(load_path,'RX')
            data_type='Rx';
        end

        % Find frequency & polarization from filename
        % (NOTE: This is done in excel creation, so it is done here, though you
        % may want to move here at later time)        

    end

    %% Loop through Brent's script for each file loaded at beginning
    % Add row headers to system_measurement_data cell array
    system_measurement_data(1:13,1)={...
        'Spec Name',...
        'Max S11',...
        'Max S22',...
        'Min Gain (dB)',...
        'Max Gain (dB)',...
        'Slope (dB)',...
        'Max AmpW1 (dB),'...
        'Max AmpW2 (dB)',...
        'Ripple (db/MHz)',...
        'Edge-to-Edge (dB)',...
        'W1 Group Delay (ns)',...
        'W2 Group Delay (ns)',...
        'W3 Group Delay (ns)'...
        };

    % Initialize Waitbar
    h=waitbar(0,'Analyzing data from system .cti files, please wait ...');

    for xx=1:length(system_data)

        % Increment Waitbar
        waitbar(xx/length(system_data),h,['Analyzing "',system_data(xx).system_name,...
            '" measurement data, ',num2str(round((xx/length(system_data))*100)),'% complete']);

        try
            
            % Form filename
            input_file=fullfile(system_data(xx).filepath,system_data(xx).filename);

            %% function RFSpecAnalysis(file,nstep)
            % This file reads in data from a text file, specified below, that contains
            % frequency in GHz and group delay in seconds and applies the Fixed STE
            % Group Delay Specs, chosen with the flags
            % clear all;
            % spec_alpha=0.5;
            % INTELSATRx    = 1; %toggles Rx option for intelsat
            % INTELSATTx    = 0; %toggles Tx option for Intelsat
            % Ku_CDL_FL     = 0; %toggles Ku FL CDL spec
            % Ku_CDL_RL     = 0; %toggles Ku RL CDL spec
            % Ku_NCDL_Rx_OL = 0; %toggles Ku NCDL OL spec (15.04-15.34)
            % Ku_NCDL_Tx_IL = 0; %toggles Ku NCDL IL spec (14.54-14.79)
            % X_Rx_CDL_RL   = 0; %toggles X-Band CDL RL Spec
            % X_Tx_CDL_FL   = 0; %Toggles X-Band CDL FL Spec
            nstep         = 50; %defines the number of frequency steps you wish 
            %   to move the window over inside the frequency band of interest.
            GDSmoothie    = 140; %Smoothing factor for Group Delay Information

            %file='C:\SAT 1743 Data\System\SN001\Final\14.615 RX RH.cti';

            [band, GDVW1Max, GDVW2Max, GDVW3Max, EdgeToEdge]=gd_spec_analysis(input_file, nstep, GDSmoothie);
            [MaxAmpW1, MaxAmpW2, slope, dB_MHz] = amp_spec_analysis(input_file,nstep);
            [MaxS11, FreqMaxS11, MaxS22, FreqMaxS22] = vswr_spec_analysis(input_file);
            [MinGain, FreqMinGain, MaxGain, FreqMaxGain] = gain_spec_analysis(input_file);

        catch
            
            warning(['There was an error analyzing file: ',system_data(xx).filename]);
            disp(lasterr);
            
            % Create/Amend error_log.txt
            
        end

        % Save system measurements into structure
        system_data(xx).results.S11_Max=MaxS11;
        system_data(xx).results.S22_Max=MaxS22;
        system_data(xx).results.Min_Gain=MinGain;
        system_data(xx).results.Max_Gain=MaxGain;
        system_data(xx).results.Slope=slope;
        system_data(xx).results.W1_Amp=MaxAmpW1;
        system_data(xx).results.W2_Amp=MaxAmpW2;
        system_data(xx).results.Ripple=dB_MHz;
        system_data(xx).results.Edge_to_Edge=EdgeToEdge;
        system_data(xx).results.W1_GroupDelay=GDVW1Max;
        system_data(xx).results.W2_GroupDelay=GDVW2Max;
        system_data(xx).results.W3_GroupDelay=GDVW3Max;

        % Save system measurements into cell array
        system_measurement_data(1:13,xx+1)={...
            system_data(xx).filename,...
            MaxS11,...      
            MaxS22,...      
            MinGain,...     
            MaxGain,...     
            slope,...       
            MaxAmpW1,...    
            MaxAmpW2,...    
            dB_MHz,...      
            EdgeToEdge,...  
            GDVW1Max,...    
            GDVW2Max,...       
            GDVW3Max...     
            };
        
    end

    % Close Waitbar
    close(h);
    
    %% Create/Edit Excel
    if ~isempty(saveas_filepath)
        saveas_filepath=RF_spec_analysis_xls(system_data,data_type,saveas_filepath);    
    else
        saveas_filepath=RF_spec_analysis_xls(system_data,data_type); 
    end
    
    % Would you like to load more files???
%     load_another_fileset=inputdlg('Would you like to select another set of files to load (Y/N)?');
    load_another_fileset=input('Would you like to select another set of files to load (Y/N)?');
    kk=1;
    while kk
        if strcmpi(load_another_fileset,'Y') || strcmpi(load_another_fileset,'Yes')
            kk=0;
            yy=1;
        elseif strcmpi(load_another_fileset,'N') || strcmpi(load_another_fileset,'No')
            kk=0;
            yy=0;
        elseif load_another_fileset==0
            kk=0;
            yy=0;
        else
            warndlg('You entered an invalid answer, please try again.')
            kk=1;
        end
    end
    
end