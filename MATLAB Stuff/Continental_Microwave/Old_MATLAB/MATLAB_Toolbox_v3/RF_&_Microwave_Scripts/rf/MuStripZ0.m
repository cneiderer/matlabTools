% MUSTRIPZ0  Calculate the characteristic impedance of a microstrip line
% 
%    [Z0] = MUSTRIPZ0 (EpsR, WbyD) 
%      EpsR is the relative dielectric constant
%      WbyD is the ratio of the width to the distance to the ground plane
%      

function [Z0] = MUSTRIPZ0 (EpsR, WbyD) 

EpsEff = (EpsR + 1)/2 + (EpsR - 1)/2*1/sqrt(1 + 12/WbyD);

if (WbyD < 1),
  Z0 = 60/sqrt(EpsEff)*log(8/WbyD + WbyD/4);
else
  Z0 = 120*pi/sqrt(EpsEff)/(WbyD + 1.393 + 0.667*log(WbyD + 1.444));
end;
