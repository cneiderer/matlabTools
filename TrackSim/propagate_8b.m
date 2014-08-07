function y_prime=propagate_8b(t,y,radar,constants)
%
% Propagates 8 state boost and upper triangular covariance in RRC
% Blackman's thrust acceleration model

% y=[state_vector;covariance(:)];

R_RRC_0=radar.site.R_RRC_0;
omega_e_X=radar.site.omega_e_x;
omega_e_X2=radar.site.omega_e_x_sq;
mu_e=constants.physical_constants.mu_e;
TP1047=constants.map_saps.TP1047;
TP1047A=constants.map_saps.TP1047A;
f8b_process_noise_y7=radar.params.f8b_process_noise_y7; 
f8b_process_noise_y8=radar.params.f8b_process_noise_y8;

r_position=y(1:3)+R_RRC_0;
vel=y(4:6);

% Gravity version 1, J5
%acc_grav=gravity_5(r_position);

% Gravity version 2, no J
acc_grav=-mu_e*r_position/norm(r_position)^3;
acc_cor=-2*omega_e_X*vel;
acc_cen=-omega_e_X2*r_position;

a_thrust_mag=y(7);
a_thrust=a_thrust_mag*vel/norm(vel);

beta=y(8);
y_state=[vel;
   a_thrust+acc_grav+acc_cor+acc_cen;
   a_thrust_mag*beta;
   beta^2];

P=put_upper_cov(y);

q=TP1047;	% Should be based on Track Type
q_v=TP1047A; 		% Should be based on Track Type

F2=J_boost_dynamics_8b(y(1:8),t,radar,constants);
u_v=vel/norm(vel);

P_prime=F2*P+P*F2'+...
   [zeros(3,8);
   zeros(3,3) q*(eye(3)-u_v*u_v')+q_v*u_v*u_v' zeros(3,2);
   zeros(2,6) diag([f8b_process_noise_y7 f8b_process_noise_y8])];

P_state=get_upper_cov(P_prime);

y_prime=[y_state;P_state];
