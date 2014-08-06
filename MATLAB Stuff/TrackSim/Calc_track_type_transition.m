function output_group = Calc_track_type_transition(input_group, constants, radar)

%   output_group =
%       Calc_track_type_transition(input_group, constants, radar)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculate if a track type transition is needed for the current
%      group.
%
%   Input:
%        input_group  --  structure must contain the following fields :
%           time (1x1)
%           pos_rrc (1x3)
%           vel_rrc (1x3)
%           track_type (1x1)
%           h (1x1)
%           init_time (1x1)
%           energy (1x1)
%           energy_test_time (1x1)
%           non_boosting (logical (1x1))
%           object_kind ('string uppercase')
%
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
%              map_tp_sap_1035   --  Minimum amount of time that must
%                                    elapse past track init before we can
%                                    calculate altitude rate etc.
%              map_tp_sap_1036a  --  Atmosphere boundary for Exo to Endo
%              map_tp_sap_1036b  --  Atmosphere boundary for Endo to Exo
%              map_tp_sap_1036e  --  Threshold for speed test, ABO to Endo
%              map_tp_sap_1036f  --  Threshold for altitude rate test, ABO
%                                    to Endo
%              map_tp_sap_1036g  --  Threshold for altitude test, ABO to
%                                    Exo
%              map_tp_sap_1036h  --  Threshold for speed test, ABO to
%                                    Booster
%              map_tp_sap_1036i  --  Threshold for altitude rate test, ABO
%                                    to Booster
%              map_tp_sap_1036j  --  Threshold for speed test, Endo to
%                                    ABO
%              map_tp_sap_1043a  --  Initial value of drag term upon track
%                                    type switch to Endo
%              map_tp_sap_1043b  --  Initial value of drag variance upon 
%                                    track type switch to Endo
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
%              map_tp_sap_6006  --  The amount of time that must elapse
%                                   past a staging event before we can
%                                   start checking for additional staging
%                                   events
%              map_tp_sap_6007  --  Threshold for declaring burn-out
%              map_tp_sap_6008  --  The number of alpha estimates used to
%                                   calculate the chi square statistic used
%                                   to check for burn-out
%              map_tp_sap_6046  --  Threshold for declaring end of 
%                                   interstage period and restart of
%                                   boosting (not associated with
%                                   re-ignition detection)
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
%           sys_saps
%              sys_sap_1284      -- 
%
%        radar
%           site  --  
%              es  -- 
%              r0_rrc  --  
%           object_kinds
%              missile_oks       --  A vector of all the object kinds
%                                    associated with either a TBM or an
%                                    ICBM
%              
%   Output:
%       output_group, same as the input_group structure w/ any necessary
%       changes being made to the following fields:
%           track_type (1x1)
%           energy (1x1)
%           energy_test_time (1x1)
%           non_boosting (logical (1x1))
%
%   Required Functions:
%        Unit
%        Burnout_Controller
%        

MISSILE_OKS    = radar.object_kinds.missile_oks;

output_group   = input_group;
old_track_type = input_group.track_type;

pos          = radar.site.r0_rrc + input_group.pos_rrc; % 3x1
vel          = input_group.vel_rrc;
uPos         = Unit(pos, 1); % 3x1
h            = input_group.h;
hRate        = vel*uPos';  %% velocity projected along a line from the center of the Earth.
init_time    = input_group.init_time;
object_kind  = input_group.object_kind;

% Any transition calcs involving hRate or V can only be performed if the
% following track age condition is satisfied
time_flag = (input_group.time - init_time) > constants.map_saps.map_tp_sap_1035;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% boost burn-out detector --
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if old_track_type == 3 %'BOOSTER'
   output_group = Burnout_Controller(output_group, constants, radar);
end

%Transistion track type if needed
if old_track_type == 2 %'EXO'
   %if (h < constants.map_saps.map_tp_sap_1036a) & (hRate < 0) & time_flag
   %This was the original line.  However, due to THAAD legacy naming
   %conventions, this particular MAP SAP was stored in the global SAPs
   %structure.  Why?  Good question.  But to get this routine to function
   %with data from PGEN (or DART), the sap structure needed to be changed.
   %  Nate Brown, Michael DePlonty  June 19, 2006
    if (h < constants.map_saps.map_tp_sap_1036a) && (hRate < 0) && time_flag
        new_track_type = 1;  %'ENDO'
    else
        new_track_type = old_track_type;
    end
elseif  old_track_type == 1 %'ENDO'
   ok_test = ismember(object_kind,  MISSILE_OKS);

   if ( h > constants.map_saps.map_tp_sap_1036b )
      new_track_type = 2; %'EXO'
   elseif ( norm(vel) < constants.map_saps.map_tp_sap_1036j ) && ~ok_test && time_flag;
      new_track_type = 5; %'ABO'
   else
      new_track_type = old_track_type;
   end
elseif  old_track_type == 3 %'BOOSTER'
    if ( h < constants.map_saps.map_tp_sap_1036b ) && output_group.staging_struct.burn_out_flag
        new_track_type = 1; %'ENDO'
    elseif ( h >= constants.map_saps.map_tp_sap_1036b )&& output_group.staging_struct.burn_out_flag
        new_track_type = 2; %'EXO'
    else
        new_track_type = old_track_type;
    end
elseif  old_track_type == 5 %'ABO'
   
   ok_test = ismember(object_kind, MISSILE_OKS);
   
   if ( h > constants.map_saps.map_tp_sap_1036g )
      new_track_type = 2; %'EXO'
   elseif ( h < constants.sys_saps.sys_sap_1284 ) && ...
         (norm(vel) > constants.map_saps.map_tp_sap_1036h ) && ...
         (hRate > constants.map_saps.map_tp_sap_1036i ) && time_flag
      new_track_type = 3; %'BOOSTER'
   elseif (( ( norm(vel) > constants.map_saps.map_tp_sap_1036e ) && ...
         ( hRate < constants.map_saps.map_tp_sap_1036f) ) || ...
         ( ( norm(vel) > constants.map_saps.map_tp_sap_1036j ) && ...
         ( hRate < constants.map_saps.map_tp_sap_1036f) ...
         && ( h < constants.map_saps.map_tp_sap_1036a ) && ...
         ok_test )) && time_flag
      new_track_type = 1; %'ENDO'
   else
      new_track_type = old_track_type;
   end
elseif old_track_type == 4 %'INTERCEPTOR'
	new_track_type = old_track_type; % Do nothing
elseif  old_track_type == 8 %'MANEUVER'
	new_track_type = 2; %'EXO'
end

%Augment the states for 6 to 7 state transition
if ~old_track_type == 1 && new_track_type == 1
   %the old track type is not endo but the new track type is endo
    output_group.drag = constants.map_saps.map_tp_sap_1043a;
    output_group.cov_rrc(1:7,7)=0;
    output_group.cov_rrc(7,1:7)=0;
    output_group.cov_rrc(7,7) = constants.map_saps.map_tp_sap_1043b;
end

%Augment the states for 6 to 7 state transition
if old_track_type == 3 && ~new_track_type == 3
   %The old track type is booster and the new track type is not booster
   output_group.acceleration = zeros(4,1);
   
   tmp_rrc = output_group.cov_rrc;
   tmp_ruv = output_group.cov_ruv;
   
   output_group.cov_rrc = zeros(10,10);
   output_group.cov_rrc(1:6,1:6) = tmp_rrc(1:6,1:6);
   
   output_group.cov_ruv = zeros(10,10);
   output_group.cov_ruv(1:6,1:6) = tmp_ruv(1:6,1:6);
   
   if new_track_type == 1 %'ENDO'
      output_group.drag = constants.map_saps.map_tp_sap_1043a;
      output_group.cov_rrc(7,7) = constants.map_saps.map_tp_sap_1043b;
   end
end

output_group.track_type = new_track_type;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
