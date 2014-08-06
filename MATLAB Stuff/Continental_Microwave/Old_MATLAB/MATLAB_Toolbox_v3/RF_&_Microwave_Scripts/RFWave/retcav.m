% RETCAV   Provides  the  resonance  frequency  FR  in  GHz and  the   
%          quality  factor  Q  for a rectangular cavity operating in
%          the mode TElm0.
%
%	       [FR,Q] = RETCAV(A,B,D,L,M,ER,SGR)
%
%          A, B and D  are the cavity dimensions in  mm (D > A > B).
%          L, and M are integers correspondent to the number of half 
%          wavelenght along the direction  D and A, respectively. ER 
%          is the relative  dielectric constant of the medium inside 
%          the cavity and  SGR is the relative condutivity  in terms
%          of the copper condutivity (5.8 x 10^7 S/m). If SGR is not 
%          provided  then  the  copper  condutivity  is  assumed  as 
%          default.
%

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [fr,q] = retcav(a,b,d,l,m,er,sgr)

a=a*1e-3;
b=b*1e-3;
d=d*1e-3;
eo=8.82e-12;
mo=4*pi*1e-7;
sigma=5.8e7;
c=3e8; 
vf=c/sqrt(er);
eta=120*pi/sqrt(er);

if nargin > 6
    sigma=sigma*sgr;
end

if a == 0
   error('A cannot be zero.');
elseif b == 0
   error('B cannot be zero.');
elseif d == 0
   error('B cannot be zero.');
elseif er < 1
   error('ER must be greater than one.');
end

% Wave number and resonance wavelength
kr=sqrt((l*pi/d)^2+(m*pi/a)^2);
lbr=2*pi/kr;

% Resonance frequency 
fr=vf/lbr;
w=2*pi*fr;

% Quality factor
dlt=sqrt(2/w/mo/sigma);
vol=a*b*d;
aux1=(l*a/m/d)^2;
aux2=1+aux1;
q=vol/dlt*aux2/(2*d*b+a*d*aux2+2*a*b*aux1);

% Output
fr=fr*1e-9;







