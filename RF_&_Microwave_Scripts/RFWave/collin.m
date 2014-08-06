% COLLIN   Provides   the  radiation  intensities  UE  (E-plane) and   
%          UH  (H-plane), array gain  GA (in dBi) and element  input 
%          impedancies ZIN for a collinear dipole array. 
%
%          [UE, UH, GA, ZIN] = COLLIN(D,L,A,V)
%
%          D is the element spacing vector,  L is the element length 
%          vector, A  is  the  element radius and  V  is the feeding 
%          voltage vector. The  size  of  D must  be  the  number of 
%          elements minus one.  All dimensions have to be normalized
%          by the operating wavelength  and voltage must be provided
%          in volts. The spacing between elements is measured centre
%          to centre.
%

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [ue,uh,ga,zin] = collin(d,ld,a,vd)

%Calculo das Corrente e Impedancias

[zin,iin]=dipimp(d,ld,a,vd,2);
ne=length(ld);
prad=0.5*sum(real(zin).*abs(iin).^2);
s=zeros(1,ne);
k=2*pi;
kld=k*ld;
io=iin./(sin(kld/2)+eps);
id=sqrt(2*prad/73.13);
dt=sum(d);
dn=0;
s(1)=-dt/2;
for n=2:ne,
    dn=dn+d(n-1); 
    s(n)=dn-dt/2;
end

% Calculo dos Campos 
n=0;
for th=pi/200:pi/200:2*pi,
    n=n+1;
    psi=k*s*cos(th);
    eth(n)=abs(sum(io.*exp(j*psi).*(cos(kld/2*cos(th))-cos(kld/2))./sin(th)));
    ephi(n)=abs(sum(io.*exp(j*psi)));  
    ed(n)=abs(cos(pi/2*cos(th))./sin(th));  
end

% Dipolo de referencia;
edt=id*ed;
% Intensidade de Radiacao
uth=eth./edt;
etm=max(eth);
ue=(eth/etm).^2;
uphi=ephi/id;
epm=max(ephi);
uh=(ephi/epm).^2;

% Ganho da Antena

do=60*etm^2/prad;
ga=10*log10(do);




