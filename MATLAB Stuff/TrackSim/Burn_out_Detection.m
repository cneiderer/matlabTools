function [burn_out_flag, interstage_flag] = ...
   Burn_out_Detection(interstage_flag, alpha, alpha_var, saps)
%     [burn_out_flag, interstage_flag] = ...
%               Burn_out_Detection(interstage_flag, alpha, alpha_var, saps)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Performs burn-out detection using a chi square test on the
%      magnitudes of the thrust accelerations.
%
%   Input:
%        interstage_flag  --  A flag that represents the period between
%                             boosting and the next stage.
%        alpha            --  A vector of the magnitudes of the thrust
%                             accelerations (Nx1)
%        alpha_var        --  A vector of the variances of magnitudes of
%                             the thrust accelerations (Nx1)
%        saps             --  A structure of system adjustable parameters
%           map_tp_sap_6007  --  Threshold for declaring burn-out
%           map_tp_sap_6046  --  Threshold for declaring end of interstage
%                                period and restart of boosting
%
%   Output:
%        burn_out_flag    --  A flag that indicates burn-out, i.e. that the
%                             missile is done boosting
%        interstage_flag  --  A flag that represents the period between
%                             boosting and the next stage.
%
%   Required Functions:
%        none
%

try
   map_tp_sap_6007 = saps.map_tp_sap_6007;
catch
   error('Burn_out_Detection: map_tp_sap_6007 not defined in this function.');
end

try
   map_tp_sap_6046 = saps.map_tp_sap_6046;
catch
   error('Burn_out_Detection: map_tp_sap_6046 not defined in this function.');
end


%Calculate the chi square value; assumes the input is column vectors
tmp = ( alpha.^2 ) ./ alpha_var;
x2  = sum(tmp, 1);

burn_out_flag   = ( x2 < map_tp_sap_6007 );

tmp = ~burn_out_flag;

%Set the interstage flag to false for those instances where burn-out has
%not occurred
interstage_flag( tmp ) = ~( x2(tmp) > map_tp_sap_6046 );

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
