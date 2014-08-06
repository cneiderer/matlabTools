function scsub1(ohms,Zo)
% Smith / Admittance Chart Subroutine1
% Draws circles on the real axis radius r at locn (1-r,0)
%
% ohms....Impedance circle to be drawn
% Zo......Normalising impedance
%
% Called by scomb.m

% N.Tucker www.activefrance.com 2008

p=(ohms-Zo)/(ohms+Zo);       % Calculate reflection coefficient
r=(1-p)/2;		     % Calculate circle radius

theta=0:2*pi/60:(2*pi);
x=-r*sin(theta);             % X-plot vector
y=-r*cos(theta);	           % Y-plot vector
plot(x+(1-r),y,'b-');        % Plot circle, centre (1-r,0)
plot((r-x-1),y,'b:');        % Plot circle, centre (r-1,0)

xl=1.01-2*r;                 % x-coord for impedance label
yl=0;                        % y coord for impedance label
lbl=sprintf('%g',ohms);      % assemble the string for printing
text(xl,yl,lbl,'FontWeight','bold');

