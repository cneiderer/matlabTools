function [constants radar truth Tlower Tupper kf amm imm detection trackdata]=simulate_trackers(constants, radar, truth)
%   UNCLASSIFIED
%
%   DESCRIPTION
%       The main routine for simulation
%
%%  Initialize: flags, constants, radar, truth, detection
flags.noQ = false;
flags.noBkwdProp = true;
flags.maneuver=0;

man_flags=flags;
man_flags.maneuver=1;

switched_to_man=0;
%[constants radar truth_dontuse] = initialize_tracker(init_data);
reset_score=0;
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
probTranMatrix = [0.99  0.01;  0.05  0.95;];

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
pMatrix=pmMatrix(1:10,1:10,2);

mProball=[];

%%  AMM initialization
Alpha   =   .05;
Beta    =  .005; %.0001;

Tlower  =   log(     Beta   /   (1 - Alpha) );
Tupper  =   log((1 - Beta ) /   (    Alpha) );

b2escore = 0;
m2escore = 0;
current6sgroup_AMM = track_initialization(detection, constants, radar);
current6sgroup_AMM.track_type=2;
current10sgroup_AMM = reinitializeGroupFromexistinggroup(current6sgroup_AMM,10,constants.map_saps);
current10sgroup_AMM.track_type=3;
currentmaneuvergroup_AMM=current6sgroup_AMM;

amm_model='bst';
prev_amm_model='none';

%% initialize output struct
n_det=length(detection.time);

kf=[];
kf.sv=zeros(length(detection.time),10);
kf.cov=zeros(length(detection.time),10,10);
in_man_filter=0;
kf.in_man_filter=zeros(length(detection.time),1);
kf.rres=zeros(length(detection.time),1);

amm=[];
amm.score=zeros(length(detection.time),1);
amm.allscores=zeros(length(detection.time),2);
amm.model=zeros(length(detection.time),1);
amm.sv=zeros(length(detection.time),10);
amm.cov=zeros(length(detection.time),10,10);
amm.e2b=[]; amm.b2e=[]; amm.e2m=[]; amm.m2e=[];
amm.rres=zeros(length(detection.time),1);

imm=[];
imm.mProb=zeros(length(detection.time),3);
imm.p=zeros(length(detection.time),10,10);
imm.x=zeros(length(detection.time),10);
imm.rres=zeros(length(detection.time),1);

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

    prop10sgroup = propagate_group(current10sgroup_AMM, dt, constants, radar, flags);
    [next10sgroup, tens_residual, tens_K] = update_group(prop10sgroup, c_det, constants, radar);

    prop6sgroup = propagate_group(current6sgroup_AMM, dt, constants, radar, flags);
    [next6sgroup, sixs_residual, sixs_K] = update_group(prop6sgroup, c_det, constants, radar);

    propmangroup = propagate_group(currentmaneuvergroup_AMM, dt, constants, radar, man_flags);
    [nextmangroup, man_residual, man_K] = update_group(propmangroup, c_det, constants, radar);

    %if c_det.time<500%% condition to switch from 10-state/6-state to 6-state/maneuver
        b2escore = b2escore + computeLogLikelihoodRatio(prop10sgroup,next10sgroup,prop6sgroup,next6sgroup,c_det);
        m2escore = m2escore + computeLogLikelihoodRatio(propmangroup,nextmangroup,prop6sgroup,next6sgroup,c_det);
if       b2escore<Tlower & m2escore<Tlower
    %exo confirmed
    amm_model='exo';
            
            current10sgroup_AMM = reinitializeGroupFromexistingGroup(current6sgroup_AMM,10,constants.map_saps);
            prop10sgroup = propagate_group(current10sgroup_AMM, dt, constants, radar, flags);
            [next10sgroup, tens_residual, tens_K] = update_group(prop10sgroup, c_det, constants, radar);
            reset_score=1;
            currentmaneuvergroup_AMM = reinitializeGroupFromexistinggroup(current6sgroup_AMM,6);
            propmangroup = propagate_group(currentmaneuvergroup_AMM, dt, constants, radar, man_flags);
            [nextmangroup, man_residual, man_K] = update_group(propmangroup, c_det, constants, radar);
elseif b2escore>Tupper & b2escore>m2escore
    amm_model='bst';
           
            current6sgroup_AMM = reinitializeGroupFromexistinggroup(current10sgroup_AMM,6);
            prop6sgroup = propagate_group(current6sgroup_AMM, dt, constants, radar, flags);
            [next6sgroup, sixs_residual, sixs_K] = update_group(prop6sgroup, c_det, constants, radar);

            reset_score=1;

%             currentmaneuvergroup_AMM = reinitializeGroupFromexistinggroup(current10sgroup_AMM,6);
%             propmangroup = propagate_group(currentmaneuvergroup_AMM, dt, constants, radar, man_flags);
%             [nextmangroup, man_residual, man_K] = update_group(propmangroup, c_det, constants, radar);

    %bst confirmed
elseif m2escore>Tupper & m2escore>b2escore
    %maneuver confirmed
     amm_model='man';
            
            current6sgroup_AMM = reinitializeGroupFromexistinggroup(currentmaneuvergroup_AMM,6);
            prop6sgroup = propagate_group(current6sgroup_AMM, dt, constants, radar, flags);
            [next6sgroup, sixs_residual, sixs_K] = update_group(prop6sgroup, c_det, constants, radar);
            reset_score=1;

else
    reset_score=0;%disp('howd you get here?')
end
     
        current10sgroup_AMM=next10sgroup;
        current6sgroup_AMM=next6sgroup;
        currentmaneuvergroup_AMM=nextmangroup;
    %end

    amm.score(dd)=max(m2escore,b2escore);
    amm.allscores(dd,:)=[m2escore  b2escore].';
    
    switch amm_model
        case 'bst'
            if strcmpi(prev_amm_model,'exo')
                amm.e2b=[amm.e2b; c_det.time];
            end
            amm.sv(dd,1:10)=[current10sgroup_AMM.pos_ruv.' current10sgroup_AMM.vel_ruv.' current10sgroup_AMM.acceleration.'];
            amm.cov(dd,1:10,1:10)=current10sgroup_AMM.cov_rrc;
            amm.model(dd)=1;
            amm.rres(dd)=current10sgroup_AMM.residual(1);
        case 'exo'
            if strcmpi(prev_amm_model,'bst')
                amm.b2e=[amm.b2e; c_det.time];
            end
            if strcmpi(prev_amm_model,'man')
                amm.m2e=[amm.m2e; c_det.time];
            end
            amm.sv(dd,1:6)=[current6sgroup_AMM.pos_ruv.' current6sgroup_AMM.vel_ruv.'];
            amm.cov(dd,1:6,1:6)=current6sgroup_AMM.cov_rrc(1:6,1:6);
            amm.model(dd)=2;
            amm.rres(dd)=current6sgroup_AMM.residual(1);
        case 'man'
            if strcmpi(prev_amm_model,'exo')
                amm.e2m=[amm.e2m; c_det.time];
            end
            amm.sv(dd,1:6)=[currentmaneuvergroup_AMM.pos_ruv.' currentmaneuvergroup_AMM.vel_ruv.'];
            amm.cov(dd,1:6,1:6)=currentmaneuvergroup_AMM.cov_rrc(1:6,1:6);
            amm.model(dd)=3;
            amm.rres(dd)=currentmaneuvergroup_AMM.residual(1);
    end
    if reset_score
        b2escore=0;
        m2escore=0;
    end
    reset_score=0;
    prev_amm_model=amm_model;
    %%  IMM Propagate, Update, Chi2 and Likelihood, Composite States

    if ~switched_to_man & c_det.time>500
        switched_to_man=1;
        xm(:,2)=xm(:,1);
        pmMatrix(:,:,2)=pmMatrix(:,:,1);
    end
    
    xm(7:10,[1])=0;
    pmMatrix(1:6,7:10,[1])=0;
    pmMatrix(7:10,1:10,[1])=0;

    if switched_to_man
    xm(7:10,[2])=0;
    pmMatrix(1:6,7:10,[2])=0;
    pmMatrix(7:10,1:10,[2])=0;
    end
    
    [xm, pmMatrix, mProb,cov_ruv] = predictTrackIMM ...
        (ns, nm, probTranMatrix, ...
        xm, pmMatrix, mProb, dt,constants,radar,flags,man_flags,switched_to_man);

    [x, pMatrix, xm, pmMatrix, mProb, rangeRes, rangeResSig] = ...
        updateTrackIMM (ns, nm, xm, pmMatrix, mProb, y, rMatrix,c_det.rdc_time,radar,constants,cov_ruv);

    imm.mProb(dd,1:2)=mProb;
    imm.p(dd,:,:)=pMatrix;
    imm.x(dd,:)=x;
    imm.rres(dd)=rangeRes;

    %%  Update normal Kalman Filter
    if in_man_filter
        propagated_group = propagate_group(state_group, dt, constants, radar, man_flags);
    else
        propagated_group = propagate_group(state_group, dt, constants, radar, flags);
    end
    
    [state_group, residual, K,man_det] = update_group(propagated_group, c_det, constants, radar);
    state_group.object_kind=0;

    if ~in_man_filter & man_det & c_det.time>500
        in_man_filter=1;
        man_start_time=c_det.time;
    end

    if in_man_filter & c_det.time>(man_start_time+10)
        in_man_filter=0;
    end
    
    state_group = Calc_track_type_transition(state_group, constants, radar);

    kf.sv(dd,:)=[state_group.pos_ruv.' state_group.vel_ruv.' state_group.acceleration.'];
    kf.cov(dd,:,:)=[state_group.cov_rrc];
    kf.tt(dd)=state_group.track_type;
    kf.in_man_filter(dd)=in_man_filter;
    kf.rres(dd)=state_group.residual(1);
end


%% Caclulate Residual Acceleration from truth
truth.a_rrc=[diff(truth.RRC(4:6,:).')./repmat(diff(truth.time.'),1,3)].';
truth.a_rrc=[ [0 0 0].' , truth.a_rrc];
for ii=1:length(truth.time)
    [acc_grav, acc_cor, acc_cen] = Acceleration(truth.RRC(1:3,ii)+radar.site.r0_rrc,truth.RRC(4:6,ii), constants, radar);
    truth.residial_acc(ii)=norm(truth.a_rrc(:,ii) - acc_grav - acc_cor - acc_cen);
end



% use_dimm=1;
% if use_dimm==1
%     imm_propagated_group = propagate_imm_group(imm_state_group, c_det, dt, constants, radar, flags);
%     [imm_state_group, imm_residual, imm_K] = udpate_imm_group(imm_propagated_group, c_det, constants, radar);
%     
%     trackdata.imm.rrc_state(dd,:)=imm_state_group.IMM_RRC_state.';
%     trackdata.imm.rrc_cov(dd,:,:)=imm_state_group.IMM_RRC_cov;
%     
%     trackdata.imm.p6(dd)=imm_state_group.p6;
%     trackdata.imm.p8b(dd)=imm_state_group.p8b;
%     trackdata.imm.p10b(dd)=imm_state_group.p10b;
%     trackdata.imm.P_RRC6(dd,:,:) = imm_state_group.P_RRC6;
%     trackdata.imm.P_RRC8b(dd,:,:) = imm_state_group.P_RRC8b;
%     trackdata.imm.P_RRC10b(dd,:,:) = imm_state_group.P_RRC10b;
% end