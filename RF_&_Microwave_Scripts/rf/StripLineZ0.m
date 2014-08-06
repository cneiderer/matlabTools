% STRIPLINEZ0  Calculate the characteristic impedance of a stripline
% 
%    [Z0] = STRIPLINEZ0 (EpsR, WbyB) 
%      EpsR is the relative dielectric constant
%      WbyB is the ratio of the width to the distance to the ground planes
%      

function [Z0] = STRIPLINEZ0 (EpsR, WbyB) 

if (WbyB > 0.35),
  WeffbyB = WbyB;
else
  WeffbyB = WbyB - (0.35 - WbyB)^2;
end;

Z0 = 30*pi/sqrt(EpsR)/(WeffbyB+0.441);