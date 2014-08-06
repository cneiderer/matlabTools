function Zout=cshunt(Z,C,Freq)
% Shunt Capacitance
%
% Adds shunt capacitance C Farads to impedance Z,
% over frequency range Freq and returns Zout.
%
% Usage: Zout=cshunt(Z,C,Freq)
%
% Z.....Impedance vector (ohms)
% C.....Series capacitance (Farads)
% Freq..Frequency list (Mhz)
%
% e.g.   Z1=52+3*j;
%        Z2=trl(35,Z1,length,Freq,Er,LdB);
%        Z3=cshunt(Z2,C,Freq);

% N.Tucker www.activefrance.com 2008

w=2.*pi.*Freq.*1e6;
Zcap=(-j)./(w.*C);    % Calc impedance of C (-j/wC)

Zout=((Z.*Zcap)./(Z+Zcap));    % Parallel Z & Zcap 
