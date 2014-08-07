function [constants radar truth trackdata Tlower Tupper]=simulate_trackers_imm(init_data)
%   UNCLASSIFIED
%
%   DESCRIPTION
%       The main routine for simulation

flags.noQ = false;
flags.noBkwdProp = true;
[constants radar truth] = initialize_tracker(init_data);


% Generate Detections from Truth Data
detection = generate_detections(constants, radar, truth); %does only upchirp!?
detection.rdc_time(2)=-detection.rdc_time(2);


current6sgroup_imm = track_initialization(detection, constants, radar);
current6sgroup_imm.track_type=2;
current10sgroup_imm = reinitializeGroupFromexistingGroup(current6sgroup_imm,10,constants.map_saps);
current10sgroup_imm.track_type=3;

xm=[[current6sgroup_imm.pos_rrc; current6sgroup_imm.vel_rrc;] [current10sgroup_imm.pos_rrc; current10sgroup_imm.vel_rrc; current10sgroup_imm.acceleration]];
x=xm(:,1);
pmMatrix(1:10,1:10,1)=current6sgroup_imm.cov_rrc(1:10,1:10);
pmMatrix(1:10,1:10,2)=current10sgroup_imm.cov_rrc(1:10,1:10);
pMatrix=pmMatrix(1:10,1:10,1);


% Process radar measurements with EKF
ns = 6; %number of states for each filter
nm = 2; %number of models in IMM filter

for jj = 1:nm
    mProb(jj,1) = 1/nm;
end

    % Set probability transition matrix for IMM filter
    probTranMatrix = [0.99  0.01;  0.05  0.95];

    numReports=length(truth.time(3:end));
    rRes(1:numReports) = 0.0;
rResSig(1:numReports) = 0.0;
modelProb(numReports,2) = 0.0;
    

% rMatrix = zeros(3);
rMatrix=diag([3 1 1]);
% rMatrix(1,1) = 2*(sigma.range(1)^2);
% rMatrix(2,2) = sigma.az(1)^2;
% rMatrix(3,3) = sigma.el(1)^2;

for dd=3:numReports

    %%%%%%%%%%%%%%%%%declare detection%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    det.time(1) = detection.time(dd);
    det.rdc_time(1) = detection.rdc_time(dd);
    det.ruv(:,1) = detection.ruv(:,dd);
    det.ruv_var(:,1) = detection.ruv_var(:,dd);
    det.pw(1) = detection.pw(dd);
    det.SNR(1) = detection.SNR(dd);
    y=rrc2rae(ruv2rrc(det.ruv(:,1),radar.site.fs, radar.site.d_RRC_RFC));
    
    dt = det.time - current6sgroup_imm.time;
    
    [xm, pmMatrix, mProb] = predictTrackIMM ...
         (ns, nm, probTranMatrix, ...
          xm, pmMatrix, mProb, dt,constants,radar,flags);
      
    [x, pMatrix, xm, pmMatrix, mProb, rangeRes, rangeResSig] = ...
         updateTrackIMM (ns, nm, xm(1:3,:), pmMatrix(1:3,1:3,:), mProb, y, rMatrix);

    rRes(n) = rangeRes;
    rResSig(n) = rangeResSig;

    for jj = 1:nm
        modelProb(n,jj) = mProb(jj);
    end

     
     
end
