function L_scan=scan_loss(RRC,BW);
%
%	Inputs:		RRC			==	object state vector in RRC, 3XN
%				BW			==	LFM bandwidth, string (e.g., 'MB')
%
%	Outputs:	L_scan		==	one-way scan loss (assuming exponents are one-way), 1XN (linear);
%

global T_RRC_RFC;

RFC_pos=T_RRC_RFC*RRC(1:3,:);
L_scan=max(1e-10,(RFC_pos(3,:)./compute_range(RFC_pos))).^get_scan_exp(BW);
