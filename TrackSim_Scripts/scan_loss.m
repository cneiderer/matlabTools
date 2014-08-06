function L_scan = scan_loss(RFC, BW, params)
%
%     L_scan = Scan_loss(RFC, BW, params)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculate the scan loss.
%
%   Input:
%        RFC     --  object state vector in RFC, (3XN)
%        BW      --  LFM bandwidth, string (e.g., 'MB')
%        params  --  structure of radar parameters.  Required fields:
%           i_WB
%           i_MB
%           i_NB
%           scan_loss_exp
%
%   Output:
%        L_scan  --  one-way scan loss (assuming exponents are one-way),
%                    linear (1xN)
%
%   Required Functions:
%        Get_scan_exp
%        Compute_range
%

RFC_pos  = RFC(1:3,:);

exp_scan = get_scan_exp(BW, params);

L_scan   = max( 1e-10, RFC_pos(3,:) ./ compute_range(RFC_pos) ).^(2*exp_scan);

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
