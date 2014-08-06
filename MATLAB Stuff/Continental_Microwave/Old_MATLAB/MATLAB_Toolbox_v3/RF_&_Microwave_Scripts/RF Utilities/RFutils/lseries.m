function Zout=lseries(Z,L,Freq)
% Series Inductor
%
% Adds series inductance L Henries to impedance Z
% over frequency range Freq and returns Zout.
%
% Usage: Zout=lseries(Z,L,Freq)
%
% Z.....Impedance vector (ohms)
% L.....Series Inductance (Henries)
% Freq..Frequency list (Mhz)
%
% e.g.   Z1=50;
%        Z2=trl(35,Z1,length,Freq,Er,LdB);
%        Z3=lseries(Z2,L,Freq);

% N.Tucker www.activefrance.com 2008

w=2.*pi.*Freq.*1e6;
Zind=j.*w.*L;            % Calc impedance of L (jwL)

Zout=Z+Zind;
