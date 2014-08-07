function site = form_site_constants(radar_setup_loc, physical_constants)
%     site = Form_site_constants(fName_radar_loc, constants)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Creates site constants structure.
%
%   Input:
%        fName_radar_loc   --  String that specifies the full path and file
%                              name of the text file containing the radar's
%                              location and orientation information
%
%        physical_constants  --  Structure that contains physical constants.
%                                Required fields:
%           f_earth     --  earth flattening coefficient
%           re          --  earth equatorial radius (m)
%
%   Output:
%        site -- structure of site specific parameters.  Contained fields:
%           radar_location  --  [ lat lon height ] (radians/ meters)
%           radar_attitude  --  [ az el clock ]  (radians)
%           omega_e_x       --  cross product matrix between earth rrc
%                               rotation vector and ...
%           twice_omega_e_x --  two times omega_e_x, done to eliminate
%                               repeated calculations in later functions
%           omega_e_x_sq    --  square of omega_e_x
%           r0_ecr          --  position vector from earth center to site
%                               in ecr
%           se              --  dir cosine matrix transforming from ECR to
%                               site(rrc) coords
%           es              --  dir cosine matrix transforming from site to
%                               ECR coords
%           r0_rrc          --  position vector from earth center to site
%                               in rrc
%           uP              --  unit vector along earth polar axis 'north
%                               up' in RRC
%           lat             --  lat (rad)
%           lon             --  lon (rad)
%           height          --  height (m)
%           az              --  az (rad)
%           el              --  el (rad)
%           clock           --  clock (rad)
%           sf              --  dir cosine matrix transforming from face to
%                               site coords
%           fs              --  dir cosine matrix transforming from site to
%                               face coords (=sf');
%           d_RRC_RFC       --  the vector of misalignment errors
%           T_ECR_RRC       --  ECR to RRC position transformation matrix
%                   
%   Required Functions:
%           Get_physical_constants
%           Gc_ecr
%           Add_radar_orientation

% Get any physical constants needed
if ~exist('physical_constants', 'var')
   physical_constants = Get_physical_constants;
end

%Read in the radar position and orientation
[radar_attitude, radar_location] = read_radar_setup(radar_setup_loc);

site.radar_attitude = radar_attitude;  %This is in radians
site.radar_location = radar_location;  %This is in radians, except the last term which is in meters (the altitude)

site.lat         = radar_location(1);  %This is in radians
site.lon         = radar_location(2);  %This is in radians
site.height      = radar_location(3);  %This is in meters

site.az          = radar_attitude(1);  %This is in radians
site.el          = radar_attitude(2);  %This is in radians
site.clock       = radar_attitude(3);  %This is in radians

% ADD DERIVED FIELDS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
cPhi                        =   cos(site.lat); 
sPhi                        =   sin(site.lat);

cLon                        =   cos(site.lon);
sLon                        =   sin(site.lon);

site.omega_e_x    =   physical_constants.earth_spin_rate * ...
   [  0      -sPhi   cPhi; ...
     sPhi     0.     0.;   ... 
    -cPhi     0.     0.   ];
%
site.twice_omega_e_x = 2 .* site.omega_e_x;

site.omega_e_x_sq    =   site.omega_e_x * site.omega_e_x;

site.r0_ecr       =   gc2ecr( site.lat, site.lon, site.height, physical_constants);

site.se           =  [   -sLon         cLon          0;     ...
                      -sPhi*cLon    -sPhi*sLon       cPhi;     ...
                       cPhi*cLon     cPhi*sLon       sPhi    ];

site.es           =   site.se';

site.r0_rrc       =   (site.se * site.r0_ecr);  %To make the stupid thing a column vector

site.up           =   (site.se * [0;0;1]);  %To make the stupid thing a column vector

site = add_radar_orientation(site); % Function to add sf and fs matrices as fields 'sf' and 'fs' to site

site.T_ECR_RRC    = get_T_ecr_rrc(site.lat, site.lon);
site.T_RRC_RFC = get_T_rrc_rfc(site.clock, site.az, site.el);

site.R_ECR_0=gc2ecr(site.lat,site.lon,site.height,physical_constants);
site.R_RRC_0=ecr2rrc(gc2ecr(site.lat,site.lon,site.height,physical_constants)+site.R_ECR_0, site.T_ECR_RRC, site.r0_ecr);
