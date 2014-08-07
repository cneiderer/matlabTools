function [i_tau, tau_round, tau_unround, tau_eclipsed] = ...
   compute_max_pulse(SNR, RCS, range, BW, loss, constants, params)
%
% [i_tau, tau_round, tau_unround, tau_eclipsed] = ...
%            Compute_max_pulse(SNR, RCS, range, BW, loss, constants, params)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Computes pulse index and rounded pulse width for the waveform set
%      defined in the pulse array.  Maintains computed SNR > desired SNR
%      within pulse self-eclipsing constraint. This routine is vectorized.
%
%   Input:
%        SNR        --  minimum desired signal-to-noise ratio, 1XN (linear)
%        RCS        --  radar cross-section, 1XN (linear)
%        range      --  range to target, 1XN (m)
%        BW         --  LFM bandwidth code ('MB', 'WB', or 'NB')
%        loss       --  total beam/scan loss, 1XN (linear)
%        constants  --  
%           c       --  the speed of light
%        params     --  structure of radar parameters.  Required fields:
%           i_WB
%           i_MB
%           i_NB
%           pulse
%           K_radar
%
%   Output:
%        i_tau         --  pulse index - 1, 1XN
%        tau_round     --  rounded pulse width, 1XN (sec)
%        tau_unround   --  unrounded pulse width, 1XN (sec)
%        tau_eclipsed  --  eclipsed pulse width, 1XN (sec)
%
%   Required Functions:
%        Get_sens
%

T_switch  = 1e-6;
T_clutter = 1e-6;

c     = constants.physical_constants.c;
pulse = params.pulse;

pw1  = pulse(1,1); %The first pulse width, in seconds
pw2  = pulse(2,1); %The second pulse width, in seconds


%ensure that the total beam/scan loss is at least 1e-10
loss = max(1e-10, loss);

[n_pulses, n_cols] = size(pulse);

K_sens = get_sens(BW, params);

%Calculate the unrounded pulse width
tau_unround   = SNR .* range.^4 ./ (K_sens .* RCS .* loss);

%Calculate the pulse index
logTerm1 = log10( tau_unround / pw1 );
logTerm2 = log10( pw1 / pw2 );
i_tau_unround = -floor( logTerm1 / logTerm2 );

%Ensure that the pulse index is not larger than the number of pulses we
%have in our table
i_tau_unround = min( i_tau_unround, n_pulses - 1 );

%Ensure that the index is not negative
i_tau_unround = max( i_tau_unround, 0 );

%Calculate the eclipsed pulse width
tau_eclipsed  = 2*range/c - T_switch - T_clutter;

%Calculate the pulse index
logTerm1 = log10( tau_eclipsed ./ pw1 );
i_tau    = -floor( logTerm1 / logTerm2 );

%Ensure that the pulse index is not larger than the number of pulses we
%have in our table
i_tau = min( i_tau, n_pulses - 1 );

%Ensure that the index is not negative
i_tau = max( i_tau, 0 );

%Calculate the rounded pulse width
tau_round     = ( (pw1/pw2).^(-i_tau) ) * pw1;

%Put final adjustment to pulse index
i_tau         = i_tau + 1;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
