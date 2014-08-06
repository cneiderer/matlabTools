function Zout=term(Zin,Freq)
% Shunt impedance termination 
%
% Vectorises termination impedance Zin over frequency range Freq.
%
% Usage: Z3=term(Z,Freq)
%    
% Z.....Single value load impedance in ohms, real or complex
% Freq..Vector of frequencies over which Z is to be valid
%
% e.g.  Freq=[800,810,820,830] 
%       Z=(52+2*j)
%       Zload=term(Z,Freq)

% N.Tucker www.activefrance.com 2008

Zout=trl(50,Zin,0,Freq,1.0,0.0);   % Use trl.m to format impdance vector.



