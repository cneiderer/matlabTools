function Zout=rshunt(Z,R,Freq)
% Shunt Resistance
%
% Adds shunt resistance R ohms to impedance Z,
% over frequency range Freq and returns Zout.
%
% Usage: Zout=rshunt(Z,R,Freq)
%
% Z.....Impedance vector (ohms)
% R.....Shunt resistance (Ohms)
% Freq..Frequency list(Mhz)
%
% e.g.   Z1=52+3*j;
%        Z2=trl(35,Z1,length,Freq,Er,LdB);
%        Z3=rshunt(Z2,R,Freq);

% N.Tucker www.activefrance.com 2008

Zout=((Z.*R)./(Z+R));


