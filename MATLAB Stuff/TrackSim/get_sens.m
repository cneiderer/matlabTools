function K_sens = get_sens(BW, params)
%
% K_sens = Get_sens(BW)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Gets the radar sensitivity for the specified LFM bandwidth code.
%
%   Input:
%        BW         --  LFM bandwidth code ('MB', 'WB', or 'NB')
%        params     --  structure of radar parameters.  Required fields:
%           i_WB
%           i_MB
%           i_NB
%           K_radar
%
%   Output:
%        K_sens     --  radar sensitivity constant (non-dim)
%        
%
%   Required Functions:
%        none
%

K_radar = params.K_radar;

if strcmpi(BW, 'WB')
   K_sens = K_radar(params.i_WB);
elseif strcmpi(BW, 'MB')
   K_sens = K_radar(params.i_MB);
elseif strcmpi(BW, 'NB')
   K_sens = K_radar(params.i_NB);
else
   K_sens = K_radar(params.i_NB);
end

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
