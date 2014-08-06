function sadmit(Scale,Zo)
% Plot admittance chart gridlines on linear axis set.
% Default display is figure(2)
%
% Usage : sadmit(Scale,Zo)
%         
% Scale....Scale factor 0 < s < 1
% Zo.......Normalising impedance in Ohms
%
% (Yo=1/Zo)  Yo=20mS for Zo=50ohm
%
% Once drawn the plot is held so impedance curves may be drawn
% using smdraw(Zn).
%
% e.g.     sadmit(1,50)
%          smdraw(Z2,50)
%
%          sadmit(1,75)
%          smdraw(Z13,75)

% N.Tucker www.activefrance.com 2008


Yo=(1./Zo)*1000;  % Convert impedance to conductance in mS

% Set up axes

figure(2);
clf;
axes('box','on');
axis('square');
V=[-1 1 -1 1];
V=V.*Scale;
axis(V);
axis off;
set(2,'color',[0.8,0.8,0.8]);
chartname=sprintf(' Admittance Chart  ( Zo=%g Ohms / Yo=%g mS)',Zo,Yo);
set(2,'name',chartname);
hold on;


% Outer Circle

theta=0:2*pi/60:(2*pi);
x=sin(theta);
y=cos(theta);
plot(x,y,'k-');          % Outer circle
plot([-1 1],[0,0],'b-'); % Horizontal line through chart


% Imag Circles
sasub2(100,Yo);   % j100 mS etc...
sasub2(50,Yo);
sasub2(30,Yo);
sasub2(20,Yo);
sasub2(15,Yo);
sasub2(10,Yo);
sasub2(5,Yo);

% Real Circles
sasub1(100,Yo);   % 100 mS etc...
sasub1(50,Yo);
sasub1(30,Yo);
sasub1(20,Yo);
sasub1(15,Yo);
sasub1(10,Yo);
sasub1(5,Yo);






