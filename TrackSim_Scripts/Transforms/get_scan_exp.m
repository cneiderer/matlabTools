function exp_scan=get_scan_exp(BW);
%
% Gets the scan loss exponent for the specified LFM bandwidth code.
%
%	Inputs:		BW		== LFM bandwidth code (string)
%
%	Outputs:	exp_scan	== scan loss exponent

global i_WB i_MB i_NB scan_loss_exp;

if (BW=='WB')
	exp_scan=scan_loss_exp(i_WB);
elseif (BW=='MB')
	exp_scan=scan_loss_exp(i_MB);
elseif (BW=='NB')
	exp_scan=scan_loss_exp(i_NB);
else
	exp_scan=scan_loss_exp(i_NB);
end;
