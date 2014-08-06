function Zout=s2z(S,Zo)
% Convert S-parameter to complex impedance Z 
%
% Usage: Zout=s2z(S,Zo)
%    
% S.....S-param, as returned by citi1s.m and citi2s.m
% Zo....Characteristic impedance
%
% e.g.  [Start,Stop,Points,S11]=citi1s('c:\matlab\toolbox\rfutils\data01.d1')
%       Zin=s2z(S11,50)

% N.Tucker www.activefrance.com 2008

Zout=((1+S)./(1-S)).*Zo;



