% MUSTRIPLOSS  Calculate the attenuation of a microstrip line
% 
%    [alpha, alphaC, alphaD] = MUSTRIPLOSS (EpsR, EpsE, tandelta, sigma, Z0, W, f) 
%      EpsR is the relative dielectric constant
%      EpsE is the effective dielectric constant
%      tandelta is the loss tangent of the dielectric
%      sigma is the conductivity of the metal
%      Z0 is the characteristic impedance of the microstrip line
%      W is the microstrip width
%      f is the frequency of operation
%      

function [alpha, alphaC, alphaD] = MUSTRIPLOSS (EpsR, EpsE, tandelta, sigma, Z0, W, f) 

k0 = 2*pi*f/3.0E8;

if (EpsR ~= 1),
  alphaD = k0*EpsR*(EpsE - 1)*tandelta/2/sqrt(EpsE)/(EpsR - 1);
else
  % If EpsR = 1, above formula divides by zero, so simplify.
  alphaD = k0*tandelta/2; 
end;  

Mu0 =  1.2566e-006;
Rs = sqrt(pi*f*Mu0/sigma);
alphaC = Rs/Z0/W;
alpha = alphaC + alphaD;