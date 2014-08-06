function [S_data]=load_CST_SParameters(CST_file,interp_step)

%
% load_CST_SParameters.m
%
% Description:
%   Reads DLM data from CST *.txt data file.
%
% Author:
%   Curtis Neiderer, 4/9/2009
%
% Notes / Changes:
%

%% Read in *.txt file starting at row 3, col 1
raw_data=dlmread(CST_file,'',2,0);

raw_freq=raw_data(:,1);
raw_S11=raw_data(:,2);

%% Interpolate data and save into struct 
S_data.freq=8.75:interp_step:10.25;
S_data.S11=interp1(raw_freq,raw_S11,S_data.freq,'spline');
