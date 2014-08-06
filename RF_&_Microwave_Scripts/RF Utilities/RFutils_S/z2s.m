function Snn=z2s(Z,Zo)
% Convert complex impedance Z to S-parameter form 
%
% Usage: Snn=s2z(Z,Zo)
%    
% Z.....Complex impedance
% Zo....Characteristic impedance
%
% e.g.  S11=s2z(Zin,50);

% N.Tucker www.activefrance.com 2008

Snn=(Z-Zo)./(Z+Zo);



