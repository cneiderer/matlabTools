function [x, pMatrix, xm, pmMatrix, mProb] = initializeTrackIMM (ns, nm, cue)
% This function initializes a target track

% author:  Tom Kurien
% date:  June 1, 2003

% Initialize track state and covariance
for jj = 1:nm
    xm(1:ns,jj) = [cue.enuPos; cue.enuVel];
    
    pmMatrix(1:ns,1:ns,jj) = zeros(ns);
      
    pmMatrix(1:3, 1:3,jj) = (cue.enuPosSigma^2)*eye(3);
    pmMatrix(4:6, 4:6,jj) = (cue.enuVelSigma^2)*eye(3);
end

for jj = 1:nm
    mProb(jj,1) = 1/nm;
end

x = zeros(ns,1);
pMatrix = zeros(ns);
for jj = 1:nm
    x = x + mProb(jj)*xm(:,jj);
    pMatrix = pMatrix + mProb(jj)*pmMatrix(:,:,jj);
end
 
return
