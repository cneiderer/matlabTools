function [] = system_compliance_check

%
% system_compliance_check.m
%
% Description:
%   This script is the first of two which work together to validate system 
%   data measurments against spec values.  You basically select the *.cti 
%   files to be analyzed, calculate the measurements, and then store the 
%   data into a structure for use by system_compliance_xls.m 
%
% Inputs:
%   - *.cti files to be loaded  ->  select multiple files from same
%                                   directory
%   - nstep  ->  defines the number of frequency steps you wish to move the
%                window over inside the frequency band of interest.
%
% Outputs:
%   - system_data   ->  system data measurements stored in structure
%                       *_measurment_data_*.xls
%
% Author:
%   Curtis Neiderer, 12/22/2008
% 
% Notes / Changes:
%


%% Enter the system name whose data you're analyzing
sys_name=input('Enter the name of the system you will be analyzing: ','s');

% Select Narrowband "TX" *.cti files and display
[tx_files,tx_path]=uigetfile('*RH.cti; *RHCP.cti','Select the NB "TX" *.cti files to be analyzed:','MultiSelect','on');

% Test to make sure you selected a set of files
if ~iscell(tx_files)
    warning('You did not select a set of NB "TX" *.cti files.')
    tx_files=[];
else
    tx_filepaths={};
	disp('NB "TX" *.cti files selected: ')
    for ii=1:length(tx_files)
        tx_filepaths{ii,1}=fullfile(tx_path,tx_files{ii});
        disp(['--',fullfile(tx_path,tx_files{ii})])
    end
end

% Select Wideband "TX" *.cti files and display
[WB_tx_files,WB_tx_path]=uigetfile('*.cti','Select the WB "TX" *.cti files to be analyzed:','MultiSelect','on');

% Test to make sure you selected a set of files
if ~iscell(WB_tx_files)
    warning('You did not select a set of WB "TX" *.cti files.')
    WB_tx_files=[];
else
    WB_tx_filepaths={};
	disp('WB "TX" *.cti files selected: ')
    for aa=1:length(WB_tx_files)
        WB_tx_filepaths{aa,1}=fullfile(WB_tx_path,WB_tx_files{aa});
        disp(['--',fullfile(WB_tx_path,WB_tx_files{aa})])
    end
end

% Select Narrowband "RX" *.cti files and display
[rx_files,rx_path]=uigetfile('*RH.cti; *RHCP.cti','Select the NB "RX" *.cti files to be analyzed:','MultiSelect','on');

% Test to make sure you selected a set of files
if ~iscell(rx_files)
    warning('You did not select a set of NB "RX" *.cti files.')
    rx_files=[];
else
    rx_filepaths={};
    disp('NB "RX" *.cti files selected: ')
    for jj=1:length(rx_files)
        rx_filepaths{jj,1}=fullfile(rx_path,rx_files{jj});
        disp(['--',fullfile(rx_path,rx_files{jj})])
    end
end

% Select Wideband "RX" *.cti files and display
[WB_rx_files,WB_rx_path]=uigetfile('*.cti','Select the WB "RX" *.cti files to be analyzed:','MultiSelect','on');

% Test to make sure you selected a set of files
if ~iscell(WB_rx_files)
    warning('You did not select a set of WB "RX" *.cti files.')
    WB_rx_files=[];
else
    WB_rx_filepaths={};
    disp('WB "RX" *.cti files selected: ')
    for bb=1:length(WB_rx_files)
        WB_rx_filepaths{bb,1}=fullfile(WB_rx_path,WB_rx_files{bb});
        disp(['--',fullfile(WB_rx_path,WB_rx_files{bb})])
    end
end

% Check if any *.cti files were selected
if (isempty(tx_files) || ~exist('tx_files','var') ) ...
        && (isempty(rx_files) || ~exist('rx_files','var')) ...
        && (isempty(WB_tx_files) || ~exist('WB_tx_files','var')) ...
        && (isempty(WB_rx_files) || ~exist('WB_tx_files','var'))
    error('You did not select any *.cti files!!!')    
end


%% Create compliance data structs
% NB "Tx"
if iscell(tx_files)
    tx_wb=waitbar(0,'Analyzing NB "TX" data, please wait ...');
    tx_data=struct('system_name',[],'filename',[],'filepath',[],'mode',[],'antenna_type',[],'band_name',[],'center_freq',[],'measurements',[]);
    for kk=1:length(tx_files)

        tx_data(kk).system_name=sys_name;
        tx_data(kk).filename=tx_files{kk};
        tx_data(kk).filepath=tx_path;
        tx_data(kk).mode='TX';
        tx_data(kk).antenna_type='NB';
        
        waitbar(kk/length(tx_files),tx_wb,['Analyzing Narrowband "TX" data, ',num2str(round((kk/length(tx_files))*100)),'% complete']);
        tx_data=get_band_info(tx_data,tx_filepaths{kk},kk);
        tx_data=analyze_compliance_data(tx_data,tx_filepaths{kk},kk);

    end
    close(tx_wb);
else
    tx_data=[];
end

% WB "Tx"
if iscell(WB_tx_files)
    WB_tx_wb=waitbar(0,'Analyzing WB "TX" data, please wait ...');
    WB_tx_data=struct('system_name',[],'filename',[],'filepath',[],'mode',[],'antenna_type',[],'band_name',[],'center_freq',[],'measurements',[]);
    for ll=1:length(WB_tx_files)

        WB_tx_data(ll).system_name=sys_name;
        WB_tx_data(ll).filename=WB_tx_files{ll};
        WB_tx_data(ll).filepath=WB_tx_path;
        WB_tx_data(ll).mode='TX';
        WB_tx_data(ll).antenna_type='WB';
        
        waitbar(ll/length(WB_tx_files),WB_tx_wb,['Analyzing Wideband "TX" data, ',num2str(round((ll/length(WB_tx_files))*100)),'% complete']);
        WB_tx_data=get_band_info(WB_tx_data,WB_tx_filepaths{ll},ll);
        WB_tx_data=analyze_compliance_data(WB_tx_data,WB_tx_filepaths{ll},ll);

    end
    close(WB_tx_wb);
else
    WB_tx_data=[];
end

% NB "Rx"
if iscell(rx_files)
    rx_wb=waitbar(0,'Analyzing NB "RX" data, please wait ...');
    rx_data=struct('system_name',[],'filename',[],'filepath',[],'mode',[],'antenna_type',[],'band_name',[],'center_freq',[],'measurements',[]);
    for mm=1:length(rx_files)

        rx_data(mm).system_name=sys_name;
        rx_data(mm).filename=rx_files{mm};
        rx_data(mm).filepath=rx_path;
        rx_data(mm).mode='RX';
        rx_data(mm).antenna_type='NB';
        
        waitbar(mm/length(rx_files),rx_wb,['Analyzing Narrowband "RX" data, ',num2str(round((mm/length(rx_files))*100)),'% complete']);
        rx_data=get_band_info(rx_data,rx_filepaths{mm},mm);
        rx_data=analyze_compliance_data(rx_data,rx_filepaths{mm},mm);

    end
    close(rx_wb);
else
    rx_data=[];
end

% WB "Rx"
if iscell(WB_rx_files)
    WB_rx_wb=waitbar(0,'Analyzing WB "RX" data, please wait ...');
    WB_rx_data=struct('system_name',[],'filename',[],'filepath',[],'mode',[],'antenna_type',[],'band_name',[],'center_freq',[],'measurements',[]);
    for nn=1:length(WB_rx_files)

        WB_rx_data(nn).system_name=sys_name;
        WB_rx_data(nn).filename=WB_rx_files{nn};
        WB_rx_data(nn).filepath=WB_rx_path;
        WB_rx_data(nn).mode='RX';
        WB_rx_data(nn).antenna_type='WB';

        waitbar(nn/length(WB_rx_files),WB_rx_wb,['Analyzing Wideband "RX" data, ',num2str(round((nn/length(WB_rx_files))*100)),'% complete']);
        WB_rx_data=get_band_info(WB_rx_data,WB_rx_filepaths{nn},nn);
        WB_rx_data=analyze_compliance_data(WB_rx_data,WB_rx_filepaths{nn},nn);

    end
    close(WB_rx_wb);
else
    WB_rx_data=[];
end


%% Save "TX" and "RX" data in *.mat file

% % Save file to name and location
% [mat_filename,mat_filepath]=uiputfile('*.mat','Save the measurement data as: ',[sys_name,'_measurement_data_',datestr(now,1),'.mat'])
% save(fullfile(mat_filepath,mat_filename)'tx_data','WB_tx_data','rx_data','WB_rx_data');

save(['S:\Curtis_Neiderer\MATLAB_Toolbox\Working\',sys_name,'_measurement_data_',datestr(now,1),'.mat'],'tx_data','WB_tx_data','rx_data','WB_rx_data');

%% --------------- %%%%% Sub-Functions %%%%% --------------- %%

function compliance_data = analyze_compliance_data(compliance_data,input_file,zz)

% Calculate measurments of interest
try

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

    % Save compliance measurements in structure
    compliance_data(zz).measurements.S11_Max=MaxS11;
    compliance_data(zz).measurements.S22_Max=MaxS22;
    compliance_data(zz).measurements.Min_Gain=MinGain;
    compliance_data(zz).measurements.Max_Gain=MaxGain;
    compliance_data(zz).measurements.Slope=slope;
    compliance_data(zz).measurements.W1_Amp=MaxAmpW1;
    compliance_data(zz).measurements.W2_Amp=MaxAmpW2;
    compliance_data(zz).measurements.Ripple=dB_MHz;
    compliance_data(zz).measurements.Edge_to_Edge=EdgeToEdge;
    compliance_data(zz).measurements.W1_GroupDelay=GDVW1Max;
    compliance_data(zz).measurements.W2_GroupDelay=GDVW2Max;
    compliance_data(zz).measurements.W3_GroupDelay=GDVW3Max;
    
catch

    warning(['There was an error analyzing file: ',compliance_data(zz).filename]);
    disp(lasterr);

    % Create/Amend error_log.txt

end


function measurement_data = get_band_info(measurement_data,current_filename,yy)

switch 1
    case ~isempty(strfind(current_filename,'14.615'))
        measurement_data(yy).center_freq=14.615;
        measurement_data(yy).band_name='Ku-CDL RL';
    case ~isempty(strfind(current_filename,'15.25'))
        measurement_data(yy).center_freq=15.25;
        measurement_data(yy).band_name='Ku-CDL FL';
    case ~isempty(strfind(current_filename,'10.3'))
        measurement_data(yy).center_freq=10.3;
        measurement_data(yy).band_name='X-CDL RL';
    case ~isempty(strfind(current_filename,'15.19'))
        measurement_data(yy).center_freq=15.19;
        measurement_data(yy).band_name='N-CDL OL';
    case ~isempty(strfind(current_filename,'14.665'))
        measurement_data(yy).center_freq=14.665;
        measurement_data(yy).band_name='N-CDL IL';
    case ~isempty(strfind(current_filename,'11.85'))
        measurement_data(yy).center_freq=11.85;
        measurement_data(yy).band_name='Intelsat DL';
    case ~isempty(strfind(current_filename,'9.85'))
        measurement_data(yy).center_freq=9.85;
        measurement_data(yy).band_name='X-CDL FL';
    case ~isempty(strfind(current_filename,'14.125'))
        measurement_data(yy).center_freq=14.125;
        measurement_data(yy).band_name='Intelsat UL';
    otherwise
        disp('center_freq and band_name could not be determined from the file name')
end
