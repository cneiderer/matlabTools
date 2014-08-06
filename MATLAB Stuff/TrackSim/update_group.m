function [updated_group, DZ, K,man_detected] = update_group(propagated_group, detection, constants, radar)
%   [updated_group,DZ,K] = update_group(propagated_group, detection, constants, radar)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Perform a Kalman filter update on a propagated RRC and RUV group
%
%   Input:
%        propagated_group  --  A structure that represents the propagated
%                              state and the associated statistics.
%                              Required fields:
%           prob_assoc     --  The probability of association (detection to
%                              the track).  Optional field.  If this is not
%                              a field, then the default value is one.
%           track_type     --  A number representing the track type of the
%                              object.
%           pos_ruv        --  The RUV position vector, 3x1
%           vel_ruv        --  The RUV velocity vector, 3x1
%           drag           --  The atmospheric drag.  This only contains
%                              valid data if the Track Type is Endo
%           cov_ruv        --  The RUV covariance matrix.  6x6 if track
%                              type is Exo, 7x7 if track type is Endo,
%                              10x10 if track type is booster
%           n_up           --  num updates
%           search_source  --  A number that represents the search method
%                              used to start the track.  Currently only
%                              applicable for Exo track types.
%                              Optional field.  If it is not a field, the
%                              default value is 23.  This is an index into
%                              map_tp_sap_1109.
%           acceleration   --  The acceleration vector, 4x1.  This
%                              currently contains theta_i, theta_c, 
%                              alpha, I_sp
%           object_id      --  The numeric id of the track
%           PLUS WHATEVER STUFF UPDATED_GROUP NEEDS!!!
%
%        detection    --  A structure representing the radar detection.
%                         Requires the following fields:
%           rdc_time  --  The range doppler coupling time
%           ruv       --  The RUV measurement vector
%           ruv_var   --  The RUV measurement covariance matrix.
%           sim_id    --  The id of the true object from which the
%                         detection came
%        constants                --  Structure of system constants.
%                                     Required fields:
%           map_saps
%                map_tp_sap_1109  --  Number of track updates for
%                                     range/sine-angle covariance
%                                     decoupling (6-state). Function of
%                                     radar function type.
%                map_tp_sap_1116  --  Number of track updates for
%                                     range/sine-angle covariance
%                                     decoupling (7-state)
%                map_tp_sap_1117  --  Number of track updates for
%                                     drag/sine-angle covariance decoupling
%                                     (7-state)
%                map_tp_sap_1118  --  Number of track updates for
%                                     drag/range-angle covariance
%                                     decoupling (7-state)
%                map_tp_sap_6023  --  Maximum number of initial track
%                                     filter updates for which the range
%                                     and range rate are decoupled from the
%                                     angles, angle rates, residual
%                                     acceleration and specific impulse
%           physical_constants
%                re               --  Earth equatorial radius (m)
%                rp               --  Earth polar radius (m)
%
%        radar
%           site
%                fs               --  dir cosine matrix transforming from
%                                     site to face coords
%                d_RRC_RFC        --  the vector of misalignment errors
%                r0_rrc           --  position vector from earth center to
%                                     site in rrc
%                es               --  dir cosine matrix transforming from
%                                     site to ECR coords
%
%   Output:
%        updated_group  --  The updated state.  A structure with the
%                           following fields:
%           h
%           pos_rrc
%           vel_rrc
%           pos_ruv
%           vel_ruv
%           drag
%           cov_rrc
%           cov_ruv
%           n_up
%           acceleration
%           kalman_gain
%           residual
%        DZ             --  The residuals (the detection minus the
%                           prediction corrected for range doppler
%                           coupling)
%        K              --  The Kalman Gain matrix
%
%   Required Functions:
%        Ruv_rrc        --  
%        J_ruv_rrc      --  
%        Calc_ht        --  
%
man_detected=0;

R              = diag(detection.ruv_var);
PruvUpdated    = zeros(10);  

%Check if the Pij was passed in, else set to 1
if ~isfield(propagated_group,'prob_assoc')
   Pij = 1;
else
   Pij = propagated_group.prob_assoc;
end

%A cheat to force this
Pij = 1;

if propagated_group.track_type == 1 %'ENDO'  %% 7 state 
   I              = eye(7);
   H              = zeros(3,7);
   H(1:3,1:3)     = eye(3);
   H(1,4)         = detection.rdc_time;
   svRUV          = [ propagated_group.pos_ruv, propagated_group.vel_ruv, propagated_group.drag ]';
   DZ             = detection.ruv' - H * svRUV;
   Pruv           = propagated_group.cov_ruv;
   Pd             = Pruv; %decoupled Pruv matrix

   %Decouple based on number of updates
   if propagated_group.n_up < constants.map_saps.map_tp_sap_1116
      %range and rangeRate decoupled from angle and angle rate
      Pd(1,[2 3 5 6]) = 0; 
      Pd(4,[2 3 5 6]) = 0; 
      Pd([2 3 5 6],1) = 0; 
      Pd([2 3 5 6],4) = 0; 
   end
   if propagated_group.n_up < constants.map_saps.map_tp_sap_1117
      %drag decoupled from angle and angle rate
      Pd(7,[2 3 5 6]) = 0;
      Pd([2 3 5 6],7) = 0;
   end
   if propagated_group.n_up < constants.map_saps.map_tp_sap_1118
      %drag decoupled from range and range rate
      Pd(7,[1 4]) = 0;
      Pd([1 4],7) = 0;
   end

   inv_mat        = Pij * (H * Pd * H' + R) + (1 - Pij) * DZ * DZ';
   K              = Pij * Pd * ( inv_mat' \ H)';

   svRUVupdated   = svRUV  + K*DZ;
   PruvUpdated    = Pij*(I - K*H)*Pruv*(I - K*H)' + (1 - Pij)*Pruv + K*(Pij*R + (1-Pij)*DZ*DZ')*K';

   svRUVupdated(8:10,1)  = zeros(3,1);  
   K                     = [  K; zeros(3,3) ];    %% this makes the returned K matrix always 10x3

elseif propagated_group.track_type == 2  %'EXO'
   %% 6 state

   I              = eye(6);
   H              = zeros(3,6);
   H(1:3,1:3)     = eye(3);
   H(1,4)         = detection.rdc_time;
   svRUV          = [ propagated_group.pos_ruv; propagated_group.vel_ruv ];
   DZ             = detection.ruv - H * svRUV;
   Pruv           = propagated_group.cov_ruv(1:6,1:6);
   Pd             = Pruv; %decoupled Pruv matrix

   if isfield(propagated_group,'search_source')
      search_source_indx = propagated_group.search_source;
   else
      search_source_indx = 23;
   end

   %% range and rangeRate decoupled from angle and angle rate
   if propagated_group.n_up < constants.map_saps.map_tp_sap_1109(search_source_indx)  
      Pd(1,[2 3 5 6]) = 0; 
      Pd(4,[2 3 5 6]) = 0; 
      Pd([2 3 5 6],1) = 0; 
      Pd([2 3 5 6],4) = 0; 
   end

   inv_mat        = Pij * (H * Pd * H' + R) + (1 - Pij) * DZ * DZ';
   %K                     = Pij*Pd*H'*inv(Pij*(H*Pd*H' + R) + (1 - Pij)*DZ*DZ');
   K              = Pij * Pd * ( inv_mat' \ H)';

  Sres=(H * Pd * H' + R);
  if DZ(1).^2/Sres(1,1)>10
      man_detected=1;
  else
      man_detected=0;
  end
   
   svRUVupdated          = svRUV  + K*DZ;
   PruvUpdated(1:6,1:6)  = Pij*(I - K*H)*Pruv*(I - K*H)' + (1 - Pij)*Pruv + K*(Pij*R + (1-Pij)*DZ*DZ')*K';
   svRUVupdated(7:10,1)  = zeros(4,1);  
   K                     = [  K; zeros(4,3) ];    %% this makes the returned K matrix always 10x3
elseif propagated_group.track_type == 3 %'BOOSTER'
   %% 10 state

   I              = eye(10);
   H              = zeros(3,10);
   H(1:3,1:3)     = eye(3);
   H(1,4)         = detection.rdc_time;
   svRUV          = [ propagated_group.pos_ruv; propagated_group.vel_ruv; propagated_group.acceleration ];
   DZ             = detection.ruv - H * svRUV;
   Pruv           = propagated_group.cov_ruv;
   Pd             = Pruv; %decoupled Pruv matrix

   %% range and rangeRate decoupled from angle and angle rate
   if propagated_group.n_up < constants.map_saps.map_tp_sap_6023
      Pd(1,[2 3 5 6]) = 0; 
      Pd(4,[2 3 5 6]) = 0; 
      Pd([2 3 5 6],1) = 0; 
      Pd([2 3 5 6],4) = 0; 
   end

   inv_mat        = Pij * (H * Pd * H' + R) + (1 - Pij) * DZ * DZ';
   %K                     = Pij*Pd*H'*inv(Pij*(H*Pd*H' + R) + (1 - Pij)*DZ*DZ');
   K              = Pij * Pd * ( inv_mat' \ H)';

   svRUVupdated          = svRUV  + K*DZ;
   PruvUpdated           = Pij*(I - K*H)*Pruv*(I - K*H)' + (1 - Pij)*Pruv + K*(Pij*R + (1-Pij)*DZ*DZ')*K';
else
   error(['Unsupported track type', num2str(propagated_group.track_type)]);
end

%Convert to RRC
% T_RRC_RFC, d_RRC_RFC
svRRCupdated                =     ruv2rrc(svRUVupdated(1:6,1), radar.site.fs, radar.site.d_RRC_RFC);
svRRCupdated                =     [svRRCupdated; svRUVupdated(7:end)];

J_RUV_RRC                   =     J_ruv_rrc(svRUVupdated, radar.site.fs);  %T_rrc_rfc

%The output is 6x6, so adjust the jacobian to be 10x10
[nr, nc]     = size(J_RUV_RRC);
matPadSize   = 10 - nc;
J_RUV_RRC    = [J_RUV_RRC zeros(6,matPadSize);zeros(matPadSize,6) eye(matPadSize)];

PrrcUpdated                 =     J_RUV_RRC * PruvUpdated * J_RUV_RRC';

%Store updated information
updated_group               =     propagated_group;
updated_group.h             =     Calc_ht( svRRCupdated(1:3) + radar.site.r0_rrc, radar.site.es, constants.physical_constants.re, constants.physical_constants.rp );
updated_group.pos_rrc       =     svRRCupdated(1:3, 1);
updated_group.vel_rrc       =     svRRCupdated(4:6, 1);
updated_group.pos_ruv       =     svRUVupdated(1:3, 1);
updated_group.vel_ruv       =     svRUVupdated(4:6, 1);
updated_group.drag          =     svRUVupdated(7); 
updated_group.cov_rrc       =     PrrcUpdated;
updated_group.cov_ruv       =     PruvUpdated;
updated_group.n_up          =     updated_group.n_up + 1;
updated_group.acceleration  =     svRRCupdated(7:10, 1);
updated_group.kalman_gain   =     K;
updated_group.residual      =     DZ;

DZ = DZ';


%Perform alpha clamping, to make sure the magnitude of the thrust
%acceleration  doesn't drop below zero
%Enforce a floor for alpha at zero
%  This goes here as we are only checking on negative values of alpha, and
%  we need to do this before we do the next propagation.
if updated_group.acceleration(3) < 0
   updated_group.acceleration(3)  = 0;
end

%Dan's version of signal to noise ratio
cov_ruv_prop                 = Pd;
cov_ruv_prop_doppler_correct = H * Pd * H';
var_ruv_msr                  = R;

snr_dan = DZ(1).^2 ./ ( var_ruv_msr(1,1) + squeeze( cov_ruv_prop_doppler_correct(1,1) )' );
snr_dan_db = 10 .* log10( snr_dan );

% updated_group.sim_id          = detection.sim_id;
updated_group.object_id       = propagated_group.object_id;
updated_group.det_cntr        = propagated_group.det_cntr + 1;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
