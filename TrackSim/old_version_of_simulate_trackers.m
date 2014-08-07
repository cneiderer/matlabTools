function [constants radar truth trackdata Tlower Tupper]=simulate_trackers(init_data,truth)
%   UNCLASSIFIED
%
%   DESCRIPTION
%       The main routine for simulation
%
%%  Initialize: flags, constants, radar, truth, detection
flags.noQ = false;
flags.noBkwdProp = true;
flags.maneuver=0;

[constants radar truth_dontuse] = initialize_tracker(init_data);

constants.map_saps.map_tp_sap_8001 =10;    %test sap for maneuver filter

%%  10-state/exo below altitude and ascending, exo/maneuver above

detection = generate_detections(constants, radar, truth); %does only upchirp!?
detection.rdc_time(2)=-detection.rdc_time(2);

%%  Normal Track Init
state_group = track_initialization(detection, constants, radar);
state_group.track_type = 3;  %force to booster
% initialize staging struct for track type transitions
state_group.staging_struct.acc_thrust_mags=0;
state_group.staging_struct.alpha_vars=0;
state_group.staging_struct.burn_out_flag=0;
state_group.staging_struct.interstage_flag=0;
state_group.staging_struct.stage_altitude=0;
state_group.staging_struct.stage_count=0;
state_group.staging_struct.staging_flag_vec=0;
state_group.staging_struct.staging_time_vec=0;
state_group.staging_struct.t_burn_out=0;
state_group.staging_struct.update_times=0;


%% Daum IMM
imm_state_group = imm_track_initialization(truth, detection, constants, radar);

%%  IMM Track, variable init
nm=2;
ns=10;
probTranMatrix = [0.99  0.01;  0.05  0.95];

for jj = 1:nm
    mProb(jj,1) = 1/nm;
end

current6sgroup_IMM = track_initialization(detection, constants, radar);
current6sgroup_IMM.track_type=2;
current10sgroup_IMM = reinitializeGroupFromexistinggroup(current6sgroup_IMM,10,constants.map_saps);
current10sgroup_IMM.track_type=3;

xm=[[current6sgroup_IMM.pos_rrc; current6sgroup_IMM.vel_rrc; current6sgroup_IMM.acceleration] [current10sgroup_IMM.pos_rrc; current10sgroup_IMM.vel_rrc; current10sgroup_IMM.acceleration]];
x=xm(:,1);
pmMatrix(1:10,1:10,1)=current6sgroup_IMM.cov_rrc(1:10,1:10);
pmMatrix(1:10,1:10,2)=current10sgroup_IMM.cov_rrc(1:10,1:10);
pMatrix=pmMatrix(1:10,1:10,1);

mProball=[];

%%  AMM initialization
Alpha   =   .05;
Beta    =   .0001;

Tlower  =   log(     Beta   /   (1 - Alpha) );
Tupper  =   log((1 - Beta ) /   (    Alpha) );

score = 0;
boostingconfirmationtimes=[];
exoconfirmationtimes=[];

current6sgroup_AMM = track_initialization(detection, constants, radar);
current6sgroup_AMM.track_type=2;
current10sgroup_AMM = reinitializeGroupFromexistinggroup(current6sgroup_AMM,10,constants.map_saps);
current10sgroup_AMM.track_type=3;
amm_tt=3;


%% initialize output struct
n_det=length(detection.time);
trackdata=[];

trackdata.pred_ruv =zeros((n_det),3);
trackdata.ruv=zeros((n_det),3);
trackdata.ruv_rate=zeros((n_det),3);
trackdata.ruv_var=zeros((n_det),3);
trackdata.ruv_rate_var=zeros((n_det),3);
trackdata.resid_ruv=zeros((n_det),3);
trackdata.track_type=zeros((n_det),1);
trackdata.rrc_covariance=zeros((n_det),10,10);
trackdata.acceleration=zeros((n_det),4);

trackdata.imm.rrc_state=zeros(n_det,6);
trackdata.imm.rrc_cov=zeros(n_det,6,6);
trackdata.imm.p6=zeros(n_det,1);
trackdata.imm.p8b=zeros(n_det,1);
trackdata.imm.p10b=zeros(n_det,1);
trackdata.imm.P_RRC6 = zeros(n_det,6,6);
trackdata.imm.P_RRC8b = zeros(n_det,8,8);
trackdata.imm.P_RRC10b = zeros(n_det,10,10);

trackdata.amm_pred_ruv=zeros((n_det),3);
trackdata.amm_ruv=zeros((n_det),3);
trackdata.amm_ruv_rate=zeros((n_det),3);
trackdata.amm_ruv_var=zeros((n_det),3);
trackdata.amm_ruv_rate_var=zeros((n_det),3);
trackdata.amm_resid_ruv=zeros((n_det),3);
trackdata.amm_score=zeros((n_det),1);
trackdata.amm_track_type=zeros((n_det),1);
trackdata.amm_rrc_covariance=zeros((n_det),10,10);
trackdata.amm_acceleration=zeros((n_det),4);

trackdata.imm_residr=zeros(length(n_det),1);
trackdata.imm_x=zeros(length(n_det),3);
trackdata.imm_xm1=zeros(length(n_det),3);
trackdata.imm_xm2=zeros(length(n_det),3);
trackdata.imm_pm1=zeros(length(n_det),10,10);
trackdata.imm_pm2=zeros(length(n_det),10,10);
trackdata.imm_mProb=zeros(length(n_det),2);
trackdata.imm_p=zeros(length(n_det),10,10);

%% Begin Track with third detection, since 1 and 2 were used for pulse pair init
for dd=3:length(detection.time)
    %% declare detection
    c_det.time(1) = detection.time(dd);
    c_det.rdc_time(1) = detection.rdc_time(dd);
    c_det.ruv(:,1) = detection.ruv(:,dd);
    c_det.ruv_var(:,1) = detection.ruv_var(:,dd);
    c_det.pw(1) = detection.pw(dd);
    c_det.SNR(1) = detection.SNR(dd);

    dt = c_det.time - state_group.time;
    rMatrix=diag(c_det.ruv_var);
    y=c_det.ruv;
    %%  AMM Propagate, Update, score, Reinitialize, Propagate, Update

    use_dimm=0;
    if use_dimm==1
        imm_propagated_group = propagate_imm_group(imm_state_group, c_det, dt, constants, radar, flags);
        [imm_state_group, imm_residual, imm_K] = udpate_imm_group(imm_propagated_group, c_det, constants, radar);

        trackdata.imm.rrc_state(dd,:)=imm_state_group.IMM_RRC_state.';
        trackdata.imm.rrc_cov(dd,:,:)=imm_state_group.IMM_RRC_cov;

        trackdata.imm.p6(dd)=imm_state_group.p6;
        trackdata.imm.p8b(dd)=imm_state_group.p8b;
        trackdata.imm.p10b(dd)=imm_state_group.p10b;
        trackdata.imm.P_RRC6(dd,:,:) = imm_state_group.P_RRC6;
        trackdata.imm.P_RRC8b(dd,:,:) = imm_state_group.P_RRC8b;
        trackdata.imm.P_RRC10b(dd,:,:) = imm_state_group.P_RRC10b;
    end

    use_amm=1;
    if use_amm==1
if dd=300%% condition to switch from 10-state/6-state to 6-state/maneuver
        prop10sgroup = propagate_group(current10sgroup_AMM, dt, constants, radar, flags);
        [next10sgroup, tens_residual, tens_K] = update_group(prop10sgroup, c_det, constants, radar);

        prop6sgroup = propagate_group(current6sgroup_AMM, dt, constants, radar, flags);
        [next6sgroup, sixs_residual, sixs_K] = update_group(prop6sgroup, c_det, constants, radar);

        score = score + computeLogLikelihoodRatio(prop10sgroup,next10sgroup,prop6sgroup,next6sgroup,c_det);

        if score > Tupper  % booster is confirmed
            amm_tt=3;
            boostingconfirmationtimes = [boostingconfirmationtimes c_det.time];
            current6sgroup_AMM = reinitializeGroupFromexistinggroup(current10sgroup_AMM,6);
            %next6sgroup = sixstatefilterupdatejf(current6sgroup_AMM,c_det);
            prop6sgroup = propagate_group(current6sgroup_AMM, dt, constants, radar, flags);
            [next6sgroup, sixs_residual, sixs_K] = update_group(prop6sgroup, c_det, constants, radar);

            trackdata.amm_pred_ruv(dd,:)=prop10sgroup.pos_ruv.';
            trackdata.amm_ruv(dd,:)=next10sgroup.pos_ruv.';
            trackdata.amm_ruv_rate(dd,:)=next10sgroup.vel_ruv.';
            trackdata.amm_ruv_var(dd,:)=diag(next10sgroup.cov_ruv(1:3,1:3));
            trackdata.amm_ruv_rate_var(dd,:)=diag(next10sgroup.cov_ruv(4:6,4:6));
            trackdata.amm_resid_ruv(dd,:)=tens_residual;
            trackdata.amm_score(dd)=score;
            trackdata.amm_track_type(dd)=3;
            trackdata.amm_rrc_covariance(dd,:,:)=next10sgroup.cov_rrc(:,:);
            trackdata.amm_acceleration(dd,:)=next10sgroup.acceleration.';

            score = 0;


        elseif score < Tlower % exo is confirmed.  reset boost filter and reprocess current detection
            amm_tt=2;
            exoconfirmationtimes = [exoconfirmationtimes c_det.time];
            current10sgroup_AMM = reinitializeGroupFromexistingGroup(current6sgroup_AMM,10,constants.map_saps);
            %next10sgroup = tenstatefilterupdatejf(current10sgroup_AMM,c_det);
            prop10sgroup = propagate_group(current10sgroup_AMM, dt, constants, radar, flags);
            [next10sgroup, tens_residual, tens_K] = update_group(prop10sgroup, c_det, constants, radar);

            trackdata.amm_pred_ruv(dd,:)=prop6sgroup.pos_ruv.';
            trackdata.amm_ruv(dd,:)=next6sgroup.pos_ruv.';
            trackdata.amm_ruv_rate(dd,:)=next6sgroup.vel_ruv.';
            trackdata.amm_ruv_var(dd,:)=diag(next6sgroup.cov_ruv(1:3,1:3));
            trackdata.amm_ruv_rate_var(dd,:)=diag(next6sgroup.cov_ruv(4:6,4:6));
            trackdata.amm_resid_ruv(dd,:)=sixs_residual;
            trackdata.amm_score(dd)=score;
            trackdata.amm_track_type(dd,1)=2;
            trackdata.amm_rrc_covariance(dd,:,:)=next6sgroup.cov_rrc(:,:);
            trackdata.amm_acceleration(dd,:)=next6sgroup.acceleration.';
            score = 0;

        else
            if amm_tt==2
                trackdata.amm_pred_ruv(dd,:)=prop6sgroup.pos_ruv.';
                trackdata.amm_ruv(dd,:)=next6sgroup.pos_ruv.';
                trackdata.amm_ruv_rate(dd,:)=next6sgroup.vel_ruv.';
                trackdata.amm_ruv_var(dd,:)=diag(next6sgroup.cov_ruv(1:3,1:3));
                trackdata.amm_ruv_rate_var(dd,:)=diag(next6sgroup.cov_ruv(4:6,4:6));
                trackdata.amm_resid_ruv(dd,:)=sixs_residual;
                trackdata.amm_score(dd)=score;
                trackdata.amm_track_type(dd,1)=2;
                trackdata.amm_rrc_covariance(dd,:,:)=next6sgroup.cov_rrc(:,:);
                trackdata.amm_acceleration(dd,:)=next6sgroup.acceleration.';
            elseif amm_tt==3
                trackdata.amm_pred_ruv(dd,:)=prop10sgroup.pos_ruv.';
                trackdata.amm_ruv(dd,:)=next10sgroup.pos_ruv.';
                trackdata.amm_ruv_rate(dd,:)=next10sgroup.vel_ruv.';
                trackdata.amm_ruv_var(dd,:)=diag(next10sgroup.cov_ruv(1:3,1:3));
                trackdata.amm_ruv_rate_var(dd,:)=diag(next10sgroup.cov_ruv(4:6,4:6));
                trackdata.amm_resid_ruv(dd,:)=tens_residual;
                trackdata.amm_score(dd)=score;
                trackdata.amm_track_type(dd,1)=3;
                trackdata.amm_rrc_covariance(dd,:,:)=next10sgroup.cov_rrc(:,:);
                trackdata.amm_acceleration(dd,:)=next10sgroup.acceleration.';
            end

        end
        current10sgroup_AMM=next10sgroup;
        current6sgroup_AMM=next6sgroup;
    end
    %%  IMM Propagate, Update, Chi2 and Likelihood, Composite States
    use_imm=0;
    if use_imm==1
        xm(7:10,1)=zeros(4,1);
        pmMatrix(1:6,7:10,1)=zeros(6,4);
        pmMatrix(7:10,1:10,1)=zeros(4,10);
        %         pmMatrix(7,7,1)    = constants.map_saps.map_tp_sap_6011;
        %         pmMatrix(8,8,1)    = constants.map_saps.map_tp_sap_6012;
        %         pmMatrix(9,9,1)    = constants.map_saps.map_tp_sap_6013;
        %         pmMatrix(10,10,1)  = constants.map_saps.map_tp_sap_6014;


        %         pmMatrix(7,7,1)    = 0;
        %         pmMatrix(8,8,1)    = 0;
        %         pmMatrix(9,9,1)    = 0;
        %         pmMatrix(10,10,1)  = 0;


        [xm, pmMatrix, mProb,cov_ruv] = predictTrackIMM ...
            (ns, nm, probTranMatrix, ...
            xm, pmMatrix, mProb, dt,constants,radar,flags);



        [x, pMatrix, xm, pmMatrix, mProb, rangeRes, rangeResSig] = ...
            updateTrackIMM (ns, nm, xm, pmMatrix, mProb, y, rMatrix,c_det.rdc_time,radar,constants,cov_ruv);



        trackdata.imm_residr(dd,1)=rangeRes;
        trackdata.imm_x(dd,1:10)=x;
        trackdata.imm_xm1(dd,1:10)=xm(1:10,1);
        trackdata.imm_xm2(dd,1:10)=xm(1:10,2);
        trackdata.imm_pm1(dd,1:10,1:10)=pmMatrix(1:10,1:10,1);
        trackdata.imm_pm2(dd,1:10,1:10)=pmMatrix(1:10,1:10,2);
        trackdata.imm_mProb(dd,1:2)=mProb;
        trackdata.imm_p(dd,:,:)=pMatrix;
    end

    trackdata.det_ruv(dd,:)=detection.ruv(:,dd);
    trackdata.det_ruv_var(dd,:)= detection.ruv_var(:,dd);
    trackdata.det_time(dd,1)= detection.time(dd);
    trackdata.rdc_time(dd,1) = detection.rdc_time(dd);
    trackdata.snr(dd,1) = detection.SNR(dd);
    use_normalkf=1;
    if use_normalkf==1
        %%  Update normal Kalman Filter
        propagated_group = propagate_group(state_group, dt, constants, radar, flags);
        [state_group, residual, K] = update_group(propagated_group, c_det, constants, radar);
        state_group.object_kind=0;
        state_group = Calc_track_type_transition(state_group, constants, radar);


        %% Data Recording %%

        trackdata.pred_ruv(dd,:) =propagated_group.pos_ruv.';
        trackdata.ruv(dd,:)=state_group.pos_ruv.';
        trackdata.ruv_rate(dd,:)=state_group.vel_ruv.';
        trackdata.ruv_var(dd,:)=diag(state_group.cov_ruv(1:3,1:3)).';
        trackdata.ruv_rate_var(dd,:)=diag(state_group.cov_ruv(4:6,4:6)).';
        trackdata.resid_ruv(dd,:)=residual;
        trackdata.track_type(dd,1)=state_group.track_type;
        trackdata.rrc_covariance(dd,:,:)=state_group.cov_rrc(:,:);
        trackdata.acceleration(dd,:)=state_group.acceleration(:).';
    end
end


%% Caclulate Residual Acceleration from truth
truth.a_rrc=[diff(truth.RRC(4:6,:).')./repmat(diff(truth.time.'),1,3)].';
truth.a_rrc=[ [0 0 0].' , truth.a_rrc];
for ii=1:length(truth.time)
    [acc_grav, acc_cor, acc_cen] = Acceleration(truth.RRC(1:3,ii)+radar.site.r0_rrc,truth.RRC(4:6,ii), constants, radar);
    truth.residial_acc(ii)=norm(truth.a_rrc(:,ii) - acc_grav - acc_cor - acc_cen);
end