% MUSTRIPW  Calculate the width of a microstrip line from the effective width required
% 
%    [W] = MUSTRIPW (Weff, T, H) 
%      Weff is the effective width
%      T is the thickness
%      H is the height
% 

function [W] = mustripw (Weff, T, H)

W = Weff - T/pi*(1+ln(2*H/T));

if W < h/2/pi,
  W = T/pi*LambertW(1/4*exp((pi*Weff-T)/T));
end;

if W < 2*T,
  error('Width too narrow');
end;  