% SIMPLE_GM  Function to find transconductance given drain current or overdrive voltage
% 
%    [GM, Ids] = SIMPLE_GM ('Vod', Vod, W, L, Mu0, Cox)
%
%    [GM, Vod] = SIMPLE_GM ('Ids', Ids, W, L, Mu0, Cox)
%
%    For the HP 0.5um process NMOS, Mu0=0.04479 (m^2/(V*s)), Cox=3.6E-3 (F/m^2)
%
%    For the HP 0.5um process PMOS, Mu0=0.01670 (m^2/(V*s)), Cox=3.6E-3 (F/m^2)
% 

function [GM, OUT] = SIMPLE_GM(mode, IN, W, L, Mu0, Cox);

mstate = 0;

switch lower(mode),
	case 'ids', mstate = 0;
   case 'vod', mstate = 1;
   otherwise, error('Invalid Mode');
end;

if (mstate == 0),
   OUT = sqrt(2*IN/Mu0/Cox*L/W);
   GM = sqrt(2*Mu0*Cox*W/L*IN);
end;

if (mstate == 1),
   OUT = 0.5*Mu0*Cox*W/L*IN^2;
   GM = Mu0*Cox*W/L*IN;
end;
