function  ruv = get_measurements( ruvIn, ruv_var, pulse, i_tau, chirp_sign, radarDef )
%
%     ruv = GetMeasurements( ruvIn, ruv_var, pulse, i_tau, chirp_sign, radarDef )
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculates the simulated measurement, including the effects of range
%      doppler coupling
%
%   Input:
%        ruvIn         --  The true object position and velocity,
%                                  in RUV(6xN)
%        ruv_var               --  the RUV variance. (3xN)
%        pulse
%        i_tau
%        chirp_sign    --  The sign used for the chirp pulse, +1 for up
%                          chirp, -1 for down chirp
%        radarDef
%           frequency
%           bandwidth
%
%   Output:
%        ruv    --  The measurement in R, U, V (3xN)
%
%   Required Functions:
%        CheckDimensions (subfunction)
%

rdc_factor = radarDef.frequency / radarDef.bandwidth;

% noise added here
noise      = randn( size(ruvIn(1:3)) );
RUV_no_RDC = ruvIn(1:3) + sqrt(ruv_var) .* noise; 

rdcTerm    = chirp_sign .* [ruvIn(4)*pulse(i_tau,1)*rdc_factor; 0; 0];

% rdcTerm = zeros(3,1);

ruv        = RUV_no_RDC + rdcTerm;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
