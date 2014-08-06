% SINGLESTUBRESPONSE  Computes the frequency response of a single-stub match
%
%	[GammaIn] = SINGLESTUBRESPONSE(Z0, Zl, D, L, f, f0, STUBTYPE) 
%      STUBTYPE is either 'short' or 'open'
%      D and L are the distance from the load and the length, in terms 
%        of wavelength at the normal frequency f0
%      Zl is a string holding an expression for Zl in terms of f
%

function [GammaIn] = singlestubresponse (Z0, Zl, D, L, f, f0, STUBTYPE);

ZlF = eval(Zl);
DF = D*f/f0;
LF = L*f/f0;

Zd = Z0*(ZlF+j*Z0*tan(2*pi*DF))./(Z0+j*ZlF.*tan(2*pi*DF));

switch lower(STUBTYPE)
  case 'short', Zs = Z0.*j.*tan(2*pi*LF);
  case 'open', Zs = Z0./j./tan(2*pi*LF);
  otherwise, error('Bad stub type');
end;     

Zml = Zd.*Zs./(Zd + Zs);

GammaIn = (Z0 - Zml)./(Z0 + Zml);
