function Zout=cseries(Z,C,Freq)
% Series Capacitor 
%
% Adds series capacitance C Farads to impedance Z
% over frequency range Freq and returns Zout.
%
% Usage: Zout=cseries(Z,C,Freq)
%
% Z.....Impedance vector (ohms)
% C.....Series capacitance (Farads)
% Freq..Frequency list (Mhz)
%
% e.g.   Z1=52+3*j;
%        Z2=trl(35,Z1,length,Freq,Er);
%        Z3=cseries(Z2,C,Freq);

% N.Tucker www.activefrance.com 2008

w=2.*pi.*Freq.*1e6;
Zcap=(-j)./(w.*C);            % Calc impedance of C (-j/wC)
Zout=Z+Zcap;
