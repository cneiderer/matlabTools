function [] = spec_analysis_calc(varargin)

%
% spec_analysis_calc.m
%
% Description:
%   Analyzes RFE data for spec analysis data from each *.cti file and
%   stores all the results into *.mat
%
% Inputs:
%   cti_file_list   ->  passed in as path to cti_file_list.mat or prompted
%                       within the program to select your cti files of 
%                       interest
%
% Outputs:
%   system_data     ->  saved into system_data_*.mat to be used by
%                       system_analysis_xls.m
%
% Author:
%   Curtis Neiderer, 1/7/2009
%
% Notes/Change Log:
%


%% Get *.cti files for analysis
if nargin==1
    load(varargin{1})
else
    selected_file_list=get_cti_files;
end

test=1;

%%
if isempty(selected_file_list)
    
    error('No files were selected for analysis')
    
else
   
    %% Begin forming system_data structure
    system_data=struct('fullfile',[],'filepath',[],'filename',[],'system_name',[],...
        'data_type',[],'band_name',[],'center_freq',[],'polarization',[],'results',[]);
    for zz=1:size(selected_file_list)

        % Record file name & path
        system_data(zz).fullfile=selected_file_list{zz,1};
        system_data(zz).filepath=selected_file_list{zz,2};
        system_data(zz).filename=selected_file_list{zz,3};
        system_data(zz).system_name=selected_file_list{zz,4};
        system_data(zz).data_type=selected_file_list{zz,5};
        system_data(zz).band_name=selected_file_list{zz,6};
        system_data(zz).center_freq=selected_file_list{zz,7};
        system_data(zz).polarization=selected_file_list{zz,8};
        
    end
    
    test=2;
    
    %% Get measurements
    % Initialize Waitbar
    h=waitbar(0,'Analyzing data from selected files, please wait ...');

    for xx=1:length(system_data)

        % Increment Waitbar
        waitbar(xx/length(system_data),h,['Analyzing data from selected files ... ',...
            num2str(round((xx/length(system_data))*100)),'% complete']);

%         waitbar(xx/length(system_data),h,'Analyzing data from system *.cti files, please wait ...');

        try
            
            % Form filename
            input_file=system_data(xx).fullfile;

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
            
            continue;
            
        end

        test=3;
        
        %% Save system measurements into structure
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
        
        test=4;
        
    end
    
    % Close Waitbar
    close(h);
    
    test=5;
    
    %% Save system_data into a *.mat file
    % Choose name and location to save *.mat file
    [data_filename,data_filepath]=uiputfile('*.mat','Save compiled system data as *.mat file',...
        ['compiled_system_data_',datestr(now,1),'.mat']);
    save(fullfile(data_filepath,data_filename),'system_data');
    
%     save(fullfile('S:\Curtis_Neiderer\MATLAB_Toolbox',['compiled_system_data_',datestr(now,1),'.mat']),'system_data');
    
end