function [pattern_data]=load_45deg_AZ_RangePattern(range_file,interp_step)

%
% load_AZ_RangePattern.m
%
% Description:
%   Loads the measurement data from the range.
%
% Inputs:
%   filename    ->  4 column text file containing the range data
%
% Outputs:
%   range_data  ->  struct containing the range data
%
% Author:
%   Curtis Neiderer, 6/5/2009
%


%% Read in *.txt file
raw_data=load(range_file);

raw_AZ=raw_data(:,2); %(:,1);
raw_Amp=raw_data(:,3);
raw_Phase=raw_data(:,4);

%% Interpolate data and save into struct 
pattern_data.AZ=-90:interp_step:90;
pattern_data.Amplitude=interp1(raw_AZ,raw_Amp,pattern_data.AZ,'spline');
pattern_data.Phase=interp1(raw_AZ,raw_Phase,pattern_data.AZ,'spline');
