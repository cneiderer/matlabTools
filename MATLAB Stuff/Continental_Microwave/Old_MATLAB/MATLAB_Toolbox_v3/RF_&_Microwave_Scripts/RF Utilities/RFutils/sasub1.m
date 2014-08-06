function smsub1(mS,Yo)
% Admittance Chart Subroutine1
% Draws circles on the real axis radius r at locn (1-r,0)
%
% mS....Admittance circle to be drawn
% Yo....Normalising admittance
%
% Called by sadmit.m

% N.Tucker www.activefrance.com 2008

p=(mS-Yo)/(mS+Yo);           % Calculate reflection coefficient
r=(1-p)/2;		     % Calculate circle radius

theta=0:2*pi/60:(2*pi);
x=-r*sin(theta);             % X-plot vector
y=-r*cos(theta);	     % Y-plot vector
plot((r-x-1),y,'b-');        % Plot circle, centre (r-1,0)


xl=2*r-0.99;                  % x-coord for impedance label
yl=0;                         % y coord for impedance label
lbl=sprintf('%g',real(mS));   % assemble the string for printing
text(xl,yl,lbl,'FontWeight','bold');

