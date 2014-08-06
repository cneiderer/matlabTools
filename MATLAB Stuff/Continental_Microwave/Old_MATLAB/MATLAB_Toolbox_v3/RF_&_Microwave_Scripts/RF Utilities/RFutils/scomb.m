function scomb(Scale,Zo)
% Plot smith chart and admittance gridlines on linear axis set.
% Default is display is figure(3)
%
% Usage : scomb(Scale,Zo)
%         
% Scale....Scale factor 0 < s < 1
% Zo.......Normalising impedance in Ohms 
%
% Once drawn the plot is held so impedance curves may be drawn
% using smdrawc(Zn,Zo,linetype).
%
% e.g.     scomb(1,50)
%          smdrawc(Z2,50,'r-')
%
%          scomb(1,75)
%          smdrawc(Z13,75,'g-')
%
% See Also  smdrawc.m

% N.Tucker www.activefrance.com 2008

% Set up axes

figure(3);
clf;
axes('box','on');
axis('square');
V=[-1 1 -1 1];
V=V.*Scale;
axis(V);
axis off;
set(3,'color',[0.8,0.8,0.8])
chartname=sprintf(' Smith / Admittance Chart  (Zo=%g)',Zo);
set(3,'name',chartname);
hold on;


% Outer Circle

theta=0:2*pi/60:(2*pi);
x=sin(theta);
y=cos(theta);
plot(x,y,'k-');          % Outer circle
plot([-1 1],[0,0],'b-'); % Horizontal line through chart


% Imag Circles
scsub2(200,Zo);   % j200 ohm circle
scsub2(100,Zo);   % j100 ohm etc...
scsub2(75,Zo);
scsub2(50,Zo);
scsub2(35,Zo);
scsub2(25,Zo);
scsub2(12.5,Zo);

% Real Circles
scsub1(200,Zo);  % 200 ohm circle
scsub1(100,Zo);  % 100 ohm etc...
scsub1(75,Zo);
scsub1(50,Zo);
scsub1(35,Zo);
scsub1(25,Zo);
scsub1(12.5,Zo);




