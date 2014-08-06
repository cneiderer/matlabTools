function [SNR_dB_out,tau_round,i_tau,L_scan,L_atmos,L_dispersion] = compute_SNR_v(RRC,RCS,BW,SNR_dB_in,radar,constants)
%
%   function [SNR_dB_out,tau_round,i_tau,L_scan,L_atmos,L_dispersion] = ...
%compute_SNR_v(RRC,RCS,BW,SNR_dB_in);
%
%	Inputs:	RRC	==	object state vector in RRC (m), (3XN)
%				RCS	==  	object radar cross-section (linear), (1XN)
%				BW  	==  	LFM bandwidth code (string)
%				SNR_dB_in 	==	desired SNR (dB), (1XN)
%
%	Outputs:	SNR_dB_out  ==	signal-to-noise ratio (dB), (1XN);
%				tau_round	==	rounded pulse width (sec), (1XN);
%				i_tau		   ==	pulse index - 1, 1XN
%           L_scan  ==  scan loss, linear, 1XN
%           L_atmos ==  atmospheric loss (From Skolnik/Blake Ns=313), linear, 1XN
%           L_dispersion ==  atmospheric loss (From Skolnik/Blake Ns=313), linear, 1XN
%

%************************************************************************
%
%        Set Constants
%
%
%************************************************************************
%
%        Convert to RAE and calculate scan loss and L_atmos for N=313;
%
RFC_pos=radar.site.T_RRC_RFC*RRC(1:3,:);
RAE_pos=rrc2rae(RRC);
RUV_pos=rrc2ruv(RRC,radar.site.fs, radar.site.d_RRC_RFC);
L_dispersion=1./(1+2*((400e6*0.39/(constants.physical_constants.c*0.886))^2).*...
   (sin(acos(sqrt(1-RUV_pos(2,:).^2-RUV_pos(3,:)))).^2));
%L_atmos=interp1(atmospheric_absorption_table(1,:),...
%atmospheric_absorption_table(2,:),RAE_pos(3,:));
L_atmos=interp1(constants.atmospheric_absorption_table(1,:),...
   constants.atmospheric_absorption_table(2,:),RAE_pos(3,:),'spline');
S_T=sin((pi/180)*RAE_pos(3,:));
L_scan=(scan_loss(RRC,BW,radar.params)).^2;
%
%************************************************************************
%
%        Compute pulse width and SNR achieved
%
[i_tau,tau_round,tau_unround,tau_eclipsed]=...
   compute_max_pulse_v(10.^(SNR_dB_in/10),RCS,RAE_pos(1,:),BW,...
   L_dispersion.*L_scan.*10.^(-1*(radar.params.L_range_wts+L_atmos)/10),radar.params,constants);
SNR_dB_out=10*log10((get_sens(BW,radar.params)*(RCS.*tau_round)).*...
   (L_dispersion.*L_scan)./((RAE_pos(1,:)).^4))-L_atmos-radar.params.L_range_wts;
%
%************************************************************************
