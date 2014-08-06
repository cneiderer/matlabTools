% MUSTRIPWEFF  Calculate the effective width of a microstrip line
% 
%    [Weff] = MUSTRIPWEFF (W, T, H) 
%      W is the width
%      T is the thickness
%      H is the height
% 

function [Weff] = mustripweff (W, T, H)

if (W < 2*T),
  error('Width is too thin');
end;

if (W > H/2/pi),
  X = H;  
else
  X = 2*pi*W;
end;

Weff = W + T/pi*(1 + log(2*X/T));