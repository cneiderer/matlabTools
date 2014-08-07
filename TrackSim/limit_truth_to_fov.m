function truth = limit_truth_to_fov( truth, radar )
%
%     truth = LimitTruthToFOV( truth, radar )
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Takes the truth data and keeps only that which is within the radar's
%      field of view.
%
%   Input:
%        truth     --  The truth being used to generate a detection.
%                      Structure with the following fields
%           time
%           ECI
%           ECR
%
%        radar  --  Structre that represents the radar.
%           site
%              T_ECR_RRC
%              r0_ecr
%              fs
%              d_RRC_RFC
%           maxAngleOffBoresite
%           minimumElevation
%
%   Output:
%        truth 
%           time
%           ECI
%           ECR
%           RRC
%           RUV
%                   
%   Required Functions:
%        Ecr_rrc
%        Rrc_ruv
%        Rrc_rae

%Convert truth to RUV
rrc   =    ecr2rrc(truth.ECR, radar.site.T_ECR_RRC, radar.site.r0_ecr);
ruv   =    rrc2ruv(rrc, radar.site.fs, radar.site.d_RRC_RFC);

%Convert truth to RAE
rae   =    rrc2rae(rrc);
U     =    ruv(2,:);
V     =    ruv(3,:);
W     =    sqrt( 1 - ( U.^2 + V.^2 ) );

AOBS  =    acos( W );

El    =    rae(3,:);

list  =    ( AOBS  <  radar.defaults.maxAngleOffBoresite ) & ...
           ( El    >  radar.defaults.minimumElevation    );
%
% Now, keep only that which is within the radar's field of view
truth.time = truth.time(list);
truth.ECI  = truth.ECI(:,list);
truth.ECR  = truth.ECR(:,list);
truth.RRC  = rrc(:,list);
truth.RUV  = ruv(:,list);

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
