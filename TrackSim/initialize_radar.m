function radar = initialize_radar(init_data, physical_constants)
%   UNCLASSIFIED
%
%   DESCRIPTION
%       Initializes radar parameters
%
%   Input:
%        fName_radar_loc     --  String that specifies the full path and
%                                file name of the text file containing the
%                                radar's location and orientation
%                                information
%        fName_radar_def     --  String that specifies the full path and
%                                file name of the text file containing the
%                                radar's definition, such as bandwidth,
%                                maximum pulse width, etc.
%        fName_mision_profile  -- String that specifies the full path and
%                                 file name of the text file containing the
%                                 radar's mission profile
%
%        physical_constants  --  Structure that contains physical constants.
%                                Required fields:
%           f_earth     --  earth flattening coefficient
%           re          --  earth equatorial radius (m)
%
%   Output:
%        radar -- structure that represents the desired radar.
%           site                --  A structure of site specific parameters
%              radar_location  --  [ lat lon height ] (radians/ meters)
%              radar_attitude  --  [ az el clock ]  (radians)
%              omega_e_x       --  cross product matrix between earth rrc
%                                  rotation vector and ...
%              twice_omega_e_x --  two times omega_e_x, done to eliminate
%                                  repeated calculations in later functions
%              omega_e_x_sq    --  square of omega_e_x
%              r0_ecr          --  position vector from earth center to site
%                                  in ecr
%              se              --  dir cosine matrix transforming from ECR to
%                                  site(rrc) coords
%              es              --  dir cosine matrix transforming from site to
%                                  ECR coords
%              r0_rrc          --  position vector from earth center to site
%                                  in rrc
%              uP              --  unit vector along earth polar axis 'north
%                                  up' in RRC
%              lat             --  lat (rad)
%              lon             --  lon (rad)
%              height          --  height (m)
%              az              --  az (rad)
%              el              --  el (rad)
%              clock           --  clock (rad)
%              sf              --  dir cosine matrix transforming from face to
%                                  site coords
%              fs              --  dir cosine matrix transforming from site to
%                                  face coords (=sf');
%              d_RRC_RFC       --  the vector of misalignment errors
%
%           radarDef           --  structure representing the radar
%                                  definition
%              bandwidth
%              maximumPulsewidth
%              frequency
%              referenceRange
%              referenceRCS
%              referenceSNR
%              maxAngleOffBoresite
%              minimumElevation
%              beamWidthU
%              beamWidthV
%              BSR_R
%              BSR_U
%              BSR_V
%              monopulseK
%              rangeK
%                   
%           aligned  --  structure of when the radar was last aligned.
%                        Following fields are required:
%              year  --  year (e.g. 1988)
%              day   --  day  (day of year, integer, Jan 1 = 1),
%              UT    --  Universal Time = hours since midnight along 
%                        Greenwich Meridian; 0<=UT<=24, (1XN)
%
%           missionProfile    --  A structure representing the radar 
%                                 mission profile.  Requires the following
%                                 fields:
%              maxTimeIntrack   --  maximum time an object is allowed to 
%                                   stay in track
%              requestedSNR_dB  --  requested signal to noise ratio
%              dataRate         --  requested data rate
%
%           params              --  Radar specific parmaeters
%              
%           funs                --  A structure of function handles.
%                                   Contains the following fields
%              propagate_Exo                 --  An exoatmospheric filter
%                                                model
%              propagate_Booster             --  A boosting filter model
%              acceleration_gravity          --  Calculates the
%                                                acceleration due to
%                                                gravity.
%
%           object_kinds         --  A structure that contains the object
%                                    kinds used in discrimination
%              missile_oks       --  A vector of all the object kinds
%                                    associated with either a TBM or an
%                                    ICBM
%           radar_function       --  A structure that contains the radar
%                                    functions used in the simulation
%
%   Required Functions:
%        Form_site_constants
%        Read_Sap_File
%        LoadObjectKinds
%        LoadRadarFunctions
%        LoadMissionProfile
%

%Initialize the site specific parameters
radar.site = form_site_constants(init_data.radar_setup_loc, physical_constants);

%Initialize the radar specific parameters
radar.defaults = read_sap_file(init_data.radar_defaults_loc);

%Convert the angles in the radarDef from degrees to radians
radar.defaults.maxAngleOffBoresite = physical_constants.deg_to_rad * radar.defaults.maxAngleOffBoresite;
radar.defaults.minimumElevation = physical_constants.deg_to_rad * radar.defaults.minimumElevation;

radar.funs.propagate_Exo = @PropagateExoGroup;
radar.funs.propagate_Booster = @PropagateBoostGroup;

radar.funs.acceleration_gravity = @Acceleration;

radar.object_kinds = load_object_kinds;
radar.radar_function = load_radar_functions;

radar.aligned = load (fullfile(pwd,'Trajectory_Data','setup', 'ECI_ECR_aligned.mat'));

radar.mission_profile = load_mission_profile(init_data.mission_profile_loc);

radar.params = load_radar_params;

radar.beam_cmd.truth_indx = 1;
radar.beam_cmd.BW = 'MB';
radar.beam_cmd.chirp_sign = 1;