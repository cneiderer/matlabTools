% ZOIMP    Provides  the  characteristic impedance  and  attenuation 
%          factor (in dB/m) for  three types  of transmission lines:
%          coaxial, twin-line and microstrip line.
%
%	       [Z0,ALPHA] = ZOIMP(TYPE,A,B,ER,LTAN,F0)
%
%          TYPE is the line option: 1 for coaxial, 2 twin-line and 3 
%          for  microstrip. ER  the dielectric constant and LTAN the 
%          loss tangent. The frequency is given in MHz.
% 
%          A and B are  respectively:  inner  and  outter  conductor 
%          diameter (coaxial), wire radius and spacing  between  the 
%          two  wires  (twin-line), and  strip  width and  substrate
%          thickness.

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [zo,alpha] = zoimp(type,a,b,er,ltan,fo)

eo=8.82e-12;
mo=4*pi*1e-7;
sigma=5.8e7;
c=3e8; 
fo=fo*1e6;

if a == 0
   error('A cannot be zero.');
elseif b == 0
   error('B cannot be zero.');
elseif er < 1
   error('ER must be greater than one.');
end
p=b/a;
er2=er*ltan;
w=2*pi*fo;
rm=sqrt(pi*fo*mo/sigma);
if type == 1  
   zo=60*log(p)/sqrt(er);
   res=rm*(b+a)/(2*pi*a*b);
elseif type == 2
   zo=120*acosh(p/2)/sqrt(er);
   res=2*rm*p/(pi*a*sqrt(p^2-1));
elseif type == 3
   ef=(er+1)/2+(er-1)/(2*sqrt(1+12/p));
   if p <= 1
      ca=2*pi/log(8/p+p/4);
      ef=ef+0.02*(er-1)*(1-p)^2;      
   else
      ca=p+1.393+0.667*log(p+1.444);
   end
   zo=120*pi/(sqrt(ef)*ca);
else
   error('TYPE must be 1, 2 or 3.');
end;
if type == 3
   alfd=w*er*(ef-1)*ltan/(2*c*sqrt(ef)*(er-1));
   if p <= 0.5
      lr=1;
   else
      lr=0.94+0.132*p-0.0062*p^2;
   end;
   r1=1000*rm*lr*(1/pi+1/pi^2*log(4*pi*b/0.02))/b;
   r2=1000*rm*p/(p+5.8+0.03/p)/b;
   alfc=0.5*(r1+r2)/zo;
   alpha=-20*log10(exp(-(alfd+alfc))); 
else
   cap=sqrt(mo*eo*er)/zo;
   ind=sqrt(mo*eo*er)*zo;
   con=w*ltan*cap;
   alfd=w*sqrt(mo*eo/er)*er2/2;
   alfd=con*zo/2;
   alfc=res/(2*zo);
   alpha=-20*log10(exp(-(alfd+alfc)));
end