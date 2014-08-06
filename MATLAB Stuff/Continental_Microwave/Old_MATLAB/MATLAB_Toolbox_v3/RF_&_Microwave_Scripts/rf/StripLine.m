% STRIPLINE  Calculate the required width of a stripline
% 
%    [W] = STRIPLINE (H, Z0, EpsR) 
%      H is the height
%      Z0 is the required characteristic impedance
%      EpsR is the relative dielectric constant
%      W is the required width
%      

function [W] = stripline (H, Z0, EpsR)

x = 30*pi/sqrt(EpsR)/Z0 - 0.441;

if (sqrt(EpsR)*Z0 < 120),
  Wbyb = x;
else
  Wbyb = 0.85 - sqrt(0.6 - x);
end;

W = Wbyb*H;
