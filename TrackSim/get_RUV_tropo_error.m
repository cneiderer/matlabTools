function del_RUV=get_RUV_tropo_error(RUV_R,radar)
%
% Computes tropospheric refraction error in RUV.
%
%	Inputs:		    RUV_R			== RUV of pulse (3X1);
%
%	Outputs:	RUV_tropo_error == 3X1 tropo error vector in RUV
%
N_s = radar.params.N_s;
deg_to_rad = (pi/180);
rad_to_deg = (180/pi);

RAE=rrc2rae(ruv2rrc(RUV_R, radar.site.fs, radar.site.d_RRC_RFC));
del_R=0.007*N_s*csc(RAE(3,:)*deg_to_rad);
del_E=N_s*1e-6*cot(RAE(3,:)*deg_to_rad)*rad_to_deg;
del_RUV=abs(rrc2ruv(rae2rrc([del_R;0;del_E]+RAE(1:3)), radar.site.fs, radar.site.d_RRC_RFC)-RUV_R(1:3));

