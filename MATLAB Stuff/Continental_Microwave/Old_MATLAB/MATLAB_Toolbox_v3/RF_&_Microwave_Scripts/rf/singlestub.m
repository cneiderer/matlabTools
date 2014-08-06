% SINGLESTUB  Computes the single-stub matching networks for a given Zl and Z0
%
%	[D1,L1,D2,L2] = SINGLESTUB(Z0, Zl, TYPE) 
%      TYPE is either 'short' or 'open'
%      D and L are the distance from the load and the length, in terms 
%        of wavelength
%
function [D1,L1,D2,L2] = singlestub (Z0, Zl, STUBTYPE);

Rl = real(Zl);
Xl = imag(Zl);
Y0 = 1/Z0;

if (Rl == Z0),
   t1 = -Xl/(2*Z0);
   t2 = t1;
else
   t1 = (Xl+sqrt(Rl*((Z0-Rl)^2+Xl^2)/Z0))/(Rl-Z0);
   t2 = (Xl-sqrt(Rl*((Z0-Rl)^2+Xl^2)/Z0))/(Rl-Z0);
end;

if (t1 >= 0),
  D1 = 1/2/pi*atan(t1); 
else
  D1 = 1/2/pi*(pi+atan(t1)); 
end;

if (t2 >= 0),
  D2 = 1/2/pi*atan(t2); 
else
  D2 = 1/2/pi*(pi+atan(t2)); 
end;

B1 = (Rl^2*t1-(Z0-Xl*t1)*(Xl+Z0*t1))/(Z0*(Rl^2+(Xl+Z0*t1)^2));
B2 = (Rl^2*t2-(Z0-Xl*t2)*(Xl+Z0*t2))/(Z0*(Rl^2+(Xl+Z0*t2)^2));

STUBTYPE = lower(STUBTYPE);

switch STUBTYPE
  case 'open', 
    L1 = -1/2/pi*atan(B1/Y0);
    L2 = -1/2/pi*atan(B2/Y0);
  case 'short', 
    L1 = 1/2/pi*atan(Y0/B1);
    L2 = 1/2/pi*atan(Y0/B2);
  otherwise, error('Bad stub type');   
end;   

if (L1 < 0),
   L1 = L1 + 1/2;
end;

if (L2 < 0),
   L2 = L2 + 1/2;
end;