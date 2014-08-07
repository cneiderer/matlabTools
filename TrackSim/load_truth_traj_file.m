function truth = load_truth_traj_file(traj_file, radar, constants)
%     loaded = LoadTruth_TrajFile(des_truth, radar, constants)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Load the truth data from the specified file name.
%
%   Input:
%        des_truth  --  String representing the desired missile complex
%        radar
%           aligned    --  structure of when the radar was last aligned.
%                          Following fields are required:
%              year    --  year (e.g. 1988)
%              day     --  day  (day of year, integer, Jan 1 = 1),
%              UT      --  Universal Time = hours since midnight along 
%                          Greenwich Meridian; 0<=UT<=24, (1XN)
%        constants  -- structure of system constants.  Required fields:
%           omega_e_X_EC
%           omega_e_X2_EC
%           deg_to_rad
%           GMST_k
%
%   Output:
%        loaded --  Fields contained:
%           time
%           ECI
%           ECR
%           RRC
%           RUV
%
%   Required Functions:
%        Eci_ecr
%        LimitTruth
%

traj_data = [];

% Truth init.
load(traj_file);  %loads "T", which is 2159 x 10

time = traj_data(:,1)';

%Truth
ECI = traj_data(:,2:7)';
ECR = eci2ecr( ECI, radar.aligned, time/3600, constants );

truth.time = time;
truth.ECI = ECI;
truth.ECR = ECR;

truth = limit_truth_to_fov(truth, radar);

truth = form_truth_to_detection_time(truth, radar);

%Adjust the truth to the desired data rate and to keep only those portions
%that are within the field of view.
% truth = LimitTruth( loaded, radar );


return
