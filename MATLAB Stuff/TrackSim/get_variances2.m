function R_measure=get_variances2(SNR,RUV_T,RUV_R,freq,AZ_EL,constants,radar)
%
% Computes measurement variance matrix.
%
% Inputs:SNR== signal-to-noise ratio (linear)
%	RUV_T	== RUV of detection (3X1);
%	RUV_R	== RUV of pulse (3X1);
%	freq	== center frequency of pulse (GHz)
%	AZ_EL	== mount state [AZ EL AZ_dot EL_dot AZ_acc EL_acc] at detection time (rad, rad/sec, rad/sec^2)
%
% Outputs:	R_measure == 3X3 diagonal measurement variance matrix in RUV
%

% global mission_ID log_ID;
% global SYS0000 SYS1036 SYS1277 SYS1278 SYS1279 SYS1280 SYS1281 
% global SYS1282 SYS2697 SYS2698 SYS2699 SYS2700 SYS2701 SYS2702 SYS2703
% global SYS1335 SYS1336
% global N_s deg_to_rad rad_to_deg;

SYS0000 = constants.sys_saps.SYS0000; 
SYS1036 = constants.sys_saps.SYS1036;
SYS1277 = constants.sys_saps.SYS1277;
SYS1278 = constants.sys_saps.SYS1278;
SYS1279 = constants.sys_saps.SYS1279;
SYS1280 = constants.sys_saps.SYS1280;
SYS1281 = constants.sys_saps.SYS1281;
SYS1282 = constants.sys_saps.SYS1282;
SYS2697 = constants.sys_saps.SYS2697;
SYS2698 = constants.sys_saps.SYS2698;
SYS2699 = constants.sys_saps.SYS2699;
SYS2700 = constants.sys_saps.SYS2700;
SYS2701 = constants.sys_saps.SYS2701;
SYS2702 = constants.sys_saps.SYS2702;
SYS2703 = constants.sys_saps.SYS2703;
SYS1335 = constants.sys_saps.SYS1335; 
SYS1336 = constants.sys_saps.SYS1336;
N_s = radar.params.N_s;
deg_to_rad = (pi/180);
rad_to_deg = (180/pi);


if nargin==3;
   
   R_measure=diag([(SYS1277.MB/(2*SNR))+SYS1278.MB;(SYS1279/(2*SNR))+SYS1280;(SYS1281/(2*SNR))+SYS1282]);
   
   del_E=0;
   
elseif nargin==7;
   
   freq_code=find(SYS0000==freq);
   
   if freq_code==33;
      SYS1277_choice=SYS1277.WB;
      SYS1278_choice=SYS1278.WB;
   else
      SYS1277_choice=SYS1277.MB;
      SYS1278_choice=SYS1278.MB;
   end;   
   
   W=sqrt(1-RUV_T(2)^2-RUV_T(3)^2);
   
   EL=asin(RUV_T(3)*cos(AZ_EL(2))+W*sin(AZ_EL(2)));
   
   R_var=(SYS1277_choice/(2*SNR))+SYS1278_choice+0*(N_s*1e-6*SYS2699*csc(EL*SYS2702))^2;
   
   U_var=(SYS1335^2/2.56/2/SNR)+(1e-8);
   
   V_var=(SYS1336^2/2.56/2/SNR)+(1e-8);
   
   R_measure=diag([R_var U_var V_var]);
   
else
   error('Incorrect number of inputs in get_variances!!!');
end;




