% CYLCAV   Provides  the  resonance  frequency  FR  in  GHz  and the   
%          quality  factor  Q  for a  cylindrical  cavity  operating  
%          either in the mode TElmn or TMlmn.
%
%	       [FR,Q] = CYLCAV(A,D,MODE,ER,SGR)
%
%          A  is the cavity radius and  D its length in mm. The MODE 
%          should  be provided  as a string, i.e.  'TE112', 'TM211', 
%          etc. ER is the relative dielectric constant of the medium 
%          inside the cavity  and  SGR is  the relative  condutivity
%          of  the cavity walls  in terms of the  copper condutivity 
%          (5.8 x 10^7 S/m). If SGR is not provided then  the copper 
%          condutivity isassumed as default.

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [fr,q] = cylcav(a,d,mode,er,sgr)

a=a*1e-3;
d=d*1e-3;
eo=8.82e-12;
mo=4*pi*1e-7;
sigma=5.8e7;
c=3e8; 
vf=c/sqrt(er);
eta=120*pi/sqrt(er);
ptm=[2.405  5.52   8.654 11.792 14.931;
     3.832  7.016 10.173 13.324 16.471;
     5.136  8.417 11.62  14.796 17.960;
     6.38   9.761 13.015 16.224 19.409;
     7.588 11.065 14.373 17.616 20.827];
 
pte=[3.832  7.016 10.173 13.324 16.471;
     1.841  5.332  8.537 11.701 14.863;
     3.054  6.706  9.969 13.17  16.347;
     4.201  8.015 11.345 14.585 17.788;
     5.317  9.282 12.681 15.964 19.196];  
if nargin > 5
    sigma=sigma*sgr;
end

if a == 0
   error('A cannot be zero.');
elseif d == 0
   error('D cannot be zero.');
elseif er < 1
   error('ER must be greater than one.');
end

% Mode definition and Bessel's function roots
if strncmp(mode,'TE',2)
    lmn=str2num(strrep(mode,'TE',''));
    mn=rem(lmn,100);
    n=rem(mn,10);
    m=(mn-n)/10;
    if n == 0
        error('n cannot be zero in TElmn.');
    end
    pmn=pte(m+1,n);
    l=(lmn-mn)/100;
    
elseif strncmp(mode,'TM',2)
    lmn=str2num(strrep(mode,'TM',''));
    mn=rem(lmn,100);
    n=rem(mn,10);
    m=(mn-n)/10;
        m=(mn-n)/10;
    if n == 0
        error('n cannot be zero in TMlmn.');
    end
    pmn=ptm(m+1,n);
    l=(lmn-mn)/100;
else
   error('The mode must be either TE or TM.'); 
end

% Wave number
kc=pmn/a;
kr=sqrt(kc^2+(l*pi/d)^2);

% Resonance frequency 
lbr=2*pi/kr;
fr=vf/lbr;
w=2*pi*fr;

% Quality factor
dlt=sqrt(2/w/mo/sigma);
aux0=lbr/2/pi/dlt;
aux1=(l*pi*a/d)^2;
aux2=2*a/d;
aux3=(m/pmn)^2;
aux4=pmn^2;
if strncmp(mode,'TE',2)
    q=aux0*(1-aux3)*(aux4+aux1)^1.5/(aux4+aux2*aux1+(1-aux2)*aux3*aux1);
else 
    if l==0
        q=aux0*pmn/(1+a/d);
    else
        q=aux0*sqrt(aux4+aux1)/(1+a/d);
    end
end 

% Output
fr=fr*1e-9;







