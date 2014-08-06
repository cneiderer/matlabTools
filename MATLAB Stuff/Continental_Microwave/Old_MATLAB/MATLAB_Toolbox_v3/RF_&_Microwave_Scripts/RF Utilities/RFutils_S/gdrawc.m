function Grp=gdrawc(Snn,Freq,Zo,linetype);
% Phase Delay trace
%
% Plot additional Group Delay trace on existing plot in specified colour
%
% Usage : gdrawc(Snn,Freq,Zo,linetype)
%
% Snn......S-parameter (linear complex)
% Freq.....Frequency list (MHz)
% Zo.......Characteristic impedance (Ohms)
%        
% e.g.    gdelayc(S21,Freq,50,'r-')
%         gdrawc(S12,Freq,50,'g-') 

% N.Tucker www.activefrance.com 2008

hold on;

[Row,Col]=size(Freq);
Freq1=Freq(1,2:(Col));   % Match Freq vector length to the differential
                         % vector Grp. (With one less data point) 
                         
Pha=(unwrap(angle(Snn)).*180./pi);        % Unwrap the phase data
Grp=-(diff(Pha)./(diff(Freq.*1e6)))./360; % Calc grp-dly d(pha)/d(freq)

plot(Freq1,Grp,linetype,'LineWidth',2);

hold off;
