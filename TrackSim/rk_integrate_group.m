function [sv_next, P_next] = ...
   rk_integrate_group(sv_rrc, cov_rrc, dt, object_props, constants, radar, flags)
%   [sv_next, P_next] = rk_integrate_group( sv_curr, cov_rrc, dt, object_props, constants, radar, flags)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%        4th order Runga Kutta integration of a state and covariance by one
%        time step according to tracktype.  This file contains some
%        modifications to the standard Runga Kutta algorithm to account for
%        the oddities of the 10 state boosting filter.
%
%   Input:
%        sv_curr         --  6, 7, or 10 state RRC state vector at current
%                            time centered at earth center
%        cov_rrc         --  6x6, 7x7, or 10x10 RRC covariance matrix at
%                            the current time
%        dt              --  time step (seconds)
%        object_props    --  structure with specific object information
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
%                map_tp_sap_6045  --  Time constant for the curvature angle
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
%        sv_next         --  Predicted 6, 7, or 10 state RRC state vector
%                            at next time centered at earth center
%        P_next          --  Predicted 6x6, 7x7, or 10x10 RRC covarince at
%                            next time
%
%   Required Functions:
%        PropagateExoGroup    --  If selected propagate function is this
%        PropagateBoostGroup  --  If selected propagate function is this
%

if exist('flags', 'var')
   if isfield(flags, 'noBkwdProp')
      noBkwdProp = flags.noBkwdProp; %1 implies do not propagate backward
   else
      noBkwdProp = 1; % % Default has no backward propagation
   end
else
   %Flags structure was not passed in, so set default values
   noBkwdProp = 1; % % Default has no backward propagation
end %if the flags structure was passed in

%Get the correct propagation model
fun = object_props.prop_fun;

%Propagating the state vector first (to use result later for propagating
%covariance matrix.  As such, all of the covariance matrix entries are set
%to empty, to reduce the amount of data moving around.
flags.des_fun = 'sv';
d1 = feval(fun, sv_rrc, [], constants, radar, flags);

flags.des_fun = 'cov';
dPdt1 = feval(fun, sv_rrc, cov_rrc, constants, radar, flags);

if (~noBkwdProp) && object_props.track_type == 3 %'BOOSTER'
   %Only when we are doing backward propagation, and we are currently only
   %doing this when we have a 10 state vector
   d1(7) = 0;
   d1(8) = 0;
end %If we are propagating a 10 state filter backwards

a  = sv_rrc + 0.5 * dt * d1;
Pa = cov_rrc + 0.5 * dt * dPdt1;

flags.des_fun = 'sv';
d2 = feval(fun, a, [], constants, radar, flags);

flags.des_fun = 'cov';
dPdt2 = feval(fun, a, Pa, constants, radar, flags);

if (~noBkwdProp) && object_props.track_type == 3 %'BOOSTER'
   %Only when we are doing backward propagation, and we are currently only
   %doing this when we have a 10 state vector
   d2(7) = 0;
   d2(8) = 0;
end %If we are propagating a 10 state filter backwards

a  = sv_rrc + 0.5 * dt * d2;
Pa = cov_rrc + 0.5 * dt * dPdt2;

flags.des_fun = 'sv';
d3 = feval(fun, a, [], constants, radar, flags);

flags.des_fun = 'cov';
dPdt3 = feval(fun, a, Pa, constants, radar, flags);

if (~noBkwdProp) && object_props.track_type == 3 %'BOOSTER'
   %Only when we are doing backward propagation, and we are currently only
   %doing this when we have a 10 state vector
   d3(7) = 0;
   d3(8) = 0;
end %If we are propagating a 10 state filter backwards

a  = sv_rrc + dt * d3;
Pa = cov_rrc + dt * dPdt3;

flags.des_fun = 'sv';
d4 = feval(fun, a, [], constants, radar, flags);

flags.des_fun = 'cov';
dPdt4 = feval(fun, a, Pa, constants, radar, flags);

if (~noBkwdProp) && object_props.track_type == 3 %'BOOSTER'
   %Only when we are doing backward propagation, and we are currently only
   %doing this when we have a 10 state vector
   d4(7) = 0;
   d4(8) = 0;
end %If we are propagating a 10 state filter backwards

%Integrated rrc state vector
sv_next = sv_rrc + (dt/6.0)*(d1 + 2.0*(d2 + d3) + d4);

%Integrated rrc covariance matrix
P_next  = cov_rrc + (dt/6.0)*(dPdt1 + 2.0*(dPdt2 + dPdt3) + dPdt4);

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
