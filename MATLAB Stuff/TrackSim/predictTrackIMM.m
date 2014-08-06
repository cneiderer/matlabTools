function [xm, pmMatrix, mProb,cov_ruv] = predictTrackIMM ...
    (ns, nm, probTranMatrix, ...
    xm, pmMatrix, mProb, deltaTime,constants,radar,flags,man_flags,switched_to_man);

% function predictTrackIMM
% This function predicts a target track with IMM

% author:  Tom Kurien
% date:  June 1, 2003



% Predict model probabilities
mProbLast = mProb;
mProb = probTranMatrix'*mProbLast;

% Compute mix probabilities
for ii = 1:nm
    for kk = 1:nm
        mixProb(ii,kk) = probTranMatrix(ii,kk)*mProbLast(ii)/mProb(kk);
    end
end

% Mix state
% for kk = 1:nm
%     xmTemp(:,kk) = zeros(ns,1);
%     for jj = 1:nm
%         xmTemp(:,kk) = xmTemp(:,kk) + mixProb(jj,kk)*xm(:,jj);
%     end
% end
% xmTemp(7:10,2)=xm(7:10,2);
% xmTemp(7:10,[1 3])=0;

xmTemp(:,1) = zeros(ns,1);
xmTemp(:,2) = zeros(ns,1);

xmTemp(:,1) =  mixProb(1,1)*xm(:,1) + mixProb(2,1)*xm(:,2);
xmTemp([7 8 10],1)=0;

xmTemp(:,2) = mixProb(1,2)*xm(:,1) + mixProb(2,2)*xm(:,2);
xmTemp([7 8 10],2)=xm([7 8 10],2);


% %Mix covariance
% for kk = 1:nm
%     pmMatrixTemp(:,:,kk) = zeros(6);
%     for jj = 1:nm
%         deltaX = (xm(1:6,jj) - xmTemp(1:6,kk));
%         pmMatrixTemp(1:6,1:6,kk) = pmMatrixTemp(1:6,1:6,kk) + ...
%             mixProb(jj,kk)*(pmMatrix(1:6,1:6,jj) + deltaX*deltaX');
%     end
% end
% 
%
pmMatrixTemp(:,:,1) = zeros(ns);
pmMatrixTemp(:,:,2) = zeros(ns);
deltaX12=(xm(:,2) - xmTemp(:,1));
deltaX12([7 8 10])=0;
deltaX21=(xm(:,1) - xmTemp(:,2));
deltaX21([7 8 10])=0;



pmMatrixTemp(:,:,1) =mixProb(1,1)*(pmMatrix(:,:,1) + (xm(:,1) - xmTemp(:,1))*(xm(:,1) - xmTemp(:,1))') +  mixProb(2,1)*(pmMatrix(:,:,2) + deltaX12*deltaX12') ;
pmMatrixTemp(:,:,2) =mixProb(1,2)*(pmMatrix(:,:,1) + deltaX21*deltaX21') +  mixProb(2,2)*(pmMatrix(:,:,2) + (xm(:,2) - xmTemp(:,2))*(xm(:,2) - xmTemp(:,2))') ;

pmMatrixTemp([7 8 10],[7 8 10],2)=pmMatrix([7 8 10],[7 8 10],2);

xm = xmTemp;
pmMatrix = pmMatrixTemp;


% xm([7 8 10],1)=0;
% pmMatrix([7 8 10],[7 8 10],1)=0;
xm(7:10,[1])=0;
pmMatrix(1:6,7:10,[1])=0;
pmMatrix(7:10,1:10,[1])=0;
    if switched_to_man
    xm(7:10,[2])=0;
    pmMatrix(1:6,7:10,[2])=0;
    pmMatrix(7:10,1:10,[2])=0;
    end

% Predict track state and covariance (in ENU) to current time
for jj = 1:nm
    input_group=[];
    input_group.time=0;
    input_group.pos_rrc=xm(1:3,jj);
    input_group.vel_rrc=xm(4:6,jj);
    input_group.acceleration=xm(7:10,jj);
    input_group.cov_rrc=pmMatrix(1:10,1:10,jj);
    if jj==1 %% exo state group
        input_group.track_type=2;
        input_group.search_source=8;
        output_group = propagate_group(input_group, deltaTime, constants, radar, flags);

        %initialize sg, propagate
    elseif jj==2 & ~switched_to_man %% booster state group
        %initialize sg, propagate
        input_group.track_type=3;
        input_group.search_source=8;
        output_group = propagate_group(input_group, deltaTime, constants, radar, flags);
    elseif jj==2 & switched_to_man %%maneuver
        input_group.track_type=2;
        input_group.search_source=8;
        output_group = propagate_group(input_group, deltaTime, constants, radar, man_flags);
    end
    xm(1:ns,jj) = [output_group.pos_rrc; output_group.vel_rrc; output_group.acceleration];
    pmMatrix(:,:,jj) = output_group.cov_rrc;
    cov_ruv(1:10,1:10,jj)=[output_group.cov_ruv];
end

xm(7:10,[1])=0;
pmMatrix(1:6,7:10,[1])=0;
pmMatrix(7:10,1:10,[1])=0;

if switched_to_man
    xm(7:10,[2])=0;
    pmMatrix(1:6,7:10,[2])=0;
    pmMatrix(7:10,1:10,[2])=0;
end

% x = zeros(ns,1);
% pMatrix = zeros(ns);
% for jj = 1:nm
%     x = x + mProb(jj)*xm(:,jj);
%     pMatrix = pMatrix + mProb(jj)*pmMatrix(:,:,jj);
% end



return
