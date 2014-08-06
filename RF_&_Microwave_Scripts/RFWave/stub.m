% STUB     Provides VSWR, reflection coefficient and input impedance
%          for a  terminated transmission line with  a shunt stub at
%          the input terminals.
%
%	       [VSWR, RHO, ZIN] = STUB(ZL,ZO,ZD,L,LT,ST,BW)
%
%          ZL, ZO  and  ZD  are the load, characteristic and desired
%          impedances, respectively. L is the line length, LT is the 
%          stub length whereas BW is the bandwidth. Values  of L and
%          LT must be  normalized in  terms  of  wavelength  and  BW 
%          should be given in percentage. 
%        				
%          ST=10 means short-circuit stub near the generator; 
%          ST=11 means open-circuit stub near the generator;
%          ST=20 means short-circuit stub near the load; 
%          ST=21 means open-circuit stub near the load.  

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [vswr, rho, zin] = stub(zl,zo,zd,l,lt,st,bw)

if nargin < 7 
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
yl=zo/zl;
yd=zo/zd;
beta=2*pi*fn;
tgblt=tan(beta.*lt);
if st == 11 | st == 21
   yt=j*tgblt;
else
   yt=-j./(tgblt+eps);
end;
tgbl=tan(beta*l);
if st == 11 | st == 10
   yeq=(yl+j*tgbl)./(1+j*yl*tgbl);
   y=yeq+yt;
elseif st == 21 | st == 20 
   yeq=yl+yt;
   y=(yeq+j*tgbl)./(1+j*yeq*tgbl);
else
   error('ST must be 10, 11, 20 or 21.');
end
rho=(yd-y)./(conj(yd)+y)*yd/conj(yd);
mrho=abs(rho);
vswr=(1+mrho)./(1-mrho);
zin=zo./y;
