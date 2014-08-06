function smdrawc(Z,Zo,linetype)
% Smith Chart trace
%
% Plots complex Z on smith/admittance chart in a specified colour. 
%
% Usage : smdrawc(Z,Zo,linetype)
%
% Z.....Complex impedance vector to be plotted 
% Zo....Characteristic impedance in ohms 
%
% e.g.      Z=[(20+30*j),(30+40*j),(75+10*j)];
%           smdrawc(Z,50,'r-');
%
% See Also  smith.m sadmit.m

% N.Tucker www.activefrance.com 2008

p=(Z-Zo)./(Z+Zo);
phi=angle(p);
x=abs(p).*cos(phi);
y=abs(p).*sin(phi);
plot(x,y,linetype,'linewidth',2);
plot(x(1),y(1),'o','linewidth',2);

