function propagated_group = propagate_imm_group(input_group, c_det, dt, constants, radar, flags)

RRC_est6 = input_group.RRC_est6;
P_RRC = input_group.IMM_RRC_state; %input_group.P_RRC;
P_RRC6 = input_group.IMM_RRC_cov; %input_group.P_RRC6;
alpha = input_group.alpha;
beta = input_group.beta;

p6 = radar.params.p6;
p8b = radar.params.p8b;
p10b = radar.params.p10b;

time_update = input_group.state_time;
time_hit = time_update + dt;

RRC_est8b=input_group.RRC_est8b;
P_RRC8b = input_group.P_RRC8b;

RRC_est10b = input_group.RRC_est10b;
P_RRC10b = input_group.P_RRC10b;

P_vec6=get_upper_cov(P_RRC6);
[t_f,y_f6]=runge_kutta_4v2('propagate_6',time_update,[RRC_est6;P_vec6],time_hit,1,radar,constants);

P_vec8b=get_upper_cov(P_RRC8b);
[t_f,y_f8b]=runge_kutta_4v2('propagate_8b',time_update,[RRC_est8b;P_vec8b],time_hit,1,radar,constants);

P_vec10b=get_upper_cov(P_RRC10b);
[t_f,y_f10b]=runge_kutta_4v2('propagate_10b',time_update,[RRC_est10b;P_vec10b],time_hit,1,radar,constants);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Threshold y_f6, y_f8b, y_f10b:   %%%%%%%% THRESHOLDS %%%%%%%%%%%%%%%%%%
% velocity mag:
y_f6(4:6)=y_f6(4:6)*min([norm(y_f6(4:6)),radar.params.max_vel_mag])/norm(y_f6(4:6));
y_f8b(4:6)=y_f8b(4:6)*min([norm(y_f8b(4:6)),radar.params.max_vel_mag])/norm(y_f8b(4:6));
y_f10b(4:6)=y_f10b(4:6)*min([norm(y_f10b(4:6)),radar.params.max_vel_mag])/norm(y_f10b(4:6));

% alpha
y_f8b(7)=min([max([y_f8b(7) 0]) radar.params.f8b_y7_max]);
y_f10b(9)=min([max([y_f10b(9) 0]) radar.params.f10b_y9_max]);

% beta
y_f8b(8)=min([max([y_f8b(8),radar.params.f8b_y8_min]),radar.params.f8b_y8_max]);
y_f10b(10)=min([max([y_f10b(10),radar.params.f10b_y10_min]),radar.params.f10b_y10_max]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A bunch of coordinate transformations:
RRC_pred6=y_f6(1:6);
RAE_pred6=rrc2rae(RRC_pred6);
RUV_pred6=rrc2ruv(RRC_pred6, radar.site.fs, radar.site.d_RRC_RFC);

RRC_pred8b=y_f8b(1:8);
RAE_pred8b=rrc2rae(RRC_pred8b(1:6));
RUV_pred8b=rrc2ruv(RRC_pred8b(1:6), radar.site.fs, radar.site.d_RRC_RFC);

RRC_pred10b=y_f10b(1:10);
RAE_pred10b=rrc2rae(RRC_pred10b(1:6));
RUV_pred10b=rrc2ruv(RRC_pred10b(1:6), radar.site.fs, radar.site.d_RRC_RFC);

RUV_predIMM=p6*RUV_pred6+p8b*RUV_pred8b+p10b*RUV_pred10b;
RAE_predIMM=p6*RAE_pred6+p8b*RAE_pred8b+p10b*RAE_pred10b;

P_RRC_pred6=put_upper_cov(y_f6);
J_RRC_RUV6=J_rrc_ruv(RUV_pred6, radar.site.T_RRC_RFC);
P_RUV_pred6=J_RRC_RUV6*P_RRC_pred6*J_RRC_RUV6';
P_decoupled6=P_RUV_pred6;

P_RRC_pred8b=put_upper_cov(y_f8b);
J_RRC_RUV8b=J_rrc_ruv(RUV_pred8b,radar.site.T_RRC_RFC);
J_RRC_RUV8b=[J_RRC_RUV8b zeros(6,2);zeros(2,6) eye(2)];
P_RUV_pred8b=J_RRC_RUV8b*P_RRC_pred8b*J_RRC_RUV8b';
P_decoupled8b=P_RUV_pred8b;

P_RRC_pred10b=put_upper_cov(y_f10b);
J_RRC_RUV10b=J_rrc_ruv(RUV_pred10b,radar.site.T_RRC_RFC);
J_RRC_RUV10b=[J_RRC_RUV10b zeros(6,4);zeros(4,6) eye(4)];
P_RUV_pred10b=J_RRC_RUV10b*P_RRC_pred10b*J_RRC_RUV10b';
P_decoupled10b=P_RUV_pred10b;

% Decoupling the early covariance matrices:
if (input_group.index_update6 < constants.map_saps.TP1109);
    P_decoupled6([1 4],[2 3 5 6])=zeros(2,4);
    P_decoupled6([2 3 5 6],[1 4])=zeros(4,2);
end

if (input_group.index_update8b < constants.map_saps.TP1109);
    P_decoupled8b([1 4],[2 3 5 6])=zeros(2,4);
    P_decoupled8b([2 3 5 6],[1 4])=zeros(4,2);
    P_decoupled8b(7:8,1:6)=zeros(2,6);
    P_decoupled8b(1:6,7:8)=zeros(6,2);
    P_decoupled8b(7:8,7:8)=P_RRC_pred8b(7:8,7:8);
end

if (input_group.index_update10b < constants.map_saps.TP1109);
    P_decoupled10b([1 4],[2 3 5 6])=zeros(2,4);
    P_decoupled10b([2 3 5 6],[1 4])=zeros(4,2);
    P_decoupled10b(7:10,1:6)=zeros(4,6);
    P_decoupled10b(1:6,7:10)=zeros(6,4);
    P_decoupled10b(7:10,7:10)=P_RRC_pred10b(7:10,7:10);
end;

% Define measurement matrices (H):

H6=[eye(3,3) zeros(3,3)];
H8b=[eye(3,3) zeros(3,5)];
H10b=[eye(3,3) zeros(3,7)];

% H6(1,4)=H6(1,1)*radar.params.pulse(input_group.i_tau,1)*radar.params.RDC_factor_MB;
% H8b(1,4)=H8b(1,1)*radar.params.pulse(input_group.i_tau,1)*radar.params.RDC_factor_MB;
% H10b(1,4)=H10b(1,1)*radar.params.pulse(input_group.i_tau,1)*radar.params.RDC_factor_MB;

H6(1,4)=H6(1,1)*c_det.rdc_time;
H8b(1,4)=H8b(1,1)*c_det.rdc_time;
H10b(1,4)=H10b(1,1)*c_det.rdc_time;


propagated_group.H6 = H6;
propagated_group.H8b = H8b;
propagated_group.H10b = H10b;

propagated_group.RRC_est6 = RRC_pred6;
propagated_group.P_RRC = P_RRC;
propagated_group.alpha = alpha;
propagated_group.beta = beta;
propagated_group.P_RRC6 = P_RRC6;

propagated_group.RRC_est8b = RRC_pred8b;
propagated_group.P_RRC8b = P_RRC8b;

propagated_group.RRC_est10b = RRC_pred10b;
propagated_group.P_RRC10b = P_RRC10b;

propagated_group.i_tau = input_group.i_tau;
propagated_group.SNR_dB_out = input_group.SNR_dB_out;

propagated_group.RUV_pred6 = RUV_pred6;
propagated_group.P_RUV_pred6 = P_RUV_pred6;
propagated_group.RUV_pred8b = RUV_pred8b;
propagated_group.P_RUV_pred8b = P_RUV_pred8b;
propagated_group.RUV_pred10b = RUV_pred10b;
propagated_group.P_RUV_pred10b = P_RUV_pred10b;

propagated_group.index_update6 = input_group.index_update6;% + 1;
propagated_group.index_update8b = input_group.index_update8b;% + 1;
propagated_group.index_update10b = input_group.index_update10b;% + 1;

propagated_group.state_time = input_group.state_time + dt;

propagated_group.i_tau = input_group.i_tau;

if(input_group.index_update6 > 1)
    propagated_group.chi_filtered6 = input_group.chi_filtered6;
    propagated_group.chi_filtered8b = input_group.chi_filtered8b;
    propagated_group.chi_filtered10b = input_group.chi_filtered10b;
end