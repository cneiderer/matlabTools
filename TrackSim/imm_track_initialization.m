function [imm_state_group] = imm_track_initialization(truth, detection, constants, radar)




% p6_init=1/3; % Initial model probability
% p8b_init=1/3;
% p10b_init=1/3;


% alpha=1e4;
% alpha_cue=1e4;
% alpha_tropo=1.0;
% beam_test=Inf;
% beta=1.0;
% beta_cue=1.0;
% tropo_factor=0.00;
% N_s=0;
% option_init='split';  % cue, SRS, new, split
% RCS_dBsm_mean=0;
% RCS_dBsm_std=3;
% RDC_factor_MB=1e3;
% RDC_factor_WB=1e1;
% SNR_cue=20.0;
% SNR_thresh=-Inf;%9.5;
% SNR_track=20.0;

% time_0 = truth.time(1);
% time_1 = truth.time(2);

SNR_cue=20.0;

% ECI=truth.ECI(1,2:7)'; % truth
% ECR=eci2ecr(ECI,radar.aligned,truth.time(1)/3600,constants); % truth
% RRC=ecr2rrc(ECR,radar.site.T_ECR_RRC,radar.site.r0_ecr ); % truth
% RAE=rrc2rae(RRC); % truth

RRC=truth.RRC(:,1); % truth
RAE=rrc2rae(RRC(1:3)); % truth

R_measure = diag(detection.ruv_var(:,1));
RUV_measured = (detection.ruv(:,1));

P_RRC_0=zeros(6,6);
RRC_0=RRC;%interp1(time_1,RRC',time_0)'; % uses the truth!?
RAE_0=rrc2rae(RRC_0);
T_RRC_RFC = get_T_rrc_rfc(radar.site.clock, radar.site.az, radar.site.el);% get_T_RRC_RFC_GBRP(0,RAE_0(2,:),RAE_0(3,:));
RUV_0=rrc2ruv(RRC_0, radar.site.fs, radar.site.d_RRC_RFC);
RUV_tropo_error= radar.params.tropo_factor*get_RUV_tropo_error(RUV_0,radar);
[SNR_dB_out,tau_round,i_tau,L_scan,L_atmos,L_dispersion]=...
    compute_SNR_v(RRC_0,10^(0.1*radar.params.RCS_dBsm_mean),'MB',100,radar,constants);
i_pulse=i_tau;
% R_measure=get_variances2(SNR_dB_out,RUV_0,RUV_0,constants.sys_saps.SYS0000(17),...
%     (pi/180)*[RAE_0([2 3 5 6])' 0 0],constants,radar);
J_RUV_RRC=J_ruv_rrc(RUV_0, radar.site.T_RRC_RFC);
P_RUV_0=diag([0.5*diag(R_measure)' ...
    (2*R_measure(1,1)/(2*radar.params.pulse(min(size(radar.params.pulse,1),i_pulse+1),1)*radar.params.RDC_factor_MB)) ...
    (constants.map_saps.TP1023A+(constants.map_saps.TP1023B/RUV_0(1))^2) ...
    (constants.map_saps.TP1024A+(constants.map_saps.TP1024B/RUV_0(1))^2)]);
P_RRC_0=J_RUV_RRC(1:6,1:6)*P_RUV_0*J_RUV_RRC(1:6,1:6)';

%%%
P_RRC_cue=P_RRC_0(1:6,1:6);
u_v=RRC_0(4:6)/norm(RRC_0(4:6));
% if ~(strcmp(option_init,'split'));
% P_cue=radar.params.alpha_cue*(radar.params.beta_cue*[eye(3)-u_v*u_v']+(1-radar.params.beta_cue)*u_v*u_v');
% P_RRC_cue=P_RRC_cue+[zeros(3,6);zeros(3,3) P_cue];
% end;
[V_cue,D_cue]=eig(P_RRC_cue);
RRC_cue_error=V_cue*(sqrt(diag(D_cue)).*randn(6,1));
RRC_cue=RRC_0+RRC_cue_error;
RAE_cue=rrc2rae(RRC_cue);
T_RRC_RFC=radar.site.T_RRC_RFC;
RRC_true=RRC_0;
RUV_true=[rrc2ruv(RRC_true(1:6,:), radar.site.fs, radar.site.d_RRC_RFC)];
RAE_est=rrc2rae(RRC_cue);
RUV_cue=rrc2ruv(RRC_cue, radar.site.fs, radar.site.d_RRC_RFC);
%RCS_dBsm=normrnd(RCS_dBsm_mean,RCS_dBsm_std);
RCS_dBsm=radar.params.RCS_dBsm_mean + radar.params.RCS_dBsm_std*randn;                                   % RJF
RCS=10^(0.1*(RCS_dBsm));
[SNR_dB_out,tau_round,i_tau] = compute_SNR_v(RRC_true(1:6,:),RCS,'MB',SNR_cue,radar,constants);
% R_measure=get_variances2(10.^(0.1*SNR_dB_out),RUV_true,RUV_cue,...
%     constants.sys_saps.SYS0000(fix(rand(1,1)*31+1)),(pi/180)*[RAE_0([2 3 5 6]);0;0],constants,radar);
del_RUV=radar.params.tropo_factor*get_RUV_tropo_error(RUV_cue,radar);
RUV_tropo_error=(1-radar.params.alpha_tropo)*RUV_tropo_error+radar.params.alpha_tropo*del_RUV;
% RUV_measured=RUV_true(1:3)+diag([1;1*ones(2,1)]).*sqrt(R_measure)*randn(size(RUV_true(1:3)))...
%     +RUV_tropo_error+[RUV_true(4)*radar.params.pulse(i_tau,1)*radar.params.RDC_factor_MB;0;0];
RUV_est=[RUV_measured;RUV_cue(4:6)];
%RUV_est(1)=RUV_est(1)-RUV_cue(4)*radar.params.pulse(i_tau,1)*radar.params.RDC_factor_MB;
RUV_est(1)=RUV_est(1)-RUV_cue(4)*detection.rdc_time(1);

time_true=truth.time(1);
time_update=truth.time(1);
index_update6=0;
index_update8b=0;
index_update10b=0;
RRC_est6_init=[ruv2rrc(RUV_est,radar.site.fs, radar.site.d_RRC_RFC)];
RRC_est8b_init=[RRC_est6_init;radar.params.alpha_init;radar.params.beta_init];
RRC_est10b_init=[RRC_est6_init;radar.params.thetai_init;radar.params.thetac_init;radar.params.alpha_init;radar.params.beta_init];

% 6 state filter initialization
% state:
RRC_est6=RRC_est6_init;
% covariance:
%initialize_covariance; 
P_RRC=P_RRC_cue;
alpha=0;
beta=0;
P_RRC6=P_RRC;

% 8 state filter initialization
% state:
RRC_est8b=RRC_est8b_init;
% covariance:
P_RRC8b=P_RRC;
P_RRC8b(7:8,1:6)=zeros(2,6);
P_RRC8b(1:6,7:8)=zeros(6,2);
P_RRC8b(7:8,7:8)=diag([radar.params.alpha_P0 radar.params.beta_P0]);

% 10 state filter initialization
% state
RRC_est10b=RRC_est10b_init;
% covariance
P_RRC10b=P_RRC;
P_RRC10b(7:10,1:6)=zeros(4,6);
P_RRC10b(1:6,7:10)=zeros(6,4);
augQ=[radar.params.thetai_P0 radar.params.thetac_P0 radar.params.alpha_P0 radar.params.beta_P0];
P_RRC10b(7:10,7:10)=diag(augQ);

imm_state_group.RRC_est6 = RRC_est6;
imm_state_group.P_RRC = P_RRC;
imm_state_group.alpha = 0;
imm_state_group.beta = 0;
imm_state_group.P_RRC6 = P_RRC6;

imm_state_group.RRC_est8b = RRC_est8b;
imm_state_group.P_RRC8b = P_RRC8b;

imm_state_group.RRC_est10b = RRC_est10b;
imm_state_group.P_RRC10b = P_RRC10b;

imm_state_group.state_time = time_update;

imm_state_group.index_update6 = 1;
imm_state_group.index_update8b = 1;
imm_state_group.index_update10b = 1;

imm_state_group.i_tau = i_tau;
imm_state_group.SNR_dB_out = SNR_dB_out;

imm_state_group.IMM_RRC_state = RRC_est6;
imm_state_group.IMM_RRC_cov = P_RRC6;

% measurement matrices (H): see line ~390         ###### RJF ###################

% IMM filter initialization
% p6=p6_init;
% p8b=p8b_init;
% p10b=p10b_init;
