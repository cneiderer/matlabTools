% MSTRIP   Provides the ratio line width - substrate thickness W and
%          the effective permittivity EEFF for a microstrip line.
%
%	       [W, EEFF] = MSTRIP(ZO,ER)
%
%          ZO is the characteristic  impedance and  ER the substrate
%          relative permittivity.

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [wh, eeff] = mstrip(zo,er)

eo=8.82E-12;
mo=4*pi*1E-7;
sigma=5.8E7;
c=3E8; 
p=er+1;
q=er-1;
if zo > (44-2*er) 
   aux=q/p*(log(pi/2)+log(4/pi)/er);
   hl=zo*sqrt(2*p)/119.9+0.5*aux;
   wh=1/(exp(hl)/8-1/(4*exp(hl))); 
   eeff=p/2*(1+29.98/zo*sqrt(2/p)*aux)^2;
else
   d=59.95*pi^2/zo/sqrt(er);
   wh=2/pi*((d-1)-log(2*d-1))+q/(pi*er)*(log(d-1)+0.293-0.517/er);
   eeff=er/(0.96+er*(0.109-0.004*er)*(log10(10+zo)-1));
end
