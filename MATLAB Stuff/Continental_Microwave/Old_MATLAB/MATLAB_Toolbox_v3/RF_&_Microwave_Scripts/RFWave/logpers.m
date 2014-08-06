% LOGPERS  Provides  the  number of elements,  the total length,  the 
%          length  of each element,  the spacing  among elements, the
%          radius  of  each  element  and  the  feeding line spacing-
%          diameter ratio for a  log-periodic antenna.  All dimension 
%          are given in meters.
%
%	       [N, LT, L, D, A, S] = LOGPERS(GA,FMIN,FMAX, ZIN)
%
%          GA  is  the antenna gain in  dBi. FMIN  and  FMAX  are the
%          minimum   and  maximum frequencies respectively wheras Zin 
%          is  the antenna input  impedance. Frequency values must be
%          provided in  MHz.  The antenna  gain have to be within the 
%          interval 5.5 < GA < 13 dB.

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [N,L,l,d,a,s] = logpers(ga,fmin,fmax,zin)

if ga>13 | ga<5.5
    error('The antenna gain must be within the interval 5.5 < GA < 13 dB.');
end

% Gain matrix
mga=[  7.0  7.2  7.5  8.0  8.3  8.0  7.5  7.0  5.5;
       7.2  7.4  7.7  8.2  8.4  8.3  7.9  7.3  6.1;
       7.3  7.6  7.9  8.3  8.6  8.6  8.2  7.6  6.5;
       7.6  7.8  8.2  8.4  8.8  8.9  8.6  8.0  7.3;
       7.9  8.1  8.4  8.7  9.0  9.2  9.1  8.5  7.8;
       8.3  8.6  8.8  9.0  9.3  9.6  9.5  9.0  8.5;
       8.7  8.9  9.1  9.4  9.6 10.0 10.0  9.7  9.2;
       9.1  9.3  9.5  9.8 10.2 10.7 10.9 10.5 10.1;
       9.5  9.7 10.0 10.4 11.0 11.5 11.7 11.5 10.9;
      10.0 10.4 10.6 11.1 11.6 12.3 13.2 12.5 11.5];
% Tal and sigma 
vtal=[0.80 0.82 0.84 0.86 0.88 0.90 0.92 0.94 0.96 0.98];
%vsg=[0.06 0.08 0.10 0.12 0.14 0.16 0.18 0.20 0.22];
[value,inx]=min(min(abs(mga'-ga)));
tal=vtal(inx);
sg=0.258*tal-0.066;

% Number of elements
alfa=atan(0.25*(1-tal)/sg);
bs=fmax/fmin*(1.1+7.7*(1-tal)^2*cot(alfa));
N=round(1-log(bs)/log(tal));

% Total length, element lengths and spacing
l(N)=150/fmin;
r(N)=0.5*l(N)/tan(alfa);
for i=N-1:-1:1,
    l(i)=l(i+1)*tal;
    r(i)=r(i+1)-2*sg*l(i+1);
end
L=r(end)-r(1);
d=-r(1:N-1)+r(2:N);

% Element diameters and radii
de(1)=0.01;
for i=1:N-1,
    de(i+1)=de(i)/tal;
end
a=de/2;

% Feeding line spacing-diameter ratio
Za=120*log(l(1)/de(1))-2.55;
sgl=sg/sqrt(tal);
A=zin/8/sgl/Za;
Zo=zin*(A+sqrt(A^2+1));
s=0.5*exp(Zo/120);


