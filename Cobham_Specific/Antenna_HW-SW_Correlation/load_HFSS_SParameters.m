function [S_data]=load_HFSS_SParameters(HFSS_file,interp_step)

%
% load_HFSS_SParameters.m
%
% Description:
%   Reads CSV data from HFSS *.csv data file.
%
% Author:
%   Curtis Neiderer, 4/9/2009
%
% Notes / Changes:
%

%% Read in *.csv file
raw_data=csvread(HFSS_file,1,0);

raw_freq=raw_data(:,1);
raw_S11=raw_data(:,2);

%% Interpolate data and save into struct 
S_data.freq=9.3:interp_step:9.45;
S_data.S11=interp1(raw_freq,raw_S11,S_data.freq,'spline');
