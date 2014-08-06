% TXLINE   Provides VSWR, reflection coefficient and input impedance
%          for a terminated transmission line.
%
%	       [VSWR, RHO, ZIN] = TXLINE(ZL,ZO,ZD,L,BW)
%
%          ZL, ZO  and  ZD  are the load, characteristic and desired
%          impedances, respectively. L is the line length whereas BW 
%          is the bandwidth. Values of L must be normalized in terms
%          of wavelength and BW should be given in percentage.            				

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [vswr, rho, zin] = txline(zl,zo,zd,l,bw)

if bw == 0
   fn=1;
else
   bw=bw/100;
   bw2=bw/2;
   fn=1-bw2:bw/100:1+bw2;
end;
beta=2*pi*fn;
tgbl=tan(beta*l);
zin=zo*(zl+j*zo.*tgbl)./(zo+j*zl.*tgbl);
rho=(zin-zd)./(zin+conj(zd))*conj(zd)/zd;
mrho=abs(rho);
vswr=(1+mrho)./(1-mrho);

