function F2=J_boost_dynamics10b(RRC,t,radar,constants); 
%
%	Jacobian of 10-state exoatmospheric dynamics
%  Blackman's thrust acceleration model
R_RRC_0=radar.site.R_RRC_0;
omega_e_X=radar.site.omega_e_x;
omega_e_X2=radar.site.omega_e_x_sq;
mu_e=constants.physical_constants.mu_e;
tau_i=radar.params.tau_i;
tau_c=radar.params.tau_c;

r_ECR=RRC(1:3,1)+R_RRC_0;
r_norm=norm(r_ECR);
u_r=r_ECR/r_norm;
v_norm=norm(RRC(4:6,1));
u_v=RRC(4:6,1)/v_norm;

T1=[cos(RRC(8)) sin(RRC(8)) 0;-sin(RRC(8)) cos(RRC(8)) 0;0 0 1];
dT1_dy8=[-sin(RRC(8)) cos(RRC(8)) 0;-cos(RRC(8)) -sin(RRC(8)) 0;0 0 1];
T2=[cos(RRC(7)) 0 sin(RRC(7));0 1 0;-sin(RRC(7)) 0 cos(RRC(7))];
dT2_dy7=[-sin(RRC(7)) 0 cos(RRC(7));0 1 0;-cos(RRC(7)) 0 -sin(RRC(7))];

dT_dR_RRC=0;
dg_dR_RRC=mu_e*(3*u_r*u_r'-eye(3))/(r_norm^3);
dG_dR_RRC=dg_dR_RRC+dT_dR_RRC-omega_e_X2;

dT_dV_RRC=T2*T1*RRC(9)*(eye(3)-u_v*u_v'/(norm(RRC(4:6,1))^2))/norm(RRC(4:6,1));
dG_dV_RRC=dT_dV_RRC-2*omega_e_X;

dG_y7=dT2_dy7*T1*RRC(9)*RRC(4:6,1)/norm(RRC(4:6,1));
dG_y8=T2*dT1_dy8*RRC(9)*RRC(4:6,1)/norm(RRC(4:6,1));
dG_y9=T2*T1*RRC(4:6,1)/norm(RRC(4:6,1));
dG_y10=zeros(3,1);

F2_33=[-1/tau_i   0        0        0     ;
          0    -1/tau_c    0        0     ;
          0       0     RRC(10)   RRC(9)  ;
          0       0        0    2*RRC(10)];


F2=[zeros(3)   eye(3)  zeros(3,4); 
   dG_dR_RRC  dG_dV_RRC dG_y7  dG_y8 dG_y9 dG_y10;
   zeros(4,6) F2_33];


