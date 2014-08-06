function smith(Scale,Zo)
% Plot smith chart gridlines on linear axis set
% Default display is figure(1)
%
% Usage : smith(Scale,Zo)
%         
% Scale....Scale factor 0 < s < 1
% Zo.......Normalising impedance in Ohms 
%
% Once drawn the plot is held so impedance curves may be drawn
% using smdrawc(Zn,Zo,linetype).
%
% e.g.     smith(1,50)
%          smdrawc(Z2,50,'r-')
%
%          smith(1,75)
%          smdrawc(Z13,75,'g-')
%
% See Also  smdrawc.m smarker1.m sadmit.m scomb.b

% N.Tucker www.activefrance.com 2008

% Set up axes

figure(1);
clf;
axes('box','on');
axis('square');
V=[-1 1 -1 1];
V=V.*Scale;
axis(V);
axis off;
set(1,'color',[0.8,0.8,0.8])
chartname=sprintf(' Smith Chart  (Zo=%g Ohms)',Zo);
set(1,'name',chartname);
hold on;


% Outer Circle

theta=0:2*pi/60:(2*pi);
x=sin(theta);
y=cos(theta);
plot(x,y,'k-');          % Outer circle
plot([-1 1],[0,0],'b-'); % Horizontal line through chart


% Imag Circles
smsub2(150,Zo);   % j150 ohm etc...
smsub2(100,Zo);
smsub2(70,Zo);
smsub2(50,Zo);
smsub2(40,Zo);
smsub2(30,Zo);
smsub2(20,Zo);
smsub2(10,Zo);

% Real Circles
smsub1(150,Zo);   % 150 ohm etc...
smsub1(100,Zo);
smsub1(70,Zo);
smsub1(50,Zo);
smsub1(40,Zo);
smsub1(30,Zo);
smsub1(20,Zo);
smsub1(10,Zo);




