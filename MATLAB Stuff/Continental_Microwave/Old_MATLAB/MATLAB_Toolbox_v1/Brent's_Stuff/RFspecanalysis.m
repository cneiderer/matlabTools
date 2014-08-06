function RFspecanalysis(file,nstep)
% This file reads in data from a text file, specified below, that contains
% frequency in GHz and group delay in seconds and applies the Fixed STE
% Group Delay Specs, chosen with the flags
% clear all;
%spec_alpha=0.5;
% INTELSATRx    = 1; %toggles Rx option for intelsat
% INTELSATTx    = 0; %toggles Tx option for Intelsat
% Ku_CDL_FL     = 0; %toggles Ku FL CDL spec
% Ku_CDL_RL     = 0; %toggles Ku RL CDL spec
% Ku_NCDL_Rx_OL = 0; %toggles Ku NCDL OL spec (15.04-15.34)
% Ku_NCDL_Tx_IL = 0; %toggles Ku NCDL IL spec (14.54-14.79)
% X_Rx_CDL_RL   = 0; %toggles X-Band CDL RL Spec
% X_Tx_CDL_FL   = 0; %Toggles X-Band CDL FL Spec
%nstep         = 10; %defines the number of frequency steps you wish to move the window over inside the frequency band of interest.
GDSmoothie    = 140; %Smoothing factor for Group Delay Information

%file='C:\SAT 1743 Data\System\SN001\Final\14.615 RX RH.cti';

[band, GDVW1Max, GDVW2Max, GDVW3Max, EdgeToEdge]=gd_spec_analysis(file, nstep, GDSmoothie);
[MaxAmpW1, MaxAmpW2, slope, dB_MHz] = amp_spec_analysis(file,nstep);
[MaxS11, FreqMaxS11, MaxS22, FreqMaxS22] = vswr_spec_analysis(file);
[MinGain, FreqMinGain, MaxGain, FreqMaxGain] = gain_spec_analysis(file);

disp(['Operating band: ', band])
disp(['S11 Max: ',num2str(MaxS11),'  S22 Max: ',num2str(MaxS22),...
    '  Minimum Gain: ',num2str(MinGain),'dB','  Maximum Gain: ',...
    num2str(MaxGain),'dB'])
disp(['Slope: ',num2str(slope),'dB','  W1Amp: ',num2str(MaxAmpW1),'dB ',...
    '  W2Amp: ',num2str(MaxAmpW2),'dB ','  dB/MHz Ripple ',...
    num2str(dB_MHz),'dB/MHz'])
disp(['Edge to Edge: ',num2str(EdgeToEdge),'ns',...
    '  W1GD: ',num2str(GDVW1Max),'ns','  W2GD: ',num2str(GDVW2Max),'ns'...
    '  W3GD: ',num2str(GDVW3Max),'ns'])



