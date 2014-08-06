function T1=mlossc(Z,Freq,Zo,linetype);
% Plot Mismatch Loss
%
% Plot Mismatch Loss (dB) as a function of frequency (match rel to Zo Ohms)
% Default display is figure(6)
%
% Usage : mlossc(Z,Freq,Zo,linetype)
%
%    e.g. mlossc(Z,Freq,50,'r-')

% N.Tucker www.activefrance.com 2008

figure(6);
clf;
chartname=sprintf(' Mismatch Loss  (Zo=%g)',Zo);
set(6,'name',chartname);

hold off;
Zr=Z;
p=(Zr-Zo)./(Zr+Zo);
s=(1+abs(p))./(1-abs(p));
T1lin=(1-(abs(p)).^2).^0.5; % Transmisson loss (linear)
T1=20.*log10(T1lin);        % Transmisson loss (dB)

plot(Freq,T1,linetype,'LineWidth',2);
grid;
title(chartname);
xlabel('Frequency MHz');
ylabel('Loss dB');

axis('square');
V=[min(Freq),max(Freq),-40,0];
axis(V);
