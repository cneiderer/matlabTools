function [pattern_data]=load_EL_RangePattern(range_file,interp_step)

%
% load_EL_RangePattern.m
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

% raw_EL=raw_data(:,2); 
raw_EL=raw_data(:,1);
raw_Amp=raw_data(:,3);
raw_Phase=raw_data(:,4);

%% Interpolate data and save into struct 
pattern_data.EL=-90:interp_step:90;
pattern_data.Amplitude=interp1(raw_EL,raw_Amp,pattern_data.EL,'spline');
pattern_data.Phase=interp1(raw_EL,raw_Phase,pattern_data.EL,'spline');
