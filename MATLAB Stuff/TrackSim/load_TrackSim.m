function [data]=load_TrackSim(varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% ---------- UNCLASSIFIED ---------- %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% load_TrackSim
%
% Description:
%   Loads the TrackSim tool directories and 'data.mat', corrects the 
%   paths within 'data.mat'
%
% Inputs:
%   TrackSim_dir    ->  path to TrackSim directory either passed in
%                       directly or selected through input dialog box
%
% Outputs:
%   data            ->  array containing the paths to the input files
%
% Author:
%   Curtis Neiderer, 09/02/2009
%
% History/Change Log:
%

%% load TrackSim directories
if nargin==1
    TrackSim_dir=varargin{1};
else
    TrackSim_dir=uigetdir(cd,'Select the TrackSim directory:');
end
addpath(genpath(TrackSim_dir));

%% load data file
load data

%% correct paths to input files in data
data.map_saps_loc=fullfile(TrackSim_dir,'Input_Files\Map_Saps.txt');
data.sys_saps_loc=fullfile(TrackSim_dir,'Input_Files\Sys_Saps.txt');
data.radar_setup_loc=fullfile(TrackSim_dir,'Input_Files\Radar_Setup.txt');
data.radar_defaults_loc=fullfile(TrackSim_dir,'Input_Files\Radar_Defaults.txt');
data.mission_profile_loc=fullfile(TrackSim_dir,'Input_Files\Mission_Profile.txt');

%% select traj file for input in data
current_dir=cd;
cd('Trajectory_Data');
[Traj_filename,Traj_filepath]=uigetfile('*.mat','Select trajectory file:');
data.traj_loc=fullfile(Traj_filepath,Traj_filename);
cd(current_dir);
% data.traj_loc=fullfile(TrackSim_dir,'Trajectory_Data\traj_1.mat');

% re-save data
save(fullfile(TrackSim_dir,'data.mat'),'data');



