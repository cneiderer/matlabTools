function [system_data] = sys_comp_chk_Batch_ver(Master_FileList)

%
% sys_comp_chk_Batch_ver.m
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
%   Date: 1/19/2009
%   Change 1.1:
%       Added specific file type list to preview in uiget file when
%       searching for *.cti files to be analyzed.
%   Date: 1/19/2009
%   Change 1.2:
%       Script now works when only one *.cti file is selected versus when
%       an entire set of files is selected.
%   Date: 4/11/2009
%   Version 2:
%       GUI version of system_compliance_check.m
%

%%
system_name=Master_FileList.system_name;
tx_files=Master_FileList.NB_TX_FileList;
rx_files=Master_FileList.NB_RX_FileList;
WB_tx_files=Master_FileList.WB_TX_FileList;
WB_rx_files=Master_FileList.WB_RX_FileList;
nstep=Master_FileList.nstep;
GDSmoothie=Master_FileList.GDSmoothie;

%% Analyze the selected data files
compliance_check_wb=waitbar(0,'Analyzing system data, please wait ...');

tt=0;
% NB "Rx" Antenna
if exist('rx_files','var') && ~isempty('rx_files')
    disp('  -- Analyzing NB "RX" files ...');
    rx_data=struct('filename',[],...
        'filepath',[],...
        'mode',[],...
        'antenna_type',[],...
        'band_name',[],...
        'center_freq',[],...
        'measurements',[]);
    for kk=1:length(rx_files)
        tt=tt+1;
        waitbar(tt/Master_FileList.num_files,compliance_check_wb,...
            ['Analyzing system data, ',...
            num2str(round((tt/Master_FileList.num_files)*100)),...
            '% complete']);
        rx_data=get_band_info(rx_data,rx_files{kk},kk);
        rx_data=analyze_compliance_data(rx_data,rx_files{kk},kk,nstep,GDSmoothie);
        rx_data(kk).mode='RX';
        rx_data(kk).antenna_type='NB';
    end
else
    rx_data=[];
end

% NB "Tx" Antenna
if exist('tx_files','var') && ~isempty('tx_files')
    disp('  -- Analyzing NB "TX" files ...');
    tx_data=struct('filename',[],...
        'filepath',[],...
        'mode',[],...
        'antenna_type',[],...
        'band_name',[],...
        'center_freq',[],...
        'measurements',[]);
    for jj=1:length(tx_files)
        tt=tt+1;
        waitbar(tt/Master_FileList.num_files,compliance_check_wb,...
            ['Analyzing system data, ',...
            num2str(round((tt/Master_FileList.num_files)*100)),...
            '% complete']);
        tx_data=get_band_info(tx_data,tx_files{jj},jj);
        tx_data=analyze_compliance_data(tx_data,tx_files{jj},jj,nstep,GDSmoothie);
        tx_data(jj).mode='TX';
        tx_data(jj).antenna_type='NB';
    end
else
    tx_data=[];
end

% WB "Rx" Antenna
if exist('WB_rx_files','var') && ~isempty('WB_rx_files')
    disp('  -- Analyzing WB "RX" files ...');
    WB_rx_data=struct('filename',[],...
        'filepath',[],...
        'mode',[],...
        'antenna_type',[],...
        'band_name',[],...
        'center_freq',[],...
        'measurements',[]);
    for nn=1:length(WB_rx_files)
        tt=tt+1;
        waitbar(tt/Master_FileList.num_files,compliance_check_wb,...
            ['Analyzing system data, ',...
            num2str(round((tt/Master_FileList.num_files)*100)),...
            '% complete']);
        WB_rx_data=get_band_info(WB_rx_data,WB_rx_files{nn},nn);
        WB_rx_data=...
            analyze_compliance_data(WB_rx_data,WB_rx_files{nn},nn,nstep,GDSmoothie);
        WB_rx_data(nn).mode='RX';
        WB_rx_data(nn).antenna_type='WB';
    end
else
    WB_rx_data=[];
end

% WB "Tx" Antenna
if exist('WB_tx_files','var') && ~isempty('WB_tx_files')
    disp('  -- Analyzing WB "TX" files ...');
    WB_tx_data=struct('filename',[],...
        'filepath',[],...
        'mode',[],...
        'antenna_type',[],...
        'band_name',[],...
        'center_freq',[],...
        'measurements',[]);
    for mm=1:length(WB_tx_files)
        tt=tt+1;
        waitbar(tt/Master_FileList.num_files,compliance_check_wb,...
            ['Analyzing system data, ',...
            num2str(round((tt/Master_FileList.num_files)*100)),...
            '% complete']);
        WB_tx_data=get_band_info(WB_tx_data,WB_tx_files{mm},mm);
        WB_tx_data=...
            analyze_compliance_data(WB_tx_data,WB_tx_files{mm},mm,nstep,GDSmoothie);
        WB_tx_data(mm).mode='TX';
        WB_tx_data(mm).antenna_type='WB';
    end
else
    WB_tx_data=[];
end
    
% Close waitbar
close(compliance_check_wb);

%% Compile data into struct
system_data.sys_name=system_name;
system_data.tx_data=tx_data;
system_data.rx_data=rx_data;
system_data.WB_tx_data=WB_tx_data;
system_data.WB_rx_data=WB_rx_data;

%% Save system_data struct as *.mat file


%% --------------- %%%%% Sub-Functions %%%%% --------------- %%

%% analyze_compliance_data.m
function compliance_data=...
    analyze_compliance_data(compliance_data,input_file,zz,nstep,GDSmoothie);

% Calculate measurments of interest
try

%%%%% ========== %%%%% Start Brent's Original Code %%%%% ========== %%%%%
    
%     %% function RFSpecAnalysis(file,nstep)
%     % This file reads in data from a text file, specified below, that contains
%     % frequency in GHz and group delay in seconds and applies the Fixed STE
%     % Group Delay Specs, chosen with the flags
%     % clear all;
%     % spec_alpha=0.5;
%     % INTELSATRx    = 1; %toggles Rx option for intelsat
%     % INTELSATTx    = 0; %toggles Tx option for Intelsat
%     % Ku_CDL_FL     = 0; %toggles Ku FL CDL spec
%     % Ku_CDL_RL     = 0; %toggles Ku RL CDL spec
%     % Ku_NCDL_Rx_OL = 0; %toggles Ku NCDL OL spec (15.04-15.34)
%     % Ku_NCDL_Tx_IL = 0; %toggles Ku NCDL IL spec (14.54-14.79)
%     % X_Rx_CDL_RL   = 0; %toggles X-Band CDL RL Spec
%     % X_Tx_CDL_FL   = 0; %Toggles X-Band CDL FL Spec
%     nstep         = 50; %defines the number of frequency steps you wish
%     %   to move the window over inside the frequency band of interest.
%     GDSmoothie    = 140; %Smoothing factor for Group Delay Information
% 
%     %file='C:\SAT 1743 Data\System\SN001\Final\14.615 RX RH.cti';

    [band, GDVW1Max, GDVW2Max, GDVW3Max, EdgeToEdge]=gd_spec_analysis(input_file, nstep, GDSmoothie);
    [MaxAmpW1, MaxAmpW2, slope, dB_MHz] = amp_spec_analysis(input_file,nstep);
    [MaxS11, FreqMaxS11, MaxS22, FreqMaxS22] = vswr_spec_analysis(input_file);
    [MinGain, FreqMinGain, MaxGain, FreqMaxGain] = gain_spec_analysis(input_file);

%%%%% ========== %%%%% End Brent's Original Code %%%%% ========== %%%%%
    
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

%% get_band_info.m
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
