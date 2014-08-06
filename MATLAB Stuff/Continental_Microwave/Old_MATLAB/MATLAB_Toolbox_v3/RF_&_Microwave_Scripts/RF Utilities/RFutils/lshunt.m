function Zout=lshunt(Z,L,Freq)
% Shunt Inductor 
%
% Adds shunt inductance of L Henries to impedance Z,
% over frequency range Freq and returns Zout.
%
% Usage: Zout=lshunt(Z,L,Freq)
%
% Z.....Impedance vector(ohms)
% L.....Shunt inductance (Henries)
% Freq..Frequency list(Mhz)
%
% e.g.   Z1=53+2*j;
%        Z2=trl(35,Z1,length,Freq,Er,LdB);
%        Z3=lshunt(Z2,L,Freq);

% N.Tucker www.activefrance.com 2008

w=2.*pi.*Freq.*1e6;
Zind=j.*w.*L;            % Calc impedance of L (jwL)

Zout=((Z.*Zind)./(Z+Zind));  