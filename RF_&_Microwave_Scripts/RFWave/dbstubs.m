% DBSTUBS  Provides the stub lengths  LT1 near the load and LT2 near
%          the  generator.  
%
%	       [LT1,LT2] = DBSTUBS(ZL,ZO,ZD,D1,D2)
%
%          ZL, ZO  and  ZD  are the load, characteristic and desired
%          impedances, respectively.  D2 is the line lenght  between
%          the stubs and  D1 is the length  between the load and the 
%          first stub toward  the generator. The  lengths are  given
%          in  guided wavelength whereas the impedances are given in
%          Ohms.
%

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [lt1,lt2] = dbstubs(zl,zo,zd,d1,d2)

warning('off');
yin=zo/zd;
yl=zo/zl;
tgd1=tan(2*pi*d1);
yb=(yl+j*tgd1)/(1+j*yl*tgd1);
gb=real(yb);
go=csc(2*pi*d2)^2;
if gb <= go 
   % Stub length lt1 
   g=inline('abs(real(((yb-j/tan(2*pi*x))+j*tan(2*pi*d2))/(1+j*(yb-j/tan(2*pi*x))*tan(2*pi*d2)))-real(yin))','x','yb','yin','d2');
   lt1=fminbnd(g,0,0.5,optimset('TolX',1e-12,'Display','off'),yb,yin,d2);

   % Stub length lt2
   ybeq=yb-j/tan(2*pi*lt1);
   tgd2=tan(2*pi*d2);
   ya=(ybeq+j*tgd2)/(1+j*ybeq*tgd2);
   g=inline('abs(imag(-j./(tan(2*pi*x)+eps))+imag(ya)-imag(yin))','x','ya','yin');
   lt2=fminbnd(g,0,0.5,optimset('TolX',1e-12,'Display','off'),ya,yin);
else
   error('It is impossible to design a double stub network for these ZL and D1.')
end
[vswr,rho,zin]=dbstub(zl,zo,zd,lt1,lt2,d1,d2,0);
if vswr < 1 | vswr > 1.000001
   error('The network is not suitable! VSWR different of 1.');
end     
warning('on');