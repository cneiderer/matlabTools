function [SNR_dB_out, pulseWidth, i_tau] = compute_SNR( RCS, RRC, desSNR_dB, BW, radar, constants)
%
%     [SNR_dB_out, pulseWidth, i_tau] = ComputeSNR( RCS, RRC, desSNR_dB, BW, radar, constants)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Compute the signal to noise ratio of the simulated detection.
%      Assumes 3 dB pulsewidth steps.
%
%   Input:
%        RCS          --  object radar cross-section (linear), (1XN)
%        RRC          --  RRC state vector, (3xN), N is the number of time
%                         samples
%        desSNR_dB    --  desired SNR (dB), (1XN)
%        BW           --  LFM bandwidth code ('MB', 'WB', or 'NB')
%        radar
%           radarDef
%              referenceSNR
%              referenceRCS
%              referenceRange
%              maximumPulsewidth
%           params
%              L_range_wts
%        constants
%           c         -- the speed of light
%
%   Output:
%        SNR_dB_out    --  the signal to noise ratio, in dB
%        pulseWidth  --  
%        i_tau
%
%   Required Functions:
%        Compute_max_pulse
%        Get_sens
%

%   L_atmos       --  atmospheric loss (From Skolnik/Blake Ns - 313),
%                     linear, 1xN  (deleted)
%   L_dispersion  --  dispersion loss, linear, 1xN

radarDef = radar.defaults;
params   = radar.params;

L_range_wts                  = params.L_range_wts;

%************************************************************************
%
%        Convert to RAE and calculate scan loss and L_atmos for N=313;
%
c    = constants.physical_constants.c;

T_RRC_RFC = radar.site.fs;
d_RRC_RFC = radar.site.d_RRC_RFC;

%Ensure we keep only the RRC position information
RRC     = RRC(1:3,:);
RFC_pos = T_RRC_RFC * RRC;
RAE_pos = rrc2rae(RRC);
RUV_pos = rrc2ruv(RRC, T_RRC_RFC, d_RRC_RFC);

rng  = RAE_pos(1,:);

L_disp_t1  = 2 * ( 400e6 * 0.39 / ( c * 0.886) )^2;
w          = sqrt( 1 - RUV_pos(2,:).^2 - RUV_pos(3,:).^2 );
L_disp_den = 1 + L_disp_t1 .* sin( acos(w) ) ;

L_dispersion = 1 ./ L_disp_den;  %Linear
L_scan       = scan_loss(RFC_pos, BW, params); %Linear

%
%************************************************************************
%
%        Compute pulse width and SNR achieved
%
snr  = 10.^(desSNR_dB/10);
loss = L_dispersion .* L_scan .* 10.^( -1 * L_range_wts / 10 );  %linear

[i_tau, tau_round, tau_unround, tau_eclipsed] = ...
   compute_max_pulse( snr, RCS, rng, BW, loss, constants, params);

SNR_dB_out = 10*log10( ( get_sens(BW, params) * ( RCS .* tau_round) ).*...
   (L_dispersion .* L_scan) ./ rng.^4 ) - L_range_wts;

pulseWidth = tau_round;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
