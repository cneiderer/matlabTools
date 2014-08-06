% MUSTRIP  Calculate the required width of a microstrip line
% 
%    [W, EpsEff] = MUSTRIP (H, Z0, EpsR) 
%      H is the height
%      Z0 is the required characteristic impedance
%      EpsR is the relative dielectric constant
%      W is the required width
%      EpsEff is the effective dielectric constant
%      

function [W, EpsEff] = mustrip (H, Z0, EpsR)

A = Z0/60*sqrt((EpsR + 1)/2) + (EpsR - 1)/(EpsR + 1)*(0.23 + 0.11/EpsR);
B = 377*pi/2/Z0/sqrt(EpsR);

Wbyd = 8*exp(A)/(exp(2*A)-2);

if (Wbyd > 2),
  Wbyd = 2/pi*(B - 1 - log(2*B - 1) + (EpsR - 1)/(2*EpsR)*(log(B - 1) + 0.39 - 0.61/EpsR));
end;

W = Wbyd*H;

EpsEff = (EpsR + 1)/2 + (EpsR - 1)/2*1/sqrt(1 + 12*H/W);