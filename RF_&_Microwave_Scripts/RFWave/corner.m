% CORNER   Provides  the  antenna  gain  GA (in dBi),  the radiation
%          intensities  UE (E-plane) and  UH (H-plane)  for a corner
%          reflector. 
%
%          [UE, UH, GA] = CORNER(D,ALPHA,UEF,UHF)
%
%          D is the spacing between the reflector vertex and feeder,  
%          in wavelength, ALPHA is aperture angle in degree. UEF and
%          UHF  are the feeder radiation intensities in the  E-plane 
%          and  H-plane,  respectively.  Isotropic  feeder  will  be 
%          assumed if UEF and UHF are not provided.
%

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [ue,uh,ga]=corner(d,alfa,uef,uhf)


if nargin < 3
    lue=200;
    luh=lue;
    uer=1;
    uhr=1;
elseif nargin < 4
    lue=length(uef)/2;
    luh=200;
    uer=uef(1:lue);
    uhr=1;
else
    lue=length(uef)/2;
    luh=length(uhf)/2;
end

% Radiation Intensities
ue=zeros(1,400);
uh=zeros(1,400);
alfa=alfa*pi/180;
k=2*pi;
phi=pi/luh:pi/luh:alfa/2;
lphi=length(phi);
th=pi/2;
uh(1:lphi)=(uhr.*(cos(k*d*sin(th)*cos(phi))-cos(k*d*sin(th)*sin(phi)))).^2;
uh(end-lphi+1:end)=fliplr(uh(1:lphi));
phi=0;
th=pi/lue:pi/lue:pi;
ue(1:lue)=(uer.*(cos(k*d*sin(th)*cos(phi))-cos(k*d*sin(th)*sin(phi)))).^2;
uh=uh/max(uh);
ue=ue/max(ue);

% Antenna Gain
intth=trapz(th,ue(1:lue).*sin(th));
intphi=trapz(pi/luh:pi/luh:2*pi,uh);
d=4*pi/intth/intphi;
ga=10*log10(d);
