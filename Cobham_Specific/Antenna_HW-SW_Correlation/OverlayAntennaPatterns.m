function OverlayAntennaPatterns(array_type,freq_pt,interp_step)

%
% OverlayAntennaPatterns.m
%
% Description:
%   Gets the antenna pattern data from the specified files, then overlays
%   the patterns from each program on the same plot.
%
% Author:
%   Curtis Neiderer, 4/10/2009
%
% Notes / Changes:
%

%% Set defalt interp_step
if nargin==0
    interp_step=.001;
    array_type='';
    freq_pt='';
end    

%% Save current directory, then change to Correlation directory
original_dir=cd;
correlation_dir=...
    uigetdir('C:\Antenna_Correlation','Select correlation data directory:');
cd(correlation_dir);

%% Get Range pattern
[FileName,PathName]=uigetfile('*.txt','Select the AZ data file:');
AZ_file=fullfile(PathName,FileName);
Range_AZ_pattern=load_AZ_RangePattern(AZ_file,interp_step);

% [FileName,PathName]=uigetfile('*.txt','Select the Phi=45deg AZ data file:');
% AZ_file=fullfile(PathName,FileName);
% Range_45deg_AZ_pattern=load_45deg_AZ_RangePattern(AZ_file,interp_step);

[FileName,PathName]=uigetfile('*.txt','Select the EL data file:');
EL_file=fullfile(PathName,FileName);
Range_EL_pattern=load_EL_RangePattern(EL_file,interp_step);

% [FileName,PathName]=uigetfile('*.txt','Select the Phi=45deg EL data file:');
% EL_file=fullfile(PathName,FileName);
% Range_45deg_EL_pattern=load_45deg_EL_RangePattern(EL_file,interp_step);

%% Get HFSS pattern
[FileName,PathName]=uigetfile('*.csv','Select the HFSS file:');
HFSS_file=fullfile(PathName,FileName);
HFSS_pattern_data=load_HFSSpatterndata(interp_step,HFSS_file);

% %% Get CST pattern
% % Phi=0deg
% [FileName,PathName]=uigetfile('*.txt','Select the CST file [Phi=0deg]:');
% CST_file=fullfile(PathName,FileName);
% CST_pattern_Phi0_data=load_CSTpatterndata(CST_file,interp_step);
% % Phi=90deg
% [FileName,PathName]=uigetfile('*.txt','Select the CST file [Phi=90deg]:');
% CST_file=fullfile(PathName,FileName);
% CST_pattern_Phi90_data=load_CSTpatterndata(CST_file,interp_step);
% 
% %% Get WASP-Net pattern
% % Phi=0deg
% [FileName,PathName]=uigetfile('*.xls','Select the WASPNET file [Phi=0deg]:');
% WASPNET_file=fullfile(PathName,FileName);
% % Phi_deg=inputdlg('Enter the WASPNET file Phi angle [deg]:');
% % Phi_deg=str2double(Phi_deg{1});
% WASPNET_pattern_Phi0_data=load_WASPNETpatterndata(WASPNET_file,0,interp_step);
% % Phi=90deg
% [FileName,PathName]=uigetfile('*.xls','Select the WASPNET file [Phi=90deg]:');
% WASPNET_file=fullfile(PathName,FileName);
% WASPNET_pattern_Phi90_data=load_WASPNETpatterndata(WASPNET_file,90,interp_step);

%% Change back to original directory
cd(original_dir);

%% Overlay pattern data from each program onto same plot
% H-Plane (Phi=0deg)
HPlane_fig=figure;
hold on;

plot(Range_AZ_pattern.AZ,Range_AZ_pattern.Amplitude,...
    '-k','LineWidth',2);
plot(HFSS_pattern_data.Theta,HFSS_pattern_data.Phi_45deg,...
    '-r','LineWidth',2); 
% plot(HFSS_pattern_data.Theta,HFSS_pattern_data.Phi_0deg,...
%     '-r','LineWidth',2); 
% plot(CST_pattern_Phi0_data.Theta,CST_pattern_Phi0_data.Phi_0deg,...
%     '-b','LineWidth',2); 
% plot(WASPNET_pattern_Phi0_data.Theta,WASPNET_pattern_Phi0_data.Phi_0deg,...
%     '-g','LineWidth',2);

title([array_type,' Array ',freq_pt,': H-Plane Pattern (Phi=0deg)']);
xlabel('Theta [deg]');
set(gca,'XLim',[-90,90]);
set(gca,'XTick',-80:20:80);
ylabel('[dB]');
set(gca,'YLim',[-75,0]);
set(gca,'YTick',-75:5:0);

set(gca,'YGrid','on');
legend('Range','HFSS','CST','WASP-Net','Location','NorthEast');
% legend('WASP-Net','Location','NorthEast');

hold off;

% E-Plane (Phi=90deg)
EPlane_fig=figure;
hold on;

plot(Range_EL_pattern.EL,Range_EL_pattern.Amplitude,...
    '-k','LineWidth',2);
plot(HFSS_pattern_data.Theta,HFSS_pattern_data.Phi_45deg,...
    '-r','LineWidth',2); 
% plot(HFSS_pattern_data.Theta,HFSS_pattern_data.Phi_90deg,...
%     '-r','LineWidth',2); 
% plot(CST_pattern_Phi90_data.Theta,CST_pattern_Phi90_data.Phi_90deg,...
%     '-b','LineWidth',2); 
% plot(WASPNET_pattern_Phi90_data.Theta,WASPNET_pattern_Phi90_data.Phi_90deg,...
%     '-g','LineWidth',2);

title([array_type,' Array ',freq_pt,': E-Plane Pattern (Phi=90deg)']);
xlabel('Theta [deg]');
set(gca,'XLim',[-90,90]);
set(gca,'XTick',-80:20:80);
ylabel('[dB]');
set(gca,'YLim',[-75,0]);
set(gca,'YTick',-75:5:0);

set(gca,'YGrid','on');
legend('Range','HFSS','CST','WASP-Net','Location','NorthEast');
% legend('WASP-Net','Location','NorthEast');

hold off;

test=1;