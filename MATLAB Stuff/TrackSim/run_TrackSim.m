function [tracker_outputs]=run_TrackSim(data)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% ---------- UNCLASSIFIED ---------- %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% run_TrackSim.m
%
% Description:
%   Initializes the tracker, creates the truth, and simulates the trackers. 
%
% Inputs:
%   data    ->  paths to the input files
%
% Outputs:
%   tracker_outputs
%
% Author:
%   Curtis Neiderer, 09/02/2009
%
% History/Change Log:
%

% initialize the tracker
[constants,radar,truth_dontuse]=initialize_tracker(data);
% create the truth
truth=integratortest(data,650);
% simulate the trackers
[constants,radar,truthdelete,Tlower,Tupper,kf,amm,imm,detection]=...
    simulate_trackers(constants,radar,truth);

tracker_outputs.constants=constants;
tracker_outputs.radar=radar;
tracker_outputs.truthdelete=truthdelete;
tracker_outputs.Tlower=Tlower;
tracker_outputs.Tupper=Tupper;
tracker_outputs.kf=kf;
tracker_outputs.amm=amm;
tracker_outputs.imm=imm;
tracker_outputs.detection=detection;



