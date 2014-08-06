function [updated_group, DZ, K] = update_imm_group(propagated_group, detection, constants, radar)

% % %
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%%%%%%%%%%                   GroundSensors;
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %RCS_dBsm=normrnd(RCS_dBsm_mean,RCS_dBsm_std);
% % % RCS_dBsm=radar.params.RCS_dBsm_mean + radar.params.RCS_dBsm_std*randn;                        % #### RJF ####
% % % RCS=10^(0.1*(RCS_dBsm));
% % % % [SNR_dB_out,tau_round,i_tau] = compute_SNR_v(RRC_true,RCS,'MB',SNR_track);
% % % signal=20*log10(norm([sqrt(10^(0.1*propagated_group.SNR_dB_out)) 0]+randn(1,2)));
% % % freq_select=constants.sys_saps.SYS0000(fix(rand(1,1)*31+1));
% % % R_measure_true=get_variances2(10.^(0.1*propagated_group.SNR_dB_out),RUV_true,RUV_predIMM,...
% % %     freq_select,deg_to_rad*[RAE_predIMM([2 3 5 6]);0;0]); % controls the error
% % % R_measure=get_variances2(10.^(0.1*SNR_dB_out),RUV_true,RUV_predIMM,...
% % %     freq_select,deg_to_rad*[RAE_predIMM([2 3 5 6]);0;0*RAE_predIMM(2)]); % goes to KF
% % %
% % % del_RUV=tropo_factor*get_RUV_tropo_error(RUV_predIMM); % tropo_factor = 0 for now
% % % RUV_tropo_error=(1-alpha_tropo)*RUV_tropo_error+alpha_tropo*del_RUV; % alpha_tropo = 1 for now
% % % RUV_no_RDC=RUV_true(1:3)+sqrt(diag(R_measure_true)).*randn(size(RUV_true(1:3))); % noise added here
% % % RUV_measured=RUV_no_RDC+RUV_tropo_error+[RUV_true(4)*pulse(i_tau,1)*RDC_factor_MB;0;0];


time_update=detection.time;

Prob = 1.0;

IMM_pred6 = propagated_group.RRC_est6;
RUV_pred6 = propagated_group.RUV_pred6;
P_RUV_pred6 = propagated_group.P_RUV_pred6;
P_decoupled6 = propagated_group.P_RUV_pred6;

IMM_pred8 = propagated_group.RRC_est8b;
RRC_pred8b = propagated_group.RRC_est8b;
RUV_pred8b = propagated_group.RUV_pred8b;
P_RUV_pred8b = propagated_group.P_RUV_pred8b;
P_decoupled8b = propagated_group.P_RUV_pred8b;

IMM_pred10 = propagated_group.RRC_est10b;
RRC_pred10b = propagated_group.RRC_est10b;
RUV_pred10b = propagated_group.RUV_pred10b;
P_RUV_pred10b = propagated_group.P_RUV_pred10b;
P_decoupled10b = propagated_group.P_RUV_pred10b;

H6 = propagated_group.H6;
RUV_measured = detection.ruv;
R_measure=diag(detection.ruv_var);
max_vel_mag = radar.params.max_vel_mag;

IMM_pred6(4:6)=IMM_pred6(4:6)*min([norm(IMM_pred6(4:6)),radar.params.max_vel_mag])/norm(IMM_pred6(4:6));

residual6_IMM=RUV_measured-H6*rrc2ruv(IMM_pred6, radar.site.fs, radar.site.d_RRC_RFC);
chi_square6_IMM=residual6_IMM(1)^2/R_measure(1,1)+residual6_IMM(2)^2/R_measure(2,2)+...
    residual6_IMM(3)^2/R_measure(3,3);

residual6=RUV_measured-H6*RUV_pred6;
S6=H6*P_RUV_pred6*H6'+R_measure;
chi_square6=residual6'*inv(S6)*residual6;

K6=Prob*P_decoupled6*H6'*inv(Prob*(H6*P_decoupled6*H6'+R_measure)+...
    (1-Prob)*residual6*residual6');
P_RUV_upd6=Prob*(eye(6)-K6*H6)*P_RUV_pred6*(eye(6)-K6*H6)'+...
    (1-Prob)*P_RUV_pred6+K6*(Prob*R_measure+(1-Prob)*residual6*residual6')*K6';
J_RUV_RRC6=J_ruv_rrc(RUV_pred6, radar.site.T_RRC_RFC);
P_RRC6=J_RUV_RRC6*P_RUV_upd6*J_RUV_RRC6';
RUV_est6=RUV_pred6+K6*residual6;
RRC_est6=ruv2rrc(RUV_est6(1:6), radar.site.fs, radar.site.d_RRC_RFC);
% index_update6=index_update6+1;
% update6='   update';

f8b_y7_max = radar.params.f8b_y7_max;
f8b_y8_min = radar.params.f8b_y8_min;
f8b_y8_max = radar.params.f8b_y8_min;
H8b = propagated_group.H8b;

IMM_pred8(4:6)=IMM_pred8(4:6)*min([norm(IMM_pred8(4:6)),max_vel_mag])/norm(IMM_pred8(4:6));
IMM_pred8(7)=min([max([IMM_pred8(7) 0]) f8b_y7_max]);
IMM_pred8(8)=min([max([IMM_pred8(8) f8b_y8_min]) f8b_y8_max]);

residual8_IMM=RUV_measured-H8b*[rrc2ruv(IMM_pred8(1:6),radar.site.fs, radar.site.d_RRC_RFC);0;0];
chi_square8b_IMM=residual8_IMM(1)^2/R_measure(1,1)+residual8_IMM(2)^2/R_measure(2,2)+...
    residual8_IMM(3)^2/R_measure(3,3);

residual8b=RUV_measured-H8b*[RUV_pred8b;RRC_pred8b(7:8)];
S8b=H8b*P_RUV_pred8b*H8b'+R_measure;
chi_square8b=residual8b'*inv(S8b)*residual8b;


K8b=Prob*P_decoupled8b*H8b'*inv(Prob*(H8b*P_decoupled8b*H8b'+R_measure)+...
    (1-Prob)*residual8b*residual8b');
P_RUV_upd8b=Prob*(eye(8)-K8b*H8b)*P_RUV_pred8b*(eye(8)-K8b*H8b)'+...
    (1-Prob)*P_RUV_pred8b+K8b*(Prob*R_measure+(1-Prob)*residual8b*residual8b')*K8b';
J_RUV_RRC8b=J_ruv_rrc(RUV_pred8b, radar.site.T_RRC_RFC);
J_RUV_RRC8b=[J_RUV_RRC8b zeros(6,2);
    zeros(2,6) eye(2)];
P_RRC8b=J_RUV_RRC8b*P_RUV_upd8b*J_RUV_RRC8b';
RUV_est8b=[RUV_pred8b;RRC_pred8b(7:8)]+K8b*residual8b;
RRC_est8b=[ruv2rrc(RUV_est8b(1:6),radar.site.fs, radar.site.d_RRC_RFC);RUV_est8b(7:8)];

f10b_y9_max = radar.params.f10b_y9_max;
f10b_y10_min = radar.params.f10b_y10_min;
f10b_y10_max = radar.params.f10b_y10_max;
H10b = propagated_group.H10b;

IMM_pred10(4:6)=IMM_pred10(4:6)*min([norm(IMM_pred10(4:6)),max_vel_mag])/norm(IMM_pred10(4:6));
IMM_pred10(9)=min([max([IMM_pred10(9) 0]) f10b_y9_max]);
IMM_pred10(10)=min([max([IMM_pred10(10) f10b_y10_min]) f10b_y10_max]);

residual10_IMM=RUV_measured-H10b*[rrc2ruv(IMM_pred10(1:6),radar.site.fs, radar.site.d_RRC_RFC);0;0;0;0];
chi_square10b_IMM=residual10_IMM(1)^2/R_measure(1,1)+residual10_IMM(2)^2/R_measure(2,2)+...
    residual10_IMM(3)^2/R_measure(3,3);

residual10b=RUV_measured-H10b*[RUV_pred10b;RRC_pred10b(7:10)];
S10b=H10b*P_RUV_pred10b*H10b'+R_measure;
chi_square10b=residual10b'*inv(S10b)*residual10b;

K10b=Prob*P_decoupled10b*H10b'*inv(Prob*(H10b*P_decoupled10b*H10b'+R_measure)+...
    (1-Prob)*residual10b*residual10b');
P_RUV_upd10b=Prob*(eye(10)-K10b*H10b)*P_RUV_pred10b*(eye(10)-K10b*H10b)'+...
    (1-Prob)*P_RUV_pred10b+K10b*(Prob*R_measure+(1-Prob)*residual10b*residual10b')*K10b';
J_RUV_RRC10b=J_ruv_rrc(RUV_pred10b, radar.site.T_RRC_RFC);
J_RUV_RRC10b=[J_RUV_RRC10b zeros(6,4);
    zeros(4,6) eye(4)];
P_RRC10b=J_RUV_RRC10b*P_RUV_upd10b*J_RUV_RRC10b';
RUV_est10b=[RUV_pred10b;RRC_pred10b(7:10)]+K10b*residual10b;
RRC_est10b=[ruv2rrc(RUV_est10b(1:6),radar.site.fs, radar.site.d_RRC_RFC);RUV_est10b(7:10)];

index_RRC = propagated_group.index_update6;
if propagated_group.index_update6==1
    propagated_group.chi_filtered6(propagated_group.index_update6)=chi_square6_IMM;
    propagated_group.chi_filtered8b(propagated_group.index_update6)=chi_square8b_IMM;
    propagated_group.chi_filtered10b(propagated_group.index_update6)=chi_square10b_IMM;
else
    %     IMM_N=min(propagated_group.n_up,IMM_N_SAP);
    IMM_N=min(propagated_group.index_update6,10);
    propagated_group.chi_filtered6(index_RRC)=((IMM_N-1)/IMM_N)*propagated_group.chi_filtered6(index_RRC-1)+...
        (1/IMM_N)*chi_square6_IMM;
    propagated_group.chi_filtered8b(index_RRC)=((IMM_N-1)/IMM_N)*propagated_group.chi_filtered8b(index_RRC-1)+...
        (1/IMM_N)*chi_square8b_IMM;
    propagated_group.chi_filtered10b(index_RRC)=((IMM_N-1)/IMM_N)*propagated_group.chi_filtered10b(index_RRC-1)+...
        (1/IMM_N)*chi_square10b_IMM;
end

p6_init = radar.params.p6;
p8b_init = radar.params.p8b;
p10b_init = radar.params.p10b;

% COMPUTE MODEL PROBABILITIES (FED:95:11 ASDE MEMO) % Use exp(-chi_sq) instead, 3/6/03
p6_unnormalized=p6_init/(1+propagated_group.chi_filtered6(index_RRC)+propagated_group.chi_filtered6(index_RRC)^2/2);
p8b_unnormalized=p8b_init/(1+propagated_group.chi_filtered8b(index_RRC)+propagated_group.chi_filtered8b(index_RRC)^2/2);
p10b_unnormalized=p10b_init/(1+propagated_group.chi_filtered10b(index_RRC)+propagated_group.chi_filtered10b(index_RRC)^2/2);

tempsum=sum(p6_unnormalized+p8b_unnormalized+p10b_unnormalized);
p6=p6_unnormalized/tempsum;
p8b=p8b_unnormalized/tempsum;
p10b=p10b_unnormalized/tempsum;

% UPDATE IMM FILTER (FED:95:11 ASDE MEMO)
%                         # (RJF) uses weighted avge (not true IMM) (RJF) ############
IMM_RRC_state=p6*RRC_est6+p8b*RRC_est8b(1:6)+p10b*RRC_est10b(1:6);

IMM_RRC_cov=p6*P_RRC6+p8b*P_RRC8b(1:6,1:6)+p10b*P_RRC10b(1:6,1:6)+...
    p6*p8b*(RRC_est6-RRC_est8b(1:6))*(RRC_est6-RRC_est8b(1:6))'+...
    p6*p10b*(RRC_est6-RRC_est10b(1:6))*(RRC_est6-RRC_est10b(1:6))'+...
    p8b*p10b*(RRC_est8b(1:6)-RRC_est10b(1:6))*(RRC_est8b(1:6)-RRC_est10b(1:6))';

weight=0;

% UPDATE 6 STATE FILTER  %See "Poor Man' IMM" email
if (rem(index_RRC,25)==0) % reset 6 state filter (FDE)
%     if (rem(index_RRC,filter6_reset_rate)==0) % reset 6 state filter (FDE)
    if p6>0.1
        weight=1;
    else
        weight=p6*0.7;
    end
    RRC_est6=weight*RRC_est6+(1-weight)*(p8b*RRC_est8b(1:6)+...
        p10b*RRC_est10b(1:6))/(p8b+p10b);
    P_RRC6=weight*P_RRC6+(1-weight)*(p8b*P_RRC8b(1:6,1:6)+...
        p10b*P_RRC10b(1:6,1:6))/(p8b+p10b);
end

% % % % Staging (None (=0), Method A (=1) or Method B (=2))
% % % stage_T=time-time_0;
% % % stage_TR=time-stage_last_staging;
% % % stage_a_t=(p8b*RRC_est8b(7)+p10b*RRC_est10b(9))/(p8b+p10b);
% % % if (stage_T>stage_sap6) & (stage_TR>stage_sap5)
% % %     p8b_t_delT=interp1(IMM_keep{iii}.time,IMM_keep{iii}.prob_vec(2,:),...
% % %         time-stage_sap4);
% % %     alpha8_t_delT=interp1(RRC_keep8b{iii}.time,RRC_keep8b{iii}.RRC_est(7,:),...
% % %         time-stage_sap4);
% % %     p10b_t_delT=interp1(IMM_keep{iii}.time,IMM_keep{iii}.prob_vec(3,:),...
% % %         time-stage_sap4);
% % %     alpha10_t_delT=interp1(RRC_keep10b{iii}.time,RRC_keep10b{iii}.RRC_est(9,:),...
% % %         time-stage_sap4);
% % %     stage_a_t_delT=(p8b_t_delT*alpha8_t_delT+p10b_t_delT*alpha10_t_delT)/...
% % %         (p8b_t_delT+p10b_t_delT);
% % %     if (stage_a_t<stage_a_t_delT-stage_sap1) & ...
% % %             (stage_a_t_delT>stage_sap7)
% % %         % declare staging
% % %         disp(['Detected staging at ' num2str(time)])
% % % 
% % %         RRC_est8b(7)=stage_sap2;
% % %         RRC_est8b(8)=beta_init;
% % % 
% % %         P_RRC8b(7:8,:)=zeros(2,8);
% % %         P_RRC8b(:,7:8)=zeros(8,2);
% % %         P_RRC8b(7,7)=max([P_RRC8b(7,7) alpha_P0]);
% % %         P_RRC8b(8,8)=max([P_RRC8b(8,8),beta_P0]);
% % % 
% % %         RRC_est10b(7)=0;
% % %         RRC_est10b(8)=0;
% % %         RRC_est10b(9)=stage_sap2;
% % %         RRC_est10b(10)=beta_init;
% % % 
% % %         P_RRC10b(7:10,:)=zeros(4,10);
% % %         P_RRC10b(:,7:10)=zeros(10,4);
% % %         P_RRC10b(7,7)=thetai_P0;
% % %         P_RRC10b(8,8)=thetac_P0;
% % %         P_RRC10b(9,9)=max([P_RRC10b(9,9) alpha_P0]);
% % %         P_RRC10b(10,10)=max([P_RRC10b(10,10) beta_P0]);
% % % 
% % %         stage_last_staging = time;
% % %     end
% % % end

% Threshold RRC_est6, RRC_est8b, RRC_est10b, IMM_RRC_state:
% velocity mag:
RRC_est6(4:6)=RRC_est6(4:6)*min([norm(RRC_est6(4:6)),max_vel_mag])/norm(RRC_est6(4:6));
RRC_est8b(4:6)=RRC_est8b(4:6)*min([norm(RRC_est8b(4:6)),max_vel_mag])/norm(RRC_est8b(4:6));
RRC_est10b(4:6)=RRC_est10b(4:6)*min([norm(RRC_est10b(4:6)),max_vel_mag])/norm(RRC_est10b(4:6));
IMM_RRC_state(4:6)=IMM_RRC_state(4:6)*min([norm(IMM_RRC_state(4:6)),max_vel_mag])/norm(IMM_RRC_state(4:6));

% alpha
RRC_est8b(7)=min([max([RRC_est8b(7) 0]) f8b_y7_max]);
RRC_est10b(9)=min([max([RRC_est10b(9) 0]) f10b_y9_max]);

% beta
RRC_est8b(8)=min([max([RRC_est8b(8),f8b_y8_min]),f8b_y8_max]);
RRC_est10b(10)=min([max([RRC_est10b(10),f10b_y10_min]),f10b_y10_max]);


updated_group.index_update6 = propagated_group.index_update6 + 1;
updated_group.index_update8b = propagated_group.index_update8b + 1;
updated_group.index_update10b = propagated_group.index_update10b + 1;

% updated_group = propagated_group;
updated_group.RRC_est6 = RRC_est6;
updated_group.RRC_est8b = RRC_est8b;
updated_group.RRC_est10b = RRC_est10b;

IMM_RUV_state = rrc2ruv(IMM_RRC_state, radar.site.fs, radar.site.d_RRC_RFC);
IMM_RUV_cov = J_rrc_ruv(IMM_RUV_state, radar.site.T_RRC_RFC)*IMM_RRC_cov*J_rrc_ruv(IMM_RUV_state, radar.site.T_RRC_RFC);

updated_group.IMM_RRC_state = IMM_RRC_state;
updated_group.IMM_RRC_cov = IMM_RRC_cov;
updated_group.IMM_RUV_state = IMM_RUV_state;
updated_group.IMM_RUV_cov = IMM_RUV_cov;

updated_group.alpha = propagated_group.alpha;
updated_group.beta = propagated_group.beta;
updated_group.state_time = propagated_group.state_time;

updated_group.P_RRC6 = P_RRC6;
updated_group.P_RRC8b = P_RRC8b;
updated_group.P_RRC10b = P_RRC10b;

updated_group.i_tau = propagated_group.i_tau;
updated_group.SNR_dB_out = propagated_group.SNR_dB_out;

updated_group.chi_filtered6 = propagated_group.chi_filtered6;
updated_group.chi_filtered8b = propagated_group.chi_filtered8b;
updated_group.chi_filtered10b = propagated_group.chi_filtered10b;
updated_group.p6=p6;
updated_group.p8b=p8b;
updated_group.p10b=p10b;


DZ = [residual6 residual8b residual10b; residual6_IMM residual8_IMM residual10_IMM];
K = 1;