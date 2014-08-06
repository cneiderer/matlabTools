function [pattern_data]=load_CSTpatterndata(CST_file,interp_step)

%
% load_CSTpatterndata.m
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

raw_Theta=raw_data(:,1);
eval(['raw_Phi_',num2str(raw_data(1,2)),'deg=raw_data(:,3);']);

%% Interpolate data and save into struct 
pattern_data.Theta=-90:interp_step:90;
eval(['pattern_data.Phi_',num2str(raw_data(1,2)),...
    'deg=interp1(raw_Theta,raw_Phi_',num2str(raw_data(1,2)),...
    'deg,pattern_data.Theta,''spline'');']);
