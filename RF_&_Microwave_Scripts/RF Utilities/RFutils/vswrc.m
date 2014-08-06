function s=vswrc(Z,Freq,Zo,linetype);
% VSWR Plot
%
% Plot VSWR as a function of frequency.
% Default display is on figure(4)
%
% Z.....Impedance vector (Ohms)
% Freq..Frequency list (MHz)
% Zo....Characteristic impedance (Ohms)
%
% Usage : vswrc(Z,Freq,Zo,linetype)
%
% e.g.  Z=[51+3*j,42-3*j,40-4*j]
%       Freq=[800,810,820]
%       vswrc(Z,Freq,50,'b-')

% N.Tucker www.activefrance.com 2008

figure(4);
clf;
hold off;
chartname=sprintf(' VSWR Plot  (Zo=%g)',Zo);
set(4,'name',chartname);

Zr=Z;
p=(Zr-Zo)./(Zr+Zo);
s=abs((1+abs(p))./(1-abs(p)));
plot(Freq,s,linetype,'LineWidth',2);
grid;
title(chartname);
xlabel('Frequency MHz');
ylabel('Voltage Standing Wave Ratio');
axis('square');
V=[min(Freq),max(Freq),1,10];
axis(V);
