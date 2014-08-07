function [svrrc_prop, Prrc_prop] = Alpha_Clamping(svrrc_prop, Prrc_prop, ...
   svrrc, Prrc, time_step, input_group, constants, radar, flags)
%     [svrrc_prop, Prrc_prop] = Alpha_Clamping(svrrc_prop, Prrc_prop, ...
%                                    svrrc, Prrc, time_step,
%                                    input_group, constants, radar, flags)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      This function prevents alpha from growing too large or becoming
%      negative.  Alpha represents the magnitude of the thrust acceleration
%      and is used in the 10 state boosting filter model.  In a way, this
%      makes a guess that staging occurred, and the need to reset certain
%      elements and then re-propagate.
%
%   Input:
%        svrrc_prop      --  The propagated state vector, that is being
%                            tested for going too high or too low
%        Prrc_prop       --  The propagated RRC covariance matrix (NxN)
%        svrrc           --  The RRC state vector before propagation (Nx1)
%        Prrc            --  The RRC covariance matrix before propagation (NxN)
%        time_step       --  The propagation time interval
%        input_group     --  structure with specific object information
%                            fields:
%           prop_fun     --  A function handle that specifies which
%                            propagation function is to be used in the
%                            Runge Kutta integration.
%           track_type   --  A number representing the track type of the
%                            object.
%
%        constants       --  Structure of system constants.  Required
%                            fields:
%           physical_constants    --  A structure of physical constants.
%                j2               --  2nd zonal harmonic
%                mu_e             --  earth gravitational parameter
%                                     (m^3/s^2)
%                re_sq            --  square of the equatorial earth radius
%           map_saps     --  
%                map_tp_sap_1047  --  process noise for EXO along velocity
%                                     vector
%                map_tp_sap_1160  --  Scale factor used to determine the
%                                     process noise associated with the
%                                     derivative of the position in the
%                                     covariance matrix
%                map_tp_sap_6010  --  Time constant for the inclination
%                                     angle
%                map_tp_sap_6011  --  The process noise for theta i, the
%                                     inclination angle
%                map_tp_sap_6012  --  The process noise for theta c, the
%                                     curvature angle
%                map_tp_sap_6013  --  The process noise for alpha, the
%                                     magnitude of the thrust acceleration
%                map_tp_sap_6014  --  The process noise for Isp, the
%                                     specific impulse
%                map_tp_sap_6017  --  Reset value for alpha if it exceeds 
%                                     the max value.
%                map_tp_sap_6045  --  Time constant for the curvature angle
%                map_tp_sap_6049  --  Max allowed value for alpha
%
%           atmos_table  --  created with 'get_atmos_table', only needed
%                            for INTERCEPTOR or ENDO track types
%           endo         --  created with 'get_endo_constants', for ENDO
%                            track type only
%
%        radar
%           site         --  Site specific values.  Created with 
%                            'form_site_constants'
%                twice_omega_e_x  --  2 * the earth rotation rate
%                omega_e_x_sq     --  the square of the earth rotation rate
%                up               --  3x1 unit vector in the direction of
%                                     the earth centered (ECR or ECI) z
%                                     vector, in RRC
%           funs
%                acceleration_gravity
%
%        flags           --  
%           noBkwdProp   --  1 indicates that the routine does not
%                            propagate backwards in time
%           noQ          --  A flag to indicate if desire to not use 
%                            process noise.  Default value is zero, which
%                            means to use process noise
%
%   Output:
%        svrrc_prop   --  The propagated state vector, that is being
%                         tested for going too high or too low
%        Prrc_prop    --  The propagated RRC covariance matrix (NxN)
%                   
%   Required Functions:
%        rk_integrate_group


%Set up some usefull constants
ALPHA = 9;  %The index for the alpha term

%Enforce a floor for alpha at zero
if svrrc_prop(ALPHA) < 0
   svrrc_prop(ALPHA)  = 0;
   return
end

if ( isfield(constants.map_saps, 'map_tp_sap_6049') )
   %Only do alpha clamping if the threshold is defined
   if svrrc_prop(ALPHA) > constants.map_saps.map_tp_sap_6049
      %Reset the alpha value and then repropagate
      svrrc(ALPHA)  = constants.map_saps.map_tp_sap_6017;
      [svrrc_prop, Prrc_prop] = rk_integrate_group(svrrc, Prrc, time_step, ...
         input_group, constants, radar, flags);
   end
end %if is field


return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
