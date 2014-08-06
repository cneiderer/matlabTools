function updated_group = Burnout_Controller(updated_group, constants, radar)
%     updated_group] =
%             Burnout_Controller(updated_group, constants, radar)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      This controls the burn-out detection algorithm for the 10 state
%      filter (and also, by extension, performs staging detection).
%
%   Input:
%        updated_group    --  
%           cov_rrc       --  
%           n_up          --  
%           pos_rrc       --  
%           vel_rrc       --  
%           acceleration  --  
%           init_time     --  
%           time          --  
%           staging_struct   --  
%              acc_thrust_mags   --  
%              alpha_vars        --  
%              burn_out_flag     --  
%              interstage_flag   --  
%              stage_altitude    --  
%              stage_count       --  
%              staging_flag_vec  --  
%              staging_time_vec  --  
%              t_burn_out        --  
%              update_times      --  
%
%        constants        --  A structure of various constants.  Required
%                             fields:
%           map_saps      --  
%              map_tp_sap_6000  --  Time constraint if staging has been
%                                   detected
%              map_tp_sap_6001  --  Time constraint if staging has not been
%                                   detected
%              map_tp_sap_6002  --  Value used to subtract off the past
%                                   acceleration estimate, done before
%                                   comparing to the current acceleration
%                                   estimate
%              map_tp_sap_6003  --  The amount of time we look back to get 
%                                   an acceleration magnitude estimate for
%                                   staging detection
%              map_tp_sap_6004  --  Minimum threshold, above which the 
%                                   current past acceleration estimate 
%                                   must be
%              map_tp_sap_6005  --  Constraint on the number of updates, if
%                                   staging has not been detected
%              map_tp_sap_6006  --  
%              map_tp_sap_6007  --  Threshold for declaring burn-out
%              map_tp_sap_6008  --  
%              map_tp_sap_6046  --  Threshold for declaring end of 
%                                   interstage period and restart of
%                                   boosting
%              map_tp_sap_6060  --  Reset value of theta i after staging is
%                                   detected
%              map_tp_sap_6061  --  Reset value of theta c after staging is
%                                   detected
%              map_tp_sap_6062  --  Reset value of the thrust acceleration
%                                   magnitude after staging is detected
%              map_tp_sap_6063  --  Reset value of the specific impulse
%                                   after staging is detected
%              map_tp_sap_6064  --  Reset value of the variance of theta i
%                                   after staging is detected
%              map_tp_sap_6065  --  Reset value of the variance of theta c
%                                   after staging is detected
%              map_tp_sap_6066  --  Reset value of the variance of the
%                                   thrust acceleration magnitude after
%                                   staging is detected
%              map_tp_sap_6067  --  Reset value of the variance of the
%                                   specific impulse after staging is
%                                   detected
%           cr2   --  A flag that indicates we are using capability release
%                     2 or higher.
%           physical_constants
%              re  --  
%              rp  --  
%
%        radar
%           site  --  
%              es  --  
%
%   Output:
%        updated_group    --  
%           pos_rrc       --  
%           vel_rrc       --  
%           acceleration  --  
%           cov_rrc       --  
%           staging_struct   --  
%              update_times      --  
%              acc_thrust_mags   --  A vector of the magnitudes of the thrust
%                                    accelerations (Nx1)
%              alpha_vars        --  A vector of the variances of magnitudes 
%                                    of the thrust accelerations (Nx1)
%              t_burn_out        --  
%              interstage_flag   --  A flag that represents the period between
%                                    boosting and the next stage.
%              burn_out_flag     --  A flag that indicates burn-out, i.e. that
%                                    the missile is done boosting
%              stage_altitude    --  
%              staging_flag_vec  --  
%              staging_time_vec  --  
%              stage_count       --  
%                   
%   Required Functions:
%        Burn_out_Detection
%        Staging_Detection
%        Calc_ht
%


%Pull off the important inputs

%SAP values
map_tp_sap_6000    = constants.map_saps.map_tp_sap_6000;
map_tp_sap_6001    = constants.map_saps.map_tp_sap_6001;
map_tp_sap_6005    = constants.map_saps.map_tp_sap_6005;
map_tp_sap_6006    = constants.map_saps.map_tp_sap_6006;
map_tp_sap_6008    = constants.map_saps.map_tp_sap_6008;

%Some Control flags
cr2                = constants.cr2;

%Get the number of updates
cov_rrc            = updated_group.cov_rrc;
n_up               = updated_group.n_up;
sv_rrc             = [updated_group.pos_rrc; updated_group.vel_rrc; updated_group.acceleration];
t_init             = updated_group.init_time;
t_update           = updated_group.time;

acc_thrust_mags    = updated_group.staging_struct.acc_thrust_mags;
alpha_vars         = updated_group.staging_struct.alpha_vars;
burn_out_flag      = updated_group.staging_struct.burn_out_flag;
interstage_flag    = updated_group.staging_struct.interstage_flag;
stage_altitude_vec = updated_group.staging_struct.stage_altitude;
stage_count        = updated_group.staging_struct.stage_count;
staging_flag_vec   = updated_group.staging_struct.staging_flag_vec;
staging_time_vec   = updated_group.staging_struct.staging_time_vec;
t_burn_out         = updated_group.staging_struct.t_burn_out;
update_times       = updated_group.staging_struct.update_times;


%Tack on the current estimates to the storage vectors
update_times    = [update_times; t_update];
acc_thrust_mags = [acc_thrust_mags; sv_rrc(9)];
alpha_vars      = [alpha_vars; cov_rrc(9,9)];

acc_thrust_mags_bo     = acc_thrust_mags;
alpha_vars_bo          = alpha_vars;

%Now that we've added to the vectors required for staging detection,
%increment the counter
thrust_cntr     = length(acc_thrust_mags);

cond1 = ( n_up > map_tp_sap_6008 );

if ~( cond1 )
   %this means that none of the conditions for calculating burn-out chi
   %square value were met, so exit.
   %Also implies that we cannot run the test to detect staging
   
   %Only update those things that have changed
   updated_group = ...
      Fill_Output(updated_group, update_times, ...
                  acc_thrust_mags, alpha_vars);
   %
   return
end

if thrust_cntr > map_tp_sap_6008
   %The passed in vector is longer than required, so shorten it
   tmp1 = 1;
   tmp2 = thrust_cntr - map_tp_sap_6008;
   
   acc_thrust_mags_bo(tmp1:tmp2)     = [];
   alpha_vars_bo(tmp1:tmp2)          = [];
end


[burn_out_flagT, interstage_flagT] = ...
   Burn_out_Detection(interstage_flag, acc_thrust_mags_bo, alpha_vars_bo, constants.map_saps);

%Perform staging detection
if stage_count == 0
   dt = t_update - t_init;
else
   dt1 = t_update - t_init;
   dt2 = t_update - staging_time_vec(end);
   dt  = min( dt1, dt2 );
end %determinging delta time

cond2 = ( stage_count == 0 );

cond11 = ( cond2 && n_up > map_tp_sap_6005 && dt > map_tp_sap_6001 );
cond22 = ( stage_count > 0 && dt > map_tp_sap_6000 );

if ( cond11 || cond22 )
   [Staging_Detected, staging_time] = ...
      Staging_Detection(constants.map_saps, acc_thrust_mags, update_times);

   if Staging_Detected
      %Detected staging, so increment the count and reset the filter and
      %record some other things
      
      stage_count        = stage_count + 1;
      stage_altitude     = Calc_ht(sv_rrc(1:3,1), radar.site.es, constants.physical_constants.re, constants.physical_constants.rp );
      stage_altitude_vec = [stage_altitude_vec; stage_altitude];
      interstage_flag    = true;
      
      if cr2
         sv_rrc(7)  = constants.map_saps.map_tp_sap_6060;  %theta i
         sv_rrc(8)  = constants.map_saps.map_tp_sap_6061;  %theta c
         sv_rrc(9)  = constants.map_saps.map_tp_sap_6062;  %thrust accel mag
         sv_rrc(10) = constants.map_saps.map_tp_sap_6063;  %I_sp
      
         %Reset the lower right portion of the covariance matrix
         tmpMat = zeros(4);
         tmpMat(1,1)   = constants.map_saps.map_tp_sap_6064;  %theta i
         tmpMat(2,2)   = constants.map_saps.map_tp_sap_6065;  %theta c
         tmpMat(3,3)   = constants.map_saps.map_tp_sap_6066;  %thrust accel mag
         tmpMat(4,4)   = constants.map_saps.map_tp_sap_6067;  %I_sp

         cov_rrc(7:10,:)    = zeros(4, 10);
         cov_rrc(:,7:10)    = zeros(10, 4);
         cov_rrc(7:10,7:10) = tmpMat;
      end %if we are using data from capability release 2
      
      staging_flag_vec = [staging_flag_vec; Staging_Detected];
      staging_time_vec = [staging_time_vec; staging_time];
   end

end %if staging is allowd


if stage_count > 0
   %staging_time_vec only has values if staging has been detected
   cond3 = ( t_update - staging_time_vec(end) ) >= map_tp_sap_6006;
else
   cond3 = false;
end

if ( cond1 && ( cond2 || (~cond2 && cond3) ) )
   %The conditions are met where we can check for burn-out
   if any( burn_out_flagT )
      %declared burn-out, so exit while updating the time of burn-out
      t_burn_out = t_update;
      
      burn_out_flag   = burn_out_flagT;
      interstage_flag = interstage_flagT;
   end

end

%Set up the output structure
updated_group = ...\
   Fill_Output(updated_group, update_times, ...
               acc_thrust_mags, alpha_vars, t_burn_out, ...
               burn_out_flag, interstage_flag, ...
               stage_altitude_vec, ...
               staging_flag_vec, staging_time_vec, ...
               stage_count, sv_rrc, cov_rrc);
%
return   %Burnout_Controller


function updated_group = ...
   Fill_Output(updated_group, update_times, ...
               acc_thrust_mags, alpha_vars, ...
               t_burn_out, burn_out_flag, interstage_flag, ...
               stage_altitude_vec, ...
               staging_flag_vec, staging_time_vec, ...
               stage_count, sv_rrc, cov_rrc)
%


updated_group.staging_struct.update_times      = update_times;
updated_group.staging_struct.acc_thrust_mags   = acc_thrust_mags;
updated_group.staging_struct.alpha_vars        = alpha_vars;

if nargin == 4
   %We didn't do any burn-out or staging detection, so nothing else needs
   %to be updated
   return
end

updated_group.staging_struct.t_burn_out        = t_burn_out;
updated_group.staging_struct.interstage_flag   = interstage_flag;
updated_group.staging_struct.burn_out_flag     = burn_out_flag;

if nargin == 7
   %We didn't do any staging detection, but did detect burn out.  Update
   %the flags but no need to update the stuff that changes due to staging
   return
end

updated_group.staging_struct.stage_altitude    = stage_altitude_vec;

updated_group.staging_struct.staging_flag_vec  = staging_flag_vec;
updated_group.staging_struct.staging_time_vec  = staging_time_vec;
updated_group.staging_struct.stage_count       = stage_count;

updated_group.pos_rrc            = sv_rrc(1:3,1);
updated_group.vel_rrc            = sv_rrc(4:6,1);
updated_group.acceleration       = sv_rrc(7:10,1);
updated_group.cov_rrc            = cov_rrc;

return  %Fill_Output
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
