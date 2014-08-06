function [pattern_data]=load_HFSSpatterndata(interp_step,HFSS_file)

%
% load_HFSSpatterndata.m
%
% Description:
%   Reads CSV data from HFSS *.csv data file.
%
% Author:
%   Curtis Neiderer, 4/9/2009
%
% Notes / Changes:
%

if nargin==1
    [FileName,PathName]=uigetfile('*.txt','Select the HFSS data file:');
    HFSS_file=fullfile(PathName,FileName);
end
    
%% Read in *.csv file
raw_data=csvread(HFSS_file,1,0);

raw_Theta=raw_data(:,1);
raw_Phi_0deg=raw_data(:,2);
raw_Phi_90deg=raw_data(:,4);
raw_Phi_45deg=raw_data(:,3);

%% Interpolate data and save into struct 
pattern_data.Theta=-90:interp_step:90;
pattern_data.Phi_0deg=...
    interp1(raw_Theta,raw_Phi_0deg,pattern_data.Theta,'spline');
pattern_data.Phi_90deg=...
    interp1(raw_Theta,raw_Phi_90deg,pattern_data.Theta,'spline');
pattern_data.Phi_45deg=...
    interp1(raw_Theta,raw_Phi_45deg,pattern_data.Theta,'spline');
