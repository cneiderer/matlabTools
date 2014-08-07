function [x, pMatrix, xm, pmMatrix, mProb, rangeRes, rangeResSig] = ...
         updateTrackIMM (ns, nm, xm, pmMatrix, mProb, y, rMatrix,rdc_time,radar,constants,cov_ruv)
% This function updates a target track with an IMM filter

% author:  Tom Kurien
% date:  June 1, 2003

hMatrix              = zeros(3,10);
   hMatrix(1:3,1:3)     = eye(3);
    hMatrix(1,4)         = rdc_time;
%       pmMatrix(1,[2 3 5 6]) = 0; 
%       pmMatrix(4,[2 3 5 6]) = 0; 
%       pmMatrix([2 3 5 6],1) = 0; 
%       pmMatrix([2 3 5 6],4) = 0; 
for jj = 1:nm
    [yy] = rrc2ruv(xm(1:6,jj), radar.site.fs, radar.site.d_RRC_RFC);
    %[yy] = rrc2rae (xm(:,jj));
%     J_temp = J_rrc_ruv([yy], radar.site.fs);
%     J=zeros(10,10);
%     J(1:6,1:6)=J_temp;
%     J(7:10,7:10)=eye(4,4);
%     cov_ruv=J*pmMatrix(:,:,jj)*J';

    rrMatrix = hMatrix*cov_ruv(:,:,jj)*hMatrix';
    
    res = y - hMatrix(:,1:6)*yy;
    
    resCov = rrMatrix + rMatrix;
    if (rrMatrix(1,1) < 0)
        rrMatrix(1,1)
        pause
    end
    chiSq = res'*inv(resCov)*res;
    like(jj) = exp(-0.5*(chiSq))/sqrt(((2*pi)^nm)*det(resCov));

    rangeRes = res(1);
    rangeResSig = sqrt(resCov(1,1));

    temp2Matrix = cov_ruv(:,:,jj)*hMatrix';

    kMatrix = temp2Matrix*( inv(resCov) );

    ruv_updated = [yy; xm(7:10,jj)] + kMatrix*res;
    xm(1:6,jj)=ruv2rrc( ruv_updated(1:6),    radar.site.fs, radar.site.d_RRC_RFC);
    xm(7:10,jj)=ruv_updated(7:10);
    tempMatrix = eye(ns) - kMatrix*hMatrix;
    cov_ruv(:,:,jj)= tempMatrix*cov_ruv(:,:,jj)*tempMatrix' + kMatrix*rMatrix*kMatrix';
    
    J_RUV_RRC_temp                   =     J_ruv_rrc(ruv_updated, radar.site.fs);  %T_rrc_rfc
    J_RUV_RRC=zeros(10,10);
    J_RUV_RRC(1:6,1:6)=J_RUV_RRC_temp;
    J_RUV_RRC(7:10,7:10)=eye(4);
    pmMatrix(:,:,jj) =   J_RUV_RRC * cov_ruv(:,:,jj) * J_RUV_RRC';

    
    
end

% update model probabilities
p_sum = 0.0;
for jj = 1:nm
    tempProb(jj,1) = mProb(jj)*like(jj);
    p_sum = p_sum + tempProb(jj,1);
end
mProb = tempProb/p_sum;

% compute composite state
x = zeros(ns,1);
for jj = 1:nm
    x = x + mProb(jj)*xm(:,jj);
end

% Compute composite covariance
pMatrix = zeros(ns);
for jj = 1:nm
    deltaX = x - xm(:,jj);
    pMatrix = pMatrix + mProb(jj)*(pmMatrix(:,:,jj) + deltaX*deltaX');
end

return
