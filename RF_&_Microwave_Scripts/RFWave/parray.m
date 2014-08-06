% PARRAY   Provides  the  radiation  intensity  for a uniform planar
%          array in three different planes:  UAZX for zx-plane, UAZY
%          for zy-plane and UAXY for xy-plane.
%
%          [UAZY,UAZY,UAXY] = PARRAY(UZX,UZY,UXY,DX,DY,BTX,BTY,M,N)
%
%          UZX, UZY and UXY  are  the radiation intensity vectors of 
%          the elements in the planes  ZX, ZY and XY,  respectively.
%          DX  and  DY  are  the  spacing  interval  in  the x and y  
%          directions, respectively.  BTX  and  BTY are the  feeding  
%          phase  difference  between  elements  in  the   x  and  y 
%          directions, respectively. Finally, M and N are the number 
%          of elements in x and y directions, respectively.
%

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [uazx,uazy,uaxy]=plnarray(uelzx,uelzy,uelxy,dx,dy,betax,betay,m,n)

betax=pi*betax/180;
betay=pi*betay/180;
format long
k=2*pi;
lue=length(uelzx)/2;
th=pi/lue:pi/lue:2*pi;

% Plane zx (phi = 0)
psix=k*dx*sin(th)+betax;
psiy=betay+eps;
if n==0
    fay=pi/2*ones(1,400);
else
    fay=(sin(n*psiy/2)./(n*sin(psiy/2))).^2;
end
if m==0
    fax=pi/2*ones(1,400);
else
    fax=(sin(m*psix/2)./(m*sin(psix/2))).^2;
end
u=uelzx.*fax.*fay;
uazx=u/max(u);

% Plane zy (phi = 90)
psix=betax+eps;
psiy=k*dy*sin(th)+betay;
if n==0
    fay=pi/2*ones(1,400);
else
    fay=(sin(n*psiy/2)./(n*sin(psiy/2))).^2;
end
if m==0
    fax=pi/2*ones(1,400);
else
    fax=(sin(m*psix/2)./(m*sin(psix/2))).^2;
end
u=uelzy.*fax.*fay;
uazy=u/max(u);

% Plane xy (theta = 90)
psix=k*dx*cos(th)+betax;
psiy=k*dy*sin(th)+betay;
if n==0
    fay=pi/2*ones(1,400);
else
    fay=(sin(n*psiy/2)./(n*sin(psiy/2))).^2;
end
if m==0
    fax=pi/2*ones(1,400);
else
    fax=(sin(m*psix/2)./(m*sin(psix/2))).^2;
end
u=uelxy.*fax.*fay;
uaxy=u/max(u);


