function [state_group, radar] = track_initialization(detection, constants, radar)
%     [state_group, radar] = TrackInit(loaded, radar, constants)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      This function controls which method is used to initialize a track.
%      source controls which method is to be used, such as pulse-pair
%      or simply using truth.
%
%   Input:
%      loaded  -- if used to initialize the state using pre-existing
%                      data, from an LRID for example, then it must have
%                      the following fields
%
%   Output:
%      state_group -- initialized structre that represents the state group.
%                     Has the following fields:
%         time
%         track_type
%         init_time
%         pos_rrc
%         vel_rrc
%         pos_ruv
%         vel_ruv
%         drag
%         cov_rrc
%         cov_ruv
%         object_kind
%         object_category
%         search_source
%         n_up
%         acceleration
%         staging_struct -- structure with the following fields:
%            update_times     --  Vecotr of update times that correspond to
%                                 the thrust acceleration magnitudes (Nx1)
%            acc_thrust_mags  --  vector of thrust acceleration magnitudes
%                                 (Nx1)
%            thrust_cntr      --  Integer that represents the number of
%                                 elements in the vectors of update times
%                                 and thrust acceleration magnitudes
%            staging_time_vec --  Vector of times at which staging was
%                                 declared (stage_count x 1)
%            stage_count      --  The number of times staging was declared
%            staging_flag_vec --  Vector of flags that indicate that staging
%                                 was declared (stage_count x 1)
%            stage_altitude   --  Vector of altitudes at which staging was
%                                 declared (stage_count x 1)
%            interstage_flag  --  A flag to indicate if we are in an
%                                 interstage condition.  DELETE THIS???
%            burn_out_flag    --  A flag to indicate if burn-out occurred
%            t_burn_out       --  The time at which burn-out was declared
%            alpha_vars       --  vector of variances of the thrust
%                                 acceleration magnitudes (Nx1)
%
%      truth_indx  --  Counter for truth, time index used to generate
%                      detections
%
%   Required Functions:
%        TrackInit_Data
%        AssignObjectId
%        Init_Staging_Struct


det.time(1) = detection.time(1);
det.rdc_time(1) = detection.rdc_time(1);
det.ruv(:,1) = detection.ruv(:,1);
det.ruv_var(:,1) = detection.ruv_var(:,1);
det.pw(1) = detection.pw(1);
det.SNR(1) = detection.SNR(1);

det.time(2) = detection.time(2);
det.rdc_time(2) = detection.rdc_time(2);
det.ruv(:,2) = detection.ruv(:,2);
det.ruv_var(:,2) = detection.ruv_var(:,2);
det.pw(2) = detection.pw(2);
det.SNR(2) = detection.SNR(2);


[state_time_init, state_vector_init, cov_matrix_init] = pulse_pair_init(det, radar, constants);

%Initialize the track group
state_group.time            = state_time_init;

state_group.init_time       = state_time_init;
state_group.track_type      = 3;  %'BOOSTER'
state_group.search_source   = 23;
state_group.pos_rrc         = state_vector_init.sv_rrc(1:3, 1);
state_group.vel_rrc         = state_vector_init.sv_rrc(4:6, 1);
state_group.acceleration    = state_vector_init.sv_rrc(7:end,1);
state_group.cov_rrc         = cov_matrix_init.P_rrc;

state_group.pos_ruv         = state_vector_init.sv_ruv(1:3, 1);
state_group.vel_ruv         = state_vector_init.sv_ruv(4:6, 1);
state_group.cov_ruv         = cov_matrix_init.P_ruv;

state_group.drag            = 0;
state_group.det_cntr        = 1;
state_group.n_up            = 1;

state_group.prob_assoc      = 1;
state_group.sim_id          = 2001;
state_group.object_id       = 10001;
