function constants = get_physical_constants
%   UNCLASSIFIED
%
%   DESCRIPTION
%       Returns physical constants
%
%   Input:
%        None
%
%   Output:
%        constants -- structure with the following fields
%           j1                   --  First Earth Zonal Harmonic
%           j2                   --  Second Earth Zonal Harmonic
%           j3                   --  Third Earth Zonal Harmonic
%           j4                   --  Fourth Earth Zonal Harmonic
%           j5                   --  Fifth Earth Zonal Harmonic
%           mu_e                 --  Earth gravitational parameter (m^3/s^2)
%           earth_spin_rate      --  Earth rotation rate (rad/s)
%           re                   --  Earth equatorial radius (m)
%           re_sq                --  Earth equatorial radius squared (m^2)
%           rp                   --  Earth polar radius (m)
%           rp_sq                --  Earth polar radius squared (m^2)
%           k                    --  re_sq / rp_sq - 1;
%           c                    --  Speed of light in a vaccuum
%           c_over_2             --  Speed of light in a vaccuum, divided
%                                    by two
%           f_earth              --  Earth_Flattening Coefficient
%           deg_to_rad           --  degrees to radians conversion factor
%           rad_to_deg           --  radians to degrees conversion factor
%           meters_per_ft        --  meters per foot
%           ft_per_statute_mile  --  feet per statute mile
%           m_per_nautical_mile  --  meters per nautical mile
%           gravity              --  standard gravity (m/sec^2)
%           a_earth              --  earth orbit semi-major axis
%           e_s_earth            --  earth orbit eccentricity
%           E_s_earth            --  obliquity of ecliptic
%           k_Boltzmann          --  Boltzmann's constant
%           R_mean               --  mean earth radius (m)
%           e_earth              --  earth eccentricity
%           sin_E_s              --  sine of ecliptic obliquity
%           cos_E_s              --  cosine of ecliptic obliquity
%           omega_e_X_EC         --  earth rotation rate cross product
%                                    matrix
%           omega_e_X2_EC        --  square of the earth rotation rate 
%                                    cross product matrix


constants.j1                    =   0.0;  % 1st zonal harmonic
constants.j2                    =   0.10826299890519e-2;
constants.j3                    =  -0.25321530681976e-5;  % 3rd zonal harmonic
constants.j4                    =  -0.161098761e-5;  % 4th zonal harmonic
constants.j5                    =  -0.23578564879393e-6;  % 5th zonal harmonic
constants.mu_e                  =   3.986005e14;
constants.earth_spin_rate       =   7.2921151e-5;
constants.re                    =   6378137.0;

constants.re_sq                 =   constants.re^2;  % equatorial radius and square of equatorial radius
constants.rp                    =   6356752.3;
constants.rp_sq                 =   constants.rp^2;

constants.k                     =   constants.re_sq / constants.rp_sq - 1;
constants.c                     =   299792458; % m/s in vaccuum
constants.c_over_2              =   constants.c / 2; % m/s in vaccuum
constants.f_earth               =   ( constants.re - constants.rp ) / constants.re; % Earth_Flattening Coefficient
constants.deg_to_rad            =   pi / 180.0;
constants.rad_to_deg            =   180.0 / pi;

constants.meters_per_ft         =   0.3048; %m/ft
constants.ft_per_statute_mile   =   5280.0; %ft/stat-mi
constants.m_per_nautical_mile   =   1852.0; %m/naut-mi

constants.gravity         =  9.80665;			% standard gravity (m/sec^2)
constants.a_earth         =  1.495998e11;		% earth orbit semi-major axis
constants.e_s_earth       =  0.01670021;		% earth orbit eccentricity
constants.E_s_earth       =  0.409047;			% obliquity of ecliptic

constants.k_Boltzmann     =  1.38e-23;		% Boltzmann's constant

constants.R_mean          = ( constants.re_sq* constants.rp)^(1/3);		% mean earth radius (m)
constants.e_earth         = sqrt(2* constants.f_earth- constants.f_earth^2);	% earth eccentricity
constants.sin_E_s         = sin( constants.E_s_earth);		% sine of ecliptic obliquity
constants.cos_E_s         = cos( constants.E_s_earth);		% cosine of ecliptic obliquity

constants.omega_e_X_EC    = constants.earth_spin_rate*[0 -1 0;1 0 0;0 0 0];
constants.omega_e_X2_EC   = constants.omega_e_X_EC^2;
