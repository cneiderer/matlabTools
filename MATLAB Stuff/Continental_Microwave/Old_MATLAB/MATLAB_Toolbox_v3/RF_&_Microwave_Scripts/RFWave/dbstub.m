% DBSTUB   Provides VSWR, reflection coefficient and input impedance
%          for Double-Stub Matching Network.
%
%	       [VSWR,RHO,ZIN] = DBSTUB(ZL,ZO,ZD,LT1,LT2,D1,D2,BW)
%
%          ZL, ZO  and  ZD  are the load, characteristic and desired
%          impedances, respectively. D2  is the line lenght  between
%          the stubs and  D1 is the length  between the load and the 
%          first stub toward the generator. LT1 is the length of the  
%          stub near the load and LT2 is the length of the stub near
%          the generator whereas BW is the bandwidth. Values of  LT1
%          and LT2 must be normalized in terms of wavelength and  BW
%          should be given in percentage.
%
 
% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [vswr,rho,zin] = dbstub(zl,zo,zd,lt1,lt2,d1,d2,bw)

if nargin < 8 
   fn=1;
else
    if bw==0
        fn=1;
    else
        bw=bw/100;
        bw2=bw/2;
        fn=1-bw2:bw/100:1+bw2;
    end
end;

yd=zo/zd;
yl=zo/zl;
beta=2*pi*fn;
tgd1=tan(beta*d1);
yb=(yl+j*tgd1)./(1+j*yl*tgd1);
tgblt=tan(beta*lt1);
ytc=-j./(tgblt+eps);
yeqb=yb+ytc;
tgd2=tan(beta*d2);
ya=(yeqb+j*tgd2)./(1+j*yeqb.*tgd2);  
tgblt=tan(beta*lt2);
ytc=-j./(tgblt+eps);
y=ya+ytc;
rho=(yd-y)./(conj(yd)+y)*yd/conj(yd);
mrho=abs(rho);
vswr=(1+mrho)./(1-mrho);
zin=zo./y; 
