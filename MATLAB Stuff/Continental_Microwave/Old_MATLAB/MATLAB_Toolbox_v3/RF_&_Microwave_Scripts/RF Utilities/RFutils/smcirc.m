function smcirc(VSWR,linetype)
% VSWR circle
%
% Plots circle of constant VSWR on a smith chart in a specified colour.
%
% Usage : smcirc(VSWR,linetype)
%
% e.g.    smcirc(2,'b:')

% N.Tucker www.activefrance.com 2008

p=(VSWR-1)./(VSWR+1);
phi=0:.1256:2*pi;
x=abs(p).*cos(phi);
y=abs(p).*sin(phi);
plot(x,y,linetype);
