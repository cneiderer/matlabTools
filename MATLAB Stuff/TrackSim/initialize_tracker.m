function [constants radar truth] = initialize_tracker(init_data)
%   UNCLASSIFIED
%
%   DESCRIPTION
%       The initialization routines for the simluation
%

constants = initialize_constants(init_data);

radar = initialize_radar(init_data, constants.physical_constants);

truth = load_truth_traj_file(init_data.traj_loc, radar, constants);

