function s=vsdrawc(Z,Freq,Zo,linetype);
% VSWR trace 
%
% Plot additional VSWR trace on an existing plot in specified colour.
%
% Z.....Impedance vector (Ohms)
% Freq..Frequency list (MHz)
% Zo....Characteristic impedance (Ohms)
%
% Usage : vswrc(Z,Freq,Zo,linetype)
%
% e.g.  Freq=[800,810,820]
%       Zload=[51+3*j,42-3*j,40-4*j]
%       Zin=trl(35,Zload,44,Freq,2.2,0.1)
%       vswrc(Zload,Freq,50,'r-')
%       vsdrawc(Zin,Freq,50,'g-')

% N.Tucker www.activefrance.com 2008

hold on;
Zr=Z;
p=(Zr-Zo)./(Zr+Zo);
s=abs((1+abs(p))./(1-abs(p)));
plot(Freq,s,linetype,'LineWidth',2);
hold off;