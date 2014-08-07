function truth = FormTruthToDetectionTime(truth, radar)
%
%     truth = FormTruthToDetectionTime(truth, radar)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Takes the truth data and mimics a specified data rate.
%
%   Input:
%        truth     --  The truth being used to generate a detection.
%                      Structure with the following fields
%           time
%           ECI
%           ECR
%           RRC
%           RUV
%
%        radar  --  Structre that represents the radar.
%           site
%              T_ECR_RRC
%              r0_ecr
%              fs
%              d_RRC_RFC
%           missionProfile    --  A structure representing the radar 
%                                 mission profile.  Requires the following
%                                 fields:
%              dataRate         --  requested data rate
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
%        LimitTruthToFOV
%        

dataRate  = radar.mission_profile.dataRate;
startTime = truth.time(1);
stopTime  = truth.time(end);

deltaT             =    1.0 / dataRate;
times              =    startTime : deltaT : stopTime ;

if times(end) ~= stopTime; 
    times        =  [ times stopTime ]; 
end

times = sort(times); %put them in ascending order

%Interpret all the state vectors
eci      =   interp1( truth.time, truth.ECI', times, 'spline' )';
ecr      =   interp1( truth.time, truth.ECR', times, 'spline' )';
rrc      =   interp1( truth.time, truth.RRC', times, 'spline' )';
ruv      =   interp1( truth.time, truth.RUV', times, 'spline' )';

truth.time = times;
truth.ECI  = eci;
truth.ECR  = ecr;
truth.RRC  = rrc;
truth.RUV  = ruv;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
