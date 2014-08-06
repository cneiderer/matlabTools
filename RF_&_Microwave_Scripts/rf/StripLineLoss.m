% STRIPLINELOSS  Calculate the attenuation of a stripline
% 
%    [alpha, alphaC, alphaD] = STRIPLINELOSS (EpsR, tandelta, sigma, Z0, W, H, T, f) 
%      EpsR is the relative dielectric constant
%      tandelta is the loss tangent of the dielectric
%      sigma is the conductivity of the metal
%      Z0 is the characteristic impedance of the stripline
%      W is the stripline width
%      H is the height above and below the ground planes
%      T is the metal thickness
%      f is the frequency of operation
%      

function [alpha, alphaC, alphaD] = STRIPLINELOSS (EpsR, tandelta, sigma, Z0, W, H, T, f) 

k0 = 2*pi*f/3.0E8;
alphaD = k0*sqrt(EpsR)*tandelta/2;
Mu0 =  1.2566e-006;
Rs = sqrt(pi*f*Mu0/sigma);

A = 1 + (2*W)/(H - T) + 1/pi*(H + T)/(H - T)*log((2*H - T)/T);
B = 1 + H/(0.5*W + 0.7*T)*(0.5 + 0.414*T/W + 1/2/pi*log(4*pi*W/T));

if (sqrt(EpsR)*Z0 < 120),
  alphaC = 2.7E-3*Rs*EpsR*Z0*A/30/pi/(H - T);  
else
  alphaC = 0.16*Rs*B/Z0/H;
end;

alpha = alphaC + alphaD;