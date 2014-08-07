function [Staging_Detected, staging_time] = Staging_Detection(map_saps, acc_thrust_mags, update_times)
%     [Staging_Detected, staging_time] = 
%          Staging_Detection(map_saps, acc_thrust_mags, update_times)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      This function performs staging detection.  It uses a vector of
%      thrust acceleration estimates, looking back in the vector, at a
%      specified number of vector indicies, to see if the estimate at this
%      index is basically larger than the current estimate.  The test is,
%      of course, a bit more complicated, but that's the general gist.
%
%   Input:
%        map_saps         -- 
%           map_tp_sap_6002  --  Value used to subtract off the past
%                                acceleration estimate, done before
%                                comparing to the current acceleration
%                                estimate
%           map_tp_sap_6003  --  The amount of time we look back to get an
%                                acceleration magnitude estimate for
%                                staging detection
%           map_tp_sap_6004  --  Minimum threshold, above which the current
%                                past acceleration estimate must be
%        acc_thrust_mags  --  A vector of thrust acceleration magnitudes
%        update_times     --  A vector of state vector update times
%
%   Output:
%        Staging_Detected  --  A flag that indicates if staging was
%                              detected.  If staging is not detected, this
%                              defaults to zero.
%        staging_time      --  Time at which staging was declared.  If
%                              staging is not declared, this defaults to
%                              zero.
%                   
%   Required Functions:
%

Map_Tp_Sap_6002 = map_saps.map_tp_sap_6002;
Map_Tp_Sap_6003 = map_saps.map_tp_sap_6003;
Map_Tp_Sap_6004 = map_saps.map_tp_sap_6004;

%Initialize some variables
Staging_Detected = 0;
staging_time     = 0.0;
past_index       = 0;

current_time = update_times(end);
nAcls        = length(acc_thrust_mags);

%Find the desired index in the past, then stop when we do
for i = nAcls:-1:1
   if (current_time  - update_times(i) >= Map_Tp_Sap_6003)
      %keep this index
      past_index = i;
      break;
   end
end %looping over acceleration vector

%Never did find that index, so exit
if ( past_index == 0 )
   return
end

acc_past_thrust             = acc_thrust_mags(past_index);
acc_current_thrust          = acc_thrust_mags(end);

accel_past_test = acc_past_thrust > Map_Tp_Sap_6004;
accel_cur_test  = acc_current_thrust < max(acc_past_thrust  - Map_Tp_Sap_6002, 0);

accel_cur_test_new = true;

if ( accel_past_test && accel_cur_test ) && accel_cur_test_new
   Staging_Detected = 1;
   staging_time     = current_time;
end

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
