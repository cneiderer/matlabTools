function [time_valid, state_out, covMat_out] = pulse_pair_init(det, radar, constants)
%
% [time_valid, state_out, covMat_out] = ...
%      PulsePair_Init(time, state, PRI, t_rdc, variances, radar, constants)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      This function initializes a track, according to the THAAD MAP SRS
%      Document No. MIS-PRF-52121, using pulse pairs.  Thus there must be
%      two detections present in order to initialize a track.
%
%   Input:
%        time       --  a 2x1 vector of time (s)
%           time(1) is the validity time of detection from first pulse
%                   of the pulse pair
%           time(2) is the validity time of detection from second pulse
%                   of the pulse pair
%
%        state      --  A nx2 state matrix in RUV coordinates.
%                       The first three rows must be r, u, and v.
%           state(:,1) is the measured RUV state at time(1)
%           state(:,2) is the measured RUV state at time(2)
%
%        PRI        --  Pulse repetition interval (s)
%
%        t_rdc      --  A 2x1 vector of range doppler coupling times (s)
%           t_rdc(1) is the range doppler coupling time for pulse 1
%           t_rdc(2) is the range doppler coupling time for pulse 2
%
%        variances  --  A 3x2 matrix where each column represents a pulse
%                       and each row represents the variance in r, u, v for
%                       row 1, 2, and 3 respectively.
%        radar      --  Structure representing the radar and all of its
%                       associated constants
%           site
%              fs
%              d_RRC_RFC
%        constants  --  Structure of system constants.  Required fields:
%           map_saps
%              map_tp_sap_6015   --  Initial value of theta i, acceleration
%                                    term in the 10 state boosting filter
%              map_tp_sap_6016   --  Initial value of theta c, acceleration
%                                    term in the 10 state boosting filter
%              map_tp_sap_6017   --  Initial value of alpha, acceleration
%                                    term in the 10 state boosting filter
%              map_tp_sap_6018   --  Initial value of Isp, acceleration
%                                    term in the 10 state boosting filter
%              map_tp_sap_6019   --  Initial value of theta i variance, 
%                                    acceleration term in the 10 state
%                                    boosting filter
%              map_tp_sap_6020   --  Initial value of theta c variance, 
%                                    acceleration term in the 10 state
%                                    boosting filter
%              map_tp_sap_6021   --  Initial value of alpha variance, 
%                                    acceleration term in the 10 state
%                                    boosting filter
%              map_tp_sap_6022   --  Initial value of Isp variance, 
%                                    acceleration term in the 10 state
%                                    boosting filter
%              map_tp_sap_1022   --  Term used to initialize V
%              map_tp_sap_1023A  --  Term used to initialize the variance 
%                                    of the derivative of U
%              map_tp_sap_1023B  --  Term used to initialize the variance 
%                                    of the derivative of U
%              map_tp_sap_1024A  --  Term used to initialize the variance 
%                                    of the derivative of V
%              map_tp_sap_1024B  --  Term used to initialize the variance 
%                                    of the derivative of V
%
%   Output:
%        time_valid      --  The validity time for track initiation
%        state_out
%           sv_rrc  --  A 10x1 vector of the initial state in RRC
%           sv_ruv  --  A 10x1 vector of the initial state in RUV
%
%        covMat_out
%           P_rrc           --  A 10x10 matrix of the initial covariance in
%                               RRc
%           P_ruv           --  A 10x10 matrix of the initial covariance in
%                               RUV
%
%   Required Functions:
%        none
%

PRI = diff(det.time);

state_init    = zeros(10,1);

map_tp_sap_6015  = constants.map_saps.map_tp_sap_6015;
map_tp_sap_6016  = constants.map_saps.map_tp_sap_6016;
map_tp_sap_6017  = constants.map_saps.map_tp_sap_6017;
map_tp_sap_6018  = constants.map_saps.map_tp_sap_6018;
map_tp_sap_6019  = constants.map_saps.map_tp_sap_6019;
map_tp_sap_6020  = constants.map_saps.map_tp_sap_6020;
map_tp_sap_6021  = constants.map_saps.map_tp_sap_6021;
map_tp_sap_6022  = constants.map_saps.map_tp_sap_6022;
map_tp_sap_1022  = constants.map_saps.map_tp_sap_1022; %needed
map_tp_sap_1023A = constants.map_saps.map_tp_sap_1023A; 
map_tp_sap_1023B = constants.map_saps.map_tp_sap_1023B; 
map_tp_sap_1024A = constants.map_saps.map_tp_sap_1024A; 
map_tp_sap_1024B = constants.map_saps.map_tp_sap_1024B; 


init_acl      = [map_tp_sap_6015; ...
                 map_tp_sap_6016; ...
                 map_tp_sap_6017; ...
                 map_tp_sap_6018];
%

init_var_acl  = [map_tp_sap_6019; map_tp_sap_6020; map_tp_sap_6021; map_tp_sap_6022];

%The validity time for track initiation.
time_valid = sum(det.time) / 2;

%Total range-doppler coupling time between pulses of a pair.
%Used to calculate the derivative of r
total_rdcTime = det.rdc_time(2) - det.rdc_time(1);

%The state vector at track initiation in RUV.  This sums across the
%columns, rather than down the rows.  Basically, 
%r_init = (r(1) + r(2)) / 2 where r is the first column of the state
%matrix.  Similarly for u_init and v_init.
state_init = sum(det.ruv,2) / 2;

r = state_init(1);

%Calculate the derivative of r
state_init(4,1)    = ( det.ruv(1,2) - det.ruv(1,1) ) / ( PRI + total_rdcTime );
state_init(5,1)    = 0.0;
state_init(6,1)    = map_tp_sap_1022 / sqrt( r );
state_init(7:10,1) = init_acl;

%Now with the state initialized, let us initialize the variances

%Obtain the variances of r, u, and v
init_var = sum(det.ruv_var, 2) / 4;

%Obtain the variances in the derivatives of r, u, and v
init_var_rDot = ...
   ( det.ruv_var(1,1) + det.ruv_var(1,2) ) / (PRI + total_rdcTime)^2;

init_var_uDot = map_tp_sap_1023A + ( map_tp_sap_1023B / r )^2;
init_var_vDot = map_tp_sap_1024A + ( map_tp_sap_1024B / r )^2;

init_var_Dot = [init_var_rDot; init_var_uDot; init_var_vDot];

%Now the initial covariance matrix is simply a diagonal matrix, where the
%diagonal elements are equal to the initial variances calculated above.
P = diag([init_var; init_var_Dot; init_var_acl]);

%Convert from RUV to RRC
state_init_rrc         = ruv2rrc(state_init(1:6), radar.site.fs, radar.site.d_RRC_RFC);
state_init_rrc(7:10,1) = state_init(7:10);

J_RUV_RRC      = J_ruv_rrc(state_init(1:6), radar.site.fs);  %T_rrc_rfc

[nr, nc]       = size(J_RUV_RRC);
matPadSize     = 10 - nc;
J_RUV_RRC      = [J_RUV_RRC zeros(6,matPadSize);zeros(matPadSize,6) eye(matPadSize)];

R_rrc          = J_RUV_RRC * P * J_RUV_RRC';

state_out.sv_rrc = state_init_rrc;
state_out.sv_ruv = state_init;
covMat_out.P_rrc = R_rrc;
covMat_out.P_ruv = P;

return
