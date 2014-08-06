% TRISTUBS Provides  the stub  lengths  LT1, near the load, LT3 near
%          the  generator and LT2 between the others. 
%
%	       [LT1,LT2,LT3] = TRISTUBS(ZL,ZO,ZD,D1,D2)
%
%          ZL, ZO  and  ZD  are the load, characteristic and desired
%          impedances, respectively.  D2 is the line lenght  between
%          the generator  and the third stub  and  D1 is  the length  
%          between  the load  and the second stub toward the genera-
%          tor. The  lengths are  given in guided wavelength whereas
%          the impedances are given in Ohms.
%

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [lt1,lt2,lt3] = tristubs(zl,zo,zd,d1,d2)

warning('off');
yin=zo/zd;
yl=zo/zl;
tgd1=tan(2*pi*d1);
yb=(yl+j*tgd1)/(1+j*yl*tgd1);
gb=real(yb)
go=csc(2*pi*d2)^2;

% Stub length lt2 
if gb <= go 
   lt1=0;
else
   lt1=0;   
end

% Stub length lt2 
lt2=fmin('stfun3',0,0.5,[0,1e-10],yb,yin,d2);  

% Stub length lt3
ybeq=yb-j/tan(2*pi*lt2);
tgd2=tan(2*pi*d2);
ya=(ybeq+j*tgd2)/(1+j*ybeq*tgd2);
lt3=fmin('stfun2',0,0.5,[0,1e-10],ya,yin,10);

[vswr,rho,zin]=dbstub(zl,zo,zd,lt2,lt3,d1,d2,0);
if vswr < 1 | vswr > 1.000001
   error('The network is not suitable! VSWR different of 1.');
end   
warning('on');