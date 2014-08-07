function F2=J_boost_dynamics8b(RRC,t,radar,constants)
%
%	Jacobian of 8-state exoatmospheric dynamics
%  Blackman's thrust acceleration model
%
%	Inputs:	RRC == 8-state vectors in RRC coordinates	(8X1)
%           t == time since target launch (sec)
%
%	Outputs:	F2 == Jacobian matrix (8X8)
%
R_RRC_0=radar.site.R_RRC_0;
omega_e_X=radar.site.omega_e_x;
omega_e_X2=radar.site.omega_e_x_sq;
mu_e=constants.physical_constants.mu_e;

r_ECR=RRC(1:3,1)+R_RRC_0;
r_norm=norm(r_ECR);
u_r=r_ECR/r_norm;
v_norm=norm(RRC(4:6,1));
u_v=RRC(4:6,1)/v_norm;

dT_dR_RRC=0;
dg_dR_RRC=mu_e*(3*u_r*u_r'-eye(3))/(r_norm^3);
dG_dR_RRC=dg_dR_RRC+dT_dR_RRC-omega_e_X2;

dT_dV_RRC=RRC(7,1)*(eye(3)-u_v*u_v'/(norm(RRC(4:6,1))^2))/norm(RRC(4:6,1));
dG_dV_RRC=dT_dV_RRC-2*omega_e_X;

dG_y7=RRC(4:6,1)/norm(RRC(4:6,1));
dG_y8=zeros(3,1);

F2=[zeros(3) eye(3) zeros(3,2); 
   dG_dR_RRC dG_dV_RRC dG_y7 dG_y8;
   zeros(2,6) [RRC(8) RRC(7);0 2*RRC(8)]];



