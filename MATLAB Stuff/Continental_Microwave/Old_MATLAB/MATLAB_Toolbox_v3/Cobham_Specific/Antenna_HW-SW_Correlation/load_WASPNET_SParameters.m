function [S_data]=load_WASPNET_SParameters(WASPNET_file,interp_step)

%
% load_WASPNET_SParameters.m
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

raw_freq=raw_data(:,1); 
raw_S11=raw_data(:,2);

% %% Eliminates duplicate freq pt from 8x6 data
% raw_freq=[raw_freq(1:25);raw_freq(27:end)];
% raw_S11=[raw_S11(1:25);raw_S11(27:end)];

%% Interpolate data and save into struct 
S_data.freq=8.75:interp_step:10.25;
S_data.S11=interp1(raw_freq,raw_S11,S_data.freq,'spline');
