function L1=ildrawc(Snn,Freq,Zo,linetype);
% Mismatch Loss trace
%
% Plot additional Mismatch Loss trace on existing plot in specified colour
%
% Usage : ildrawc(Snn,Freq,Zo,linetype)
%         
% e.g.    ilossc(S21,Freq,50,'r-')
%         ildrawc(S12,Freq,50,'g-') 

% N.Tucker www.activefrance.com 2008

hold on;
L1=20.*log10(abs(Snn));      % Insertion loss dB
plot(Freq,L1,linetype,'LineWidth',2);
hold off;
