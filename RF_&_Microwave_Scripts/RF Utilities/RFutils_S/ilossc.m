function L1=ilossc(Snn,Freq,Zo,linetype);
% Plot Insertion Loss
%
% Plot Insertion Loss (dB) as a function of frequency (match rel to Zo Ohms)
% Default display is figure(7)
%
% Usage : ilossc(Snn,Freq,Zo,linetype)
%
% Snn......S-parameter (linear complex)
% Freq.....Frequency list (MHz)
% Zo.......Characteristic impedance (Ohms)
%
%    e.g. [S11,S21,S12,S22,Freq]=loads2p(pathname)
%         ilossc(S21,Freq,50,'g-')

% N.Tucker www.activefrance.com 2008

figure(7);
clf;
chartname=sprintf(' Insertion Loss  (Zo=%g)',Zo);
set(7,'name',chartname);

hold off;
L1=20.*log10(abs(Snn));      % Insertion loss dB

plot(Freq,L1,linetype,'LineWidth',2);
grid;
title(chartname);
xlabel('Frequency MHz');
ylabel('Loss dB');

axis('square');
V=[min(Freq),max(Freq),-40,0];
axis(V);
