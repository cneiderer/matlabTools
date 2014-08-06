%SMITHCH   Plots  the Smith Chart with option to pinpoint normalized
%          impedances or admittances. The reflection coefficient and 
%          line length in wavelength are also provided.
%
%          SMITHCH(ZL,ZO,ZIN)  plots  the  VSWR  circle  for  a half 
%          wavelength line of characteristic impedance ZO terminated
%          by load impedance ZL. ZIN can be either scalar or vector.
%

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function hpol = smithch(zl,zo,zin)

if nargin ==0
    zl=75;
    zo=50;
    zin=50;
end

format short;
set(gcf,'Position',[100 50 1.5*560 1.5*420]);
set(gcf,'Color',[0.8 0.8 0.8]);
clf;
hold on;
fill([-1.0,-1.0,1.0,1.0],[1.0,-1.,-1.0,1.0],'k')

% Resistence circles
th=0:pi/100:2*pi;
for r=0:0.1:1.0,
    ro=1/(r+1);
    po=1-ro;
    p=ro*cos(th)+po;
    q=ro*sin(th);
    plot(p,q,'g');
end
for r=1.2:0.2:2,
    ro=1/(r+1);
    p=ro*cos(th);
    q=ro*sin(th);
    po=1-ro;
    plot(p+po,q,'g');
end
for r=3:1:5,
    ro=1/(r+1);
    p=ro*cos(th);
    q=ro*sin(th);
    po=1-ro;
    plot(p+po,q,'g');
end
for r=5:5:20,
    ro=1/(r+1);
    p=ro*cos(th);
    q=ro*sin(th);
    po=1-ro;
    plot(p+po,q,'g');
end

% Reactance circles
tho=[1.5708 1.3884 1.2425 1.1164 1.0149];
n=1;
for x=1:0.2:1.8,
    th=tho(n)+pi/2:pi/100:3*pi/2;
    xo=1/x;
    p=xo*cos(th);
    q=xo*sin(th);
    plot(p+1,q+xo,'y');
    plot(p+1,-q-xo,'y');  
    n=n+1;
end
tho=[0.9290 0.8551 0.7917 0.7309 0.6850 0.6442];
n=1;
for x=2:0.2:3.0,
    th=tho(n)+pi/2:pi/100:3*pi/2;
    xo=1/x;
    p=xo*cos(th);
    q=xo*sin(th);
    plot(p+1,q+xo,'y');
    plot(p+1,-q-xo,'y');  
    n=n+1;
end
tho=[0.4907 0.3917 0.3307 0.2822 0.2484 0.2241 0.2008];
n=1;
for x=4:1:10,
    th=tho(n)+pi/2:pi/100:3*pi/2;
    xo=1/x;
    p=xo*cos(th);
    q=xo*sin(th);
    plot(p+1,q+xo,'y');
    plot(p+1,-q-xo,'y');  
    n=n+1;
end
th=pi:pi/1000:3*pi/2;
lth=length(th);
for x=0.1:0.1:0.9,
    xo=1/x; 
    p=xo*cos(th)+1;
    q=xo*sin(th)+xo;
    r=sqrt(p.^2+q.^2);
    [err,n]=min(abs(1-r(1:lth-1)));
    q=q(n:lth);
    p=p(n:lth);
    plot(p,q,'y');
    plot(p,-q,'y');  
end

th=pi:pi/3:2*pi;
plot(cos(th),[0 0 0 0],'y');
plot(0,0,'wx')   
xp=[0,0.2,0.2,0];
yp=[-0.05,-0.05,0.05,0.05];

% Labels
text(0,1.12,'SMITH CHART','horizontalalignment','center');

xl1=-1.45;
xl2=-1.35;
text(xl1,0.95, 'r (g)','horizontalalignment','center');
text(xl1,0.80, 'x (b)','horizontalalignment','center');
text(xl1,0.65,'|\rho|','horizontalalignment','center');
text(xl1,0.5,'\phi','horizontalalignment','center');
text(xl1,0.35,'l','horizontalalignment','center');
text(xl1,0.2,'SWR','horizontalalignment','center');
xl1=-1.65;
text(xl2,0.95, '=','horizontalalignment','center');
text(xl2,0.8, '=','horizontalalignment','center');
text(xl2,0.65,'=','horizontalalignment','center');
text(xl2,0.5,'=','horizontalalignment','center');
text(xl2,0.35,'=','horizontalalignment','center');
text(xl2,0.2,'=','horizontalalignment','center');



% VSWR at the load;
th=0:pi/100:2*pi;
mrhl=abs((zl-zo)/(zl+zo));
plot(mrhl*cos(th),mrhl*sin(th),'-m');

% Impedance plot
zn=zin/zo;
rho=(zin-zo)./(zin+zo);
p=real(rho);
q=imag(rho);
plot(p,q,'c');

% Plot control
set(1,'Name','Smith Chart');
axis('equal');
axis([-1.5 1.0 -1.0 1.0]);
axis('off');

% Point detection and capture
l=0.000;
sl=num2str(l);
x=0;
y=0;
rho=0;
xr1=-1.3;
uicontrol('Style','pushbutton','Units','normalized','Position',[.19 .11 .08 .05],'String','Exit')
while sqrt(x^2+y^2) < 1.01,
     rho=x+j*y;      
     rhom=abs(rho);
     rhop=angle(rho)*180/pi;
     swr=(1+rhom)/(1-rhom);
     l=0.25-rhop/720;
     zin=(1+rho)/(1-rho);
     rn=real(zin);
     xn=imag(zin);
     sr=num2str(round(rn*1000)/1000);
     sx=num2str(round(xn*1000)/1000);
     srhom=num2str(round(rhom*1000)/1000);   
     srhop=num2str(round(rhop*100)/100);   
     sl=num2str(round(l*1000)/1000);
     sswr=num2str(round(swr*100)/100);
     fill(xr1+xp,0.95+yp,'w');
     fill(xr1+xp,0.8+yp,'w');
     fill(xr1+xp,0.65+yp,'w');
     fill(xr1+xp,0.5+yp,'w');
     fill(xr1+xp,0.35+yp,'w');    
     fill(xr1+xp,0.2+yp,'w');   
   
     text(xr1+0.01,0.95,sr,'horizontalalignment','left');
     text(xr1+0.01,0.8,sx,'horizontalalignment','left');
     text(xr1+0.01,0.65,srhom,'horizontalalignment','left');
     text(xr1+0.01,0.5,srhop,'horizontalalignment','left');
     text(xr1+0.01,0.35,sl,'horizontalalignment','left');
     text(xr1+0.01,0.2,sswr,'horizontalalignment','left');
     [x,y]=ginput(1);   
 end      

hold off;     

