function P1=phdrawc(Snn,Freq,Zo,linetype);
% Phase Delay trace
%
% Plot additional Phase Delay trace on existing plot in specified colour
%
% Usage : phdrawc(Snn,Freq,Zo,linetype)
%
% Snn......S-parameter (linear complex)
% Freq.....Frequency list (MHz)
% Zo.......Characteristic impedance (Ohms)
%       
% e.g.    phdelayc(S21,Freq,50,'r-')
%         phdrawc(S12,Freq,50,'g-') 

% N.Tucker www.activefrance.com 2008

hold on;
P1=angle(Snn).*180./pi;   % Phase Delay (Deg)
plot(Freq,P1,linetype,'LineWidth',2);
hold off;
