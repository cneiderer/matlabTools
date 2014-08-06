function propagated_group = propagate_group(input_group, dt, constants, radar, flags)
%   propagated_group = propagate_group(input_group,dt,constants, radar, flags)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Propagate an RRC and RUV group.
%
%   Input:
%        input_group     --  A structure that represents the state and the
%                            associated statistics.  It contains the
%                            following fields:
%           track_type   --  A number representing the track type of the
%                            object.
%           search_source  --  A number that represents the search method
%                              used to start the track.  Currently only
%                              applicable for Booster track types.
%           pos_rrc        --  The RRC position vector, 3x1
%           vel_rrc        --  The RRC velocity vector, 3x1
%           acceleration   --  The acceleration vector, 4x1.  This
%                              currently contains theta_i, theta_c, 
%                              alpha, I_sp
%           cov_rrc        --  The RRC covariance matrix.  6x6 if track
%                              type is Exo, 7x7 if track type is Endo,
%                              10x10 if track type is booster
%           object_id      --  The numeric identifier for the track
%
%        dt              --  The time step over which the function will
%                            propagate
%
%        constants       --  Structure of system constants.  Required
%                            fields:
%           physical_constants    --  A structure of physical constants.
%                j2               --  2nd zonal harmonic
%                mu_e             --  earth gravitational parameter
%                                     (m^3/s^2)
%                re_sq            --  Earth equatorial radius squared (m^2)
%                re               --  Earth equatorial radius (m)
%                rp               --  Earth polar radius (m)
%           map_saps     --  
%                map_tp_sap_1047  --  process noise for EXO along velocity
%                                     vector
%                map_tp_sap_1160  --  Scale factor used to determine the
%                                     process noise associated with the
%                                     derivative of the position in the
%                                     covariance matrix
%                map_tp_sap_1305  --  Max integration step size
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
%                map_tp_sap_6035  --  Max integration step size for
%                                     10-state filter for track
%                map_tp_sap_6045  --  Time constant for the curvature angle
%                map_tp_sap_6049  --  Max allowed value for alpha
%                map_tp_sap_6058  --  Cued Search 10 state propagation step
%                                     size
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
%                r0_rrc           --  position vector from earth center to
%                                     site in rrc
%                es               --  dir cosine matrix transforming from
%                                     site to ECR coords
%                fs               --  dir cosine matrix transforming from
%                                     site to face coords
%                d_RRC_RFC        --  the vector of misalignment errors
%           funs         --  filter propagation functions
%                acceleration_gravity
%                propagate_Exo
%                propagate_Booster
%           radar_function       --  A structure that contains the radar
%                                    functions used in the simulation
%                CuedSearch   -- number used to represent the cued search
%                                radar function
%
%        flags           --  A structure of control flags, with the
%                            following fields:
%           noBkwdProp   --  1 indicates that the routine does not
%                            propagate backwards in time
%           noQ          --  A flag to indicate if desire to not use 
%                            process noise.  Default value is zero, which
%                            means to use process noise
%
%   Output:
%        propagated_group -- A structure that represents the propagated
%                            state and the associated statistics.  It
%                            contains the same fields as input_group.
%           track_type   --  A number representing the track type of the
%                            object.
%           search_source  --  A number that represents the search method
%                              used to start the track.  Currently only
%                              applicable for Booster track types.
%           pos_rrc        --  The RRC position vector, 3x1
%           vel_rrc        --  The RRC velocity vector, 3x1
%           acceleration   --  The acceleration vector, 4x1.  This
%                              currently contains theta_i, theta_c, 
%                              alpha, I_sp
%           cov_rrc        --  The RRC covariance matrix.  6x6 if track
%                              type is Exo, 7x7 if track type is Endo,
%                              10x10 if track type is booster
%           h              --  Altitude
%           time           --  The time to which the state was predicted
%           acc_rrc        --  The RRC acceleration vector. If the input
%                              vector is 9x1, then this is truly the
%                              acceleration.  If the input vector is 10x1,
%                              then this contains theta_i, theta_c, 
%                              alpha, I_sp
%           drag           --  The atmospheric drag.  This only contains
%                              valid data if the Track Type is Endo
%           pos_ruv        --  The RUV position vector, 3x1
%           vel_ruv        --  The RUV velocity vector, 3x1
%           cov_ruv        --  The RUV covariance matrix.  6x6 if track
%                              type is Exo, 7x7 if track type is Endo,
%                              10x10 if track type is booster
%           object_id      --  The numeric identifier for the track
%
%   Required Functions:
%        rk_integrate_group  --  
%        Alpha_Clamping      --  
%        Calc_ht             --  
%        Rrc_ruv             --  
%        J_rrc_ruv           --  


%Initialize the output
propagated_group = input_group;

%Calculate the time step size and num steps
switch input_group.track_type
   case 2  %'EXO'
      max_time_step = constants.map_saps.map_tp_sap_1305;
      prop_fun      = radar.funs.propagate_Exo;
   case 8  %'MANEUVER'
      error(['Unsupported track type', num2str(object_props.track_type)]);
   case 3  %'BOOSTER'
      
      max_time_step = constants.map_saps.map_tp_sap_6035;
      switch input_group.search_source
         case radar.radar_function.CuedSearch
            max_time_step = constants.map_saps.map_tp_sap_6058;
      end
      
      prop_fun = radar.funs.propagate_Booster;

   case 5  %'ABO'
      error(['Unsupported track type', num2str(object_props.track_type)]);
   case 4  %'INTERCEPTOR'
      error(['Unsupported track type', num2str(object_props.track_type)]);
   case 1  %'ENDO'
      error(['Unsupported track type', num2str(object_props.track_type)]);
   otherwise
      error(['Unknown track type', num2str(object_props.track_type)])
end

%Initialize the desired filter model, determined above by track type
input_group.prop_fun = prop_fun;

num_steps     = max(ceil( abs(dt) /max_time_step),1);
time_step     = dt/num_steps;

%Convert to earth centered
svrrc = [input_group.pos_rrc + radar.site.r0_rrc; ...
         input_group.vel_rrc; ...
         input_group.acceleration];
%
Prrc  = input_group.cov_rrc;

%Loop over time steps
for i=1:num_steps
   [svrrc_prop, Prrc_prop] = rk_integrate_group(svrrc, Prrc, time_step, ...
      input_group, constants, radar, flags);
   
   %Do alpha clamping
   [svrrc, Prrc] = Alpha_Clamping(svrrc_prop, Prrc_prop, svrrc, Prrc, ...
      time_step, input_group, constants, radar, flags);
end

%Calc the altitude
propagated_group.h = Calc_ht( svrrc(1:3), radar.site.es, ...
   constants.physical_constants.re, constants.physical_constants.rp );

%convert back to radar centered. This is final state
svrrc(1:3) = svrrc(1:3) - radar.site.r0_rrc;

%Store all of the propagated group information
propagated_group.time         = propagated_group.time + dt;
propagated_group.pos_rrc      = svrrc(1:3);
propagated_group.vel_rrc      = svrrc(4:6);
propagated_group.acc_rrc      = svrrc(7:end);
propagated_group.acceleration = svrrc(7:end);
propagated_group.drag         = svrrc(7);
propagated_group.cov_rrc      = Prrc;

%Convert to RUV;
% T_RRC_RFC, d_RRC_RFC
svruv = rrc2ruv(svrrc(1:6), radar.site.fs, radar.site.d_RRC_RFC);

if length(svrrc) > 6
   svruv = [svruv; svrrc(7:end)];
end

propagated_group.pos_ruv = svruv(1:3);
propagated_group.vel_ruv = svruv(4:6);

J = J_rrc_ruv(svruv, radar.site.fs);

propagated_group.cov_ruv = J * Prrc * J';

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
