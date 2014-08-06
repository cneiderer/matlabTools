function [raw_pattern]=generic_load_RangeData %(range_file,interp_step)

%% Get Range pattern
[FileName,PathName]=uigetfile('*.txt','Select the data file:');
range_file=fullfile(PathName,FileName);


%% Read in *.txt file
raw_data=load(range_file);

raw_pattern.raw_AZ=raw_data(:,1); 
raw_pattern.raw_EL=raw_data(:,2);
raw_pattern.raw_Amp=raw_data(:,3);
raw_pattern.raw_Phase=raw_data(:,4);

% %% Interpolate data and save into struct 
% pattern_data.EL=-90:interp_step:90;
% pattern_data.Amplitude=interp1(raw_EL,raw_Amp,pattern_data.EL,'spline');
% pattern_data.Phase=interp1(raw_EL,raw_Phase,pattern_data.EL,'spline');
