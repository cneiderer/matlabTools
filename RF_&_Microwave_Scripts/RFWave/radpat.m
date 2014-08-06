
% RADPAT   Plots the antenna's radiation pattern using the radiation 
%          intensity U.
%
%	       RADPAT(U,TYPE)
%
%          TYPE sets the graphic scale and label:
%
%          11 - Logarithm, UdB = 10*log(Un) (Plano E);
%          12 - Logarithm, UdB = 10*log(Un) (Plano H);
%          21 - Linear,    En = sqrt(Un)    (Plano E);
%          22 - Linear,    En = sqrt(Un)    (Plano H).
%
%	       See also PLOT, LOGLOG, SEMILOGX, SEMILOGY.

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function hpol = radpat(u,type)

clf;
set(gcf,'Color',[0.95 0.95 0.95]);
hold on;
% Concentric circles
th=0:pi/50:2*pi;
x=cos(th);
y=sin(th);
plot(x,y,'k',0.8*x,0.8*y,'k',0.6*x,0.6*y,'k')
plot(0.4*x,0.4*y,'k',0.2*x,0.2*y,'k');
if type == 11 | type == 12
   plot(0.94*x,0.94*y,'m')
else
   plot(0.7071*x,0.7071*y,'m')
end
axis('equal');

% Axis and labels
th=0:pi/50:pi;
x=cos(th);
x0=zeros(length(x));
x30=cos(pi/6:pi/50:5*pi/6);
x60=cos(pi/3:pi/400:2*pi/3);
y30=tan(pi/6)*x30;
y60=tan(pi/3)*x60;
plot(x0,x,'k',x,x0,'k');
plot(x30,y30,'k',x30,-y30,'k');
plot(x60,y60,'k',x60,-y60,'k');
text(1.05,0,'90','Fontsize',14);
text(0.92,0.55,'60','Fontsize',14);
text(0.55,0.92,'30','Fontsize',14);
text(-0.02,1.08,'0','Fontsize',14);
text(-0.7,0.92,'-30','Fontsize',14);
text(-1.05,0.55,'-60','Fontsize',14);
text(-1.2,0,'-90','Fontsize',14);
text(-1.1,-0.55,'-120','Fontsize',14);
text(-0.8,-0.92,'-150','Fontsize',14);
text(-0.1,-1.1,'180','Fontsize',14);
text(0.55,-0.92,'150','Fontsize',14);
text(0.92,-0.55,'120','Fontsize',14);

if type == 11 | type == 21
   text(1.2,-1.1,'E Plane','horizontalalignment','center','Fontsize',14);

else
    text(1.2,-1.1,'H Plane','horizontalalignment','center','Fontsize',14);

end

text(-0.8,1.1,'Radiation Pattern','horizontalalignment','center','Fontsize',14);

% Radiation pattern plot
lth=length(u);
th=0:2*pi/(lth-1):2*pi;
if type == 11 | type == 12
   u=10*log10(u+0.00001);
   umin=abs(min(u));
   u=1+u./umin;
else
   u=sqrt(u);
end
x=u.*cos(th-pi/2);
y=-u.*sin(th-pi/2);
plot(x,y,'b');
axis('off');
hold off;
