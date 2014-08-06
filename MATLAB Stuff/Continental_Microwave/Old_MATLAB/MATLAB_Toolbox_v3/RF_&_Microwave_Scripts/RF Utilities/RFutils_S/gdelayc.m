function Grp=gdelayc(Snn,Freq,Zo,linetype);
% Plot Group Delay
%
% Plot Group Delay as a function of frequency
% Default display is figure(9)
%
% Usage : gdelayc(Snn,Freq,Zo,linetype)
%
% Snn......S-parameter (linear complex)
% Freq.....Frequency list (MHz)
% Zo.......Characteristic impedance (Ohms)
%
%    e.g. [S11,S21,S12,S22,Freq]=loads2p(pathname)
%         gdelayc(S21,Freq,50,'g-')

% N.Tucker www.activefrance.com 2008

figure(9);
clf;
chartname=sprintf(' Group Delay  (Zo=%g)',Zo);
set(9,'name',chartname);

hold off;
[Row,Col]=size(Freq);
Freq1=Freq(1,2:(Col));   % Match Freq vector length to the differential
                         % vector Grp. (With one less data point) 
                         
Pha=(unwrap(angle(Snn)).*180./pi);        % Unwrap the phase data
Grp=-(diff(Pha)./(diff(Freq.*1e6)))./360; % Calc grp-dly d(pha)/d(freq)

plot(Freq1,Grp,linetype,'LineWidth',2);

grid;
title(chartname);
xlabel('Frequency MHz');
ylabel('Delay Secs');

axis('square');
%V=[min(Freq),max(Freq),-180,180];
%axis(V);
