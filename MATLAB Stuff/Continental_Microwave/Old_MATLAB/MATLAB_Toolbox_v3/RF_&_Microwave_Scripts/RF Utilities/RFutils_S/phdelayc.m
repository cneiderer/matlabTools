function P1=phdelayc(Snn,Freq,Zo,linetype);
% Plot Phase Delay
%
% Plot Phase Delay (deg) as a function of frequency
% Default display is figure(8)
%
% Usage : phdelayc(Snn,Freq,Zo,linetype)
%
% Snn......S-parameter (linear complex)
% Freq.....Frequency list (MHz)
% Zo.......Characteristic impedance (Ohms)
%
%    e.g. [S11,S21,S12,S22,Freq]=loads2p(pathname)
%         phdelayc(S21,Freq,50,'g-')

% N.Tucker www.activefrance.com 2008

figure(8);
clf;
chartname=sprintf(' Phase Delay  (Zo=%g)',Zo);
set(8,'name',chartname);

hold off;
P1=angle(Snn).*180./pi;   % Phase Delay (Deg)

plot(Freq,P1,linetype,'LineWidth',2);
grid;
title(chartname);
xlabel('Frequency MHz');
ylabel('Degrees');

axis('square');
V=[min(Freq),max(Freq),-180,180];
axis(V);
