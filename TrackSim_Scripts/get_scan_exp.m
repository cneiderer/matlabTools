function exp_scan = get_scan_exp(BW, params)
%
%     exp_scan = Get_scan_exp(BW, params)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Gets the scan loss exponent for the specified LFM bandwidth code.
%
%   Input:
%        BW         --  LFM bandwidth code (string)
%        params     --  structure of radar parameters.  Required fields:
%           i_WB
%           i_MB
%           i_NB
%           scan_loss_exp
%
%   Output:
%        exp_scan   --  scan loss exponent
%
%   Required Functions:
%        none
%

i_WB          = params.i_WB;
i_MB          = params.i_MB;
i_NB          = params.i_NB;
scan_loss_exp = params.scan_loss_exp;

if strcmpi(BW, 'WB')
   exp_scan = scan_loss_exp(i_WB);
elseif strcmpi(BW, 'MB')
   exp_scan = scan_loss_exp(i_MB);
elseif strcmpi(BW, 'NB')
   exp_scan = scan_loss_exp(i_NB);
else
   exp_scan = scan_loss_exp(i_NB);
end

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
