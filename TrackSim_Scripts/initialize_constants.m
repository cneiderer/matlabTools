function constants = initialize_constants(init_data)
%   UNCLASSIFIED
%
%   DESCRIPTION
%       Initializes the constants for the simluation%
%
%   Input:
%       Initilization data from the gui
%
%   Output:
%        constants -- structure with the following fields
%           physical_constants  --  A structure of physical constants.
%              j1                   --  First Earth Zonal Harmonic
%              j2                   --  Second Earth Zonal Harmonic
%              j3                   --  Third Earth Zonal Harmonic
%              j4                   --  Fourth Earth Zonal Harmonic
%              j5                   --  Fifth Earth Zonal Harmonic
%              mu_e                 --  Earth gravitational parameter (m^3/s^2)
%              earth_spin_rate      --  Earth rotation rate (rad/s)
%              re                   --  Earth equatorial radius (m)
%              re_sq                --  Earth equatorial radius squared (m^2)
%              rp                   --  Earth polar radius (m)
%              rp_sq                --  Earth polar radius squared (m^2)
%              k                    --  re_sq / rp_sq - 1;
%              c                    --  Speed of light in a vaccuum
%              c_over_2             --  Speed of light in a vaccuum,
%                                       divided by two
%              f_earth              --  Earth_Flattening Coefficient
%              deg_to_rad           --  degrees to radians conversion factor
%              rad_to_deg           --  radians to degrees conversion factor
%              meters_per_ft        --  meters per foot
%              ft_per_statute_mile  --  feet per statute mile
%              m_per_nautical_mile  --  meters per nautical mile
%              gravity              --  standard gravity (m/sec^2)
%              a_earth              --  earth orbit semi-major axis
%              e_s_earth            --  earth orbit eccentricity
%              E_s_earth            --  obliquity of ecliptic
%              k_Boltzmann          --  Boltzmann's constant
%              R_mean               --  mean earth radius (m)
%              e_earth              --  earth eccentricity
%              sin_E_s              --  sine of ecliptic obliquity
%              cos_E_s              --  cosine of ecliptic obliquity
%              omega_e_X_EC         --  earth rotation rate cross product
%                                       matrix
%              omega_e_X2_EC        --  square of the earth rotation rate 
%                                       cross product matrix
%                   
%           map_saps            --  A structure of the map saps.
%
%           sys_saps            --  A structure of the system saps.
%
%           atmos_table         --  A structure of the modeled atmosphere.
%                                   Taken from the standard atmosphere
%                                   table.
%              base_density   --  in kg/m^3
%              base_altitude  --  in meters
%              scale_height   --  in meters
%              exponent       --  unitless
%                   
%           endo                --  A structure of endo constants.
%                                   Populated by the "get_endo_constants"
%                                   function.
%              h0          --  Alpha profile upper reference height
%              h1          --  Alpha profile lower reference height
%              beta0       --  
%              beta1       --  
%              beta_mid    --  The midpoint between beta0 and beta1
%              h_mid       --  The midpoint between h0 and h1
%              del_height  --  (h1 - h0) / 2
%              del_beta    --  (beta1 - beta0) / 2
%              beta_k1     --  Nominal ballistic coefficient for heights
%                              greater than alpha profile upper reference
%                              height
%              beta_k2     --  
%              beta_k3     --  
%
%           GMST_k           --  Greenwich Mean Sidereal Time Parameters
%           cr2              --  flag that determines which burnout
%                                controller we use
%           base_num_states  --  the maximum number of states used in a
%                                filter in this simulation

constants.physical_constants = get_physical_constants;

constants.map_saps = read_sap_file(init_data.map_saps_loc);

constants.sys_saps = read_sap_file(init_data.sys_saps_loc);

constants.atmos_table = get_atmos_table;

constants.endo = get_endo_constants(constants.sys_saps, constants.map_saps);

constants.GMST_k = GMST_parameters;

constants.cr2 = true;

constants.base_num_states = 10;

constants.atmospheric_absorption_table=[0 0.5 1.0 2.0 5.0 10.0 15.0;6.6 5.0 3.9 2.6 1.3 0.65 0.5];
