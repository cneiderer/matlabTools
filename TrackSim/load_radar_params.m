function params = load_radar_params
%
%     params = LoadRadarParams
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%
%   Input:
%        none
%
%   Output:
%        params     --  structure of radar parameters.  Required fields:
%           i_WB
%           i_MB
%           i_NB
%           scan_loss_exp
%           atmospheric_absorption_table  --  
%           pulse                         --  pulse code table 
%                                             [pulse width (s) range window
%                                             (m) unknown(s)]
%           K_radar                       --  radar gain constant
%           A_receive
%           T_effective
%           L_coh_int
%           L_atm_km
%           L_range_wts
%
%   Required Functions:
%        none
%

params.i_WB = 3;
params.i_MB = 2;
params.i_NB = 1;

%The exponent used for calculating the scan loss
params.scan_loss_exp = [2 2.5 3.6];

params.atmospheric_absorption_table = ...
   [ 0.0  0.5  1.0  2.0  5.0  10.0  15.0; ...
     6.6  5.0  3.9  2.6  1.3   0.65  0.5];
%

%Set up the radar pulse width code tables
% Pulse Width (sec)	Range Window (m)	Range Window (sec)
params.pulse = ...
   [6.187975E-02	17400000.000	   1.236395E-01;
    3.093988E-02	 8700000.000	   6.181975E-02;
    1.546994E-02	 4350000.000	   3.090988E-02;
    7.734969E-03	 2175000.000	   1.545494E-02;
    3.867484E-03	 1087500.000	   7.727469E-03;
    1.933742E-03	  543750.000	   3.863734E-03;
    9.668711E-04	  271875.000	   1.931867E-03;
    4.834355E-04	  135937.500	   9.659336E-04;
    2.417178E-04	   67968.750	   4.829668E-04;
    1.208589E-04	   33984.375	   2.414834E-04;
    6.042944E-05	   16992.188	   1.207417E-04];
%

%Set the radar gain constant
params.K_radar = Set_radar_gain;

%Set some more radar constants
params.A_receive   = 9.26;
params.T_effective = 469.0;
params.L_coh_int   = 1.0;
params.L_atm_km    = 0.5/1118;
params.L_range_wts = 1.2;

%------------------------------------------------------------------------  
% Initialize various factors
%------------------------------------------------------------------------    
params.PRI           = 0.2; % The data rate, in seconds
params.alpha         = 1e4;
params.alpha_cue     = 1e4;
params.beta          = 1.0;
params.beta_cue      = 1.0;
params.alpha_tropo   = 1.0;
params.beam_test     = Inf;
params.tropo_factor  = 0.00;
params.RCS_dBsm_mean = 0;
params.RCS_dBsm_std  = 3;
params.RDC_factor_MB = 1e4;
params.RDC_factor_WB = 1e1;
params.SNR_thresh    = -Inf; %9.5;
params.SNR_track     = 20.0;
params.SNR_cue       = 20.0;
params.option_init   = 'split';  % cue, SRS, new, split

% Surface Refractivity - nominal
params.N_s=313;

params.L_range_wts=1.2;

params.alpha_init=25;
params.alpha_Q8=0.2;%3/19: PRI/10 is good;%was 50*PRI; changed 3/7/03
params.alpha_Q10=0.2;%was 50*PRI; changed 3/7/03
params.alpha_P0=200;
params.max_alpha=200; % maximum allowed thrust acceleration magnitude  %%%%%%%%%%%%%%
%max_alpha=20000;    % maximum allowed thrust acceleration magnitude  %%%%%%%%%%%%%%


params.beta_init=0.01;
params.beta_Q8=0.00002;%3/19: 0.001*PRI/10 is good; %was 0.01*PRI; changed 3/7/03
params.beta_Q10=0.00002;%was 0.001*PRI; changed 3/7/03
params.beta_P0=0.0001;
params.max_beta=2.0;        % maximum allowed beta                %%%%%%%%%%%%%%%%%%%%%%%
params.min_beta=0.005;      % minimum allowed beta                %%%%%%%%%%%%%%%%%%%%%%%

params.thetai_init=0; %initial state
params.thetai_Q=0.01; % process noise.  Now PRI dependent!
params.thetai_P0=0.01; % initial covariance
params.tau_i=50; % time constant for theta_i, theta_c

params.thetac_init=0;
params.thetac_Q=0.01;
params.thetac_P0=0.01;
params.tau_c=50;

params.f8b_process_noise_y7=params.alpha_Q8;
params.f8b_process_noise_y8=params.beta_Q8;
params.f8b_y7_max=params.max_alpha;
params.f8b_y8_max=params.max_beta;
params.f8b_y8_min=params.min_beta;
params.chi_threshold8b=Inf; % this is a threshold for return to track assoc.  Disabled.

params.f10b_process_noise_y7=params.thetai_Q;
params.f10b_process_noise_y8=params.thetac_Q;
params.f10b_process_noise_y9=params.alpha_Q10;
params.f10b_process_noise_y10=params.beta_Q10;
params.f10b_y9_max=params.max_alpha;
params.f10b_y10_max=params.max_beta;
params.f10b_y10_min=params.min_beta;
params.chi_threshold10b=Inf; % this is a threshold for return to track assoc.  Disabled.

params.max_vel_mag=10000;

params.p6 = 1/3;
params.p8b = 1/3;
params.p10b = 1/3;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     



function K_radar = Set_radar_gain

% Set the radar gain constant

x1       = 7.7429e27 * [1    10^(-0.8/10)    10^(-0.8/10)];
x2       = 1.125205 + 0.0607 + 0.3;
K_radar1 = 10^x2 * x1;

vec1 = [3.98   3    2.89    2.36    0.83   1     2.6];
vec2 = [-1     0    0       0       0      0.5   1];

sf  = 0.1 * ( -9 + 21.72 - sum( vec2 .* vec1 ) );
sf  = 10^sf;

K_radar = sf * K_radar1; % EMD
% Coherent gain multiplied by -1 to turn on.


return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
