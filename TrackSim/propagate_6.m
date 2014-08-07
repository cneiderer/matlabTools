function y_prime=propagate_6(t,y,radar,constants)
%
% Propagates 6 state EXO state and upper triangular covariance in RRC
%
% y=[state_vector;covariance(:)];
%

R_RRC_0=radar.site.R_RRC_0;
omega_e_X=radar.site.omega_e_x;
omega_e_X2=radar.site.omega_e_x_sq;
mu_e=constants.physical_constants.mu_e;

r_position=y(1:3)+R_RRC_0;

vel=y(4:6);

% Gravity version 1, J5
%acc_grav=gravity_5(r_position);

% Gravity version 2, no J
acc_grav=-mu_e*r_position/norm(r_position)^3;

acc_cor=-2*omega_e_X*vel;

acc_cen=-omega_e_X2*r_position;

y_state=[vel;acc_grav+acc_cor+acc_cen]; 

P=put_upper_cov(y);

q=1e-2;%TP1047;	% Should be based on Track Type
q_v=q; 		% Should be based on Track Type

F1=J_EXO_dynamics(y(1:6),constants, radar);
u_v=vel/norm(vel);

P_prime=F1*P+P*F1'+[zeros(3,6);zeros(3,3) q*(eye(3)-u_v*u_v')+q_v*u_v*u_v'];

P_state=get_upper_cov(P_prime);

y_prime=[y_state;P_state];
