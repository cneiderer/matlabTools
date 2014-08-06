% TRISTUB  Provides VSWR, reflection coefficient and input impedance
%          for Triple-Stub Matching Network.
%
%	       [VSWR,RHO,ZIN] = TRISTUB(ZL,ZO,ZD,LT1,LT2,LT3,D1,D2,BW)
%
%          ZL, ZO  and  ZD  are the load, characteristic and desired
%          impedances, respectively.  D2 is the line lenght  between
%          the stubs and D1 is the length  between the load and  the 
%          first stub toward the generator. LT3 is the length of the
%          stub on the load impedance, LT1 is the length of the stub  
%          near the load and  LT2 is the length of the stub near the
%          generator whereas BW is the bandwidth. Values of LT1, LT2
%          and LT3  must be normalized in terms of wavelength and BW
%          should be given in  percentage.  All stubs are considered 
%          short circuited.
%          

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil


function [vswr,rho,zin] = tristub(zl,zo,zd,lt1,lt2,lt3,d1,d2,bw)

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

beta=2*pi*fn;
yd=zo/zd;
tgb3t=tan(beta*lt3);
yl=zo/zl-j./(tgb3t+eps);;help
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
