function [pattern_data]=load_WASPNETpatterndata(WASPNET_file,Phi_deg,interp_step)

%
% load_WASPNETpatterndata.m
%
% Description:
%   Reads XLS data from WASP-Net *.xls data file.
%
% Author:
%   Curtis Neiderer, 4/9/2009
%
% Notes / Changes:
%

%% Read in *.xls file
raw_data=xlsread(WASPNET_file);

raw_Theta=raw_data(:,1);
eval(['raw_Phi_',num2str(Phi_deg),'deg=raw_data(:,2);']);

%% Interpolate data and save into struct 
pattern_data.Theta=-90:interp_step:90;
eval(['pattern_data.Phi_',num2str(Phi_deg),...
    'deg=interp1(raw_Theta,raw_Phi_',num2str(Phi_deg),...
    'deg,pattern_data.Theta,''spline'');']);
