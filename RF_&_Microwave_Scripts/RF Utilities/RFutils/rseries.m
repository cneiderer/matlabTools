function Zout=rseries(Z,R,Freq)
% Series Resistor 
%
% Adds series resistance R Ohms to impedance Z
% over frequency range Freq and returns Zout.
%
% Usage: Zout=rseries(Z,R,Freq)
%
% Z.....Impedance vector (ohms)
% R.....Series resistance (ohms)
% Freq..Frequency list (Mhz)
%
% e.g.   Z1=50;
%        Z2=trl(35,Z1,length,Freq,Er,LdB);
%        Z3=rseries(Z2,R,Freq);

% N.Tucker www.activefrance.com 2008

Zout=Z+R;



