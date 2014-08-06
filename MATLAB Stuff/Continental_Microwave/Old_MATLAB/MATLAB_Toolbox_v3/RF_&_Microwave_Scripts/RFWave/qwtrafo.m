% QWTRAFO  Provides VSWR, reflection coefficient and input impedance
%          for a N cascaded quarter-wavelength transformers.
%
%	       [VSWR, RHO, ZIN] = QWTRAFO(ZL,ZO,ZD,BW)
%
%          ZL, ZO  and  ZD  are the load, characteristic and desired
%          impedances, respectively. Whereas  BW is the bandwidth in 
%          percentage. ZO is a vector with length N.

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [vswr,rho,zin] = qwtrafo(zl,zo,zd,bw)

n=length(zo);
if bw == 0
   fni=1;
   fns=1;
   dfn=1;
else
   bw=bw/100;
   bw2=bw/2;
   fni=1-bw2;
   fns=1+bw2;
   dfn=bw/100;
end;
k=0;
for fn=fni:dfn:fns,
    k=k+1;
    beta=2*pi*fn;
    z=zl;
    for i=n:-1:1,    
        if beta == pi/2
           z=zo(i).^2/z;
        else
           tgbl=tan(beta*0.25);
           z=zo(i)*(z+j*zo(i)*tgbl)/(zo(i)+j*z*tgbl);
        end
    end
    zin(k)=z;    
    rho(k)=(z-zd)./(z+conj(zd))*conj(zd)/zd;
    mrho=abs(rho(k));
    vswr(k)=(1+mrho)./(1-mrho);
end
