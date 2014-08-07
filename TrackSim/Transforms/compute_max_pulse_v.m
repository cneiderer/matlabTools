function [i_tau,tau_round,tau_unround,tau_eclipsed]=compute_max_pulse_v(SNR,RCS,range,BW,loss,params,constants)
%
% Computes pulse index and rounded pulse width for the waveform set defined
% in the pulse array.  Maintains computed SNR > desired SNR within
% pulse self-eclipsing constraint. This routine is vectorized!!!
%
%	Inputs:		SNR			==	minimum desired signal-to-noise ratio, 1XN (linear)
%					RCS			==	radar cross-section, 1XN (linear)
%					range			==	range to target, 1XN (m)
%					BW 	 		==	LFM bandwidth code 
%					loss			==	total beam/scan loss, 1XN (linear)
%
%	Outputs:		i_tau			==	pulse index - 1, 1XN
%					tau_round	==	rounded pulse width, 1XN (sec)
%					tau_unround	==	unrounded pulse width, 1XN (sec)
%

T_switch  = 1e-6;
T_clutter = 1e-6;

pulse = params.pulse;
speed_of_light = constants.physical_constants.c;

[m_pulse,n_pulse]=size(pulse);

K_sens=get_sens(BW,params);

tau_unround=SNR.*range.^4./(K_sens.*RCS.*max(1e-10,loss));
i_tau_unround=max(min(-floor(log10(tau_unround/pulse(1,1))/log10(pulse(1,1)/pulse(2,1))),m_pulse-1),0);
tau_eclipsed=2*range/speed_of_light-T_switch-T_clutter;
tau_eclipsed=2*range/speed_of_light-T_switch-T_clutter;
i_tau=max(min(-floor(log10(tau_eclipsed./pulse(1,1))/log10(pulse(1,1)/pulse(2,1))),m_pulse-1),0);
tau_round=((pulse(1,1)/pulse(2,1)).^(-i_tau))*pulse(1,1);
i_tau=i_tau+1;

