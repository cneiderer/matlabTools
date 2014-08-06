% CYLWG    Provides the cutoff frequency  FC in GHz, modal impedance 
%          ZM, attenuation ATT in dB and guided wavelength LBG im cm
%          for a cylindrical waveguide.
%
%	       [FC,ZM,ATT,LBG] = CYLWG(A,L,MODE,ER,F0,SGR)
%
%          A  is the waveguide  radius in  mm and L its length in m. 
%          MODE should be provided as a string, i.e. 'TE01', 'TM11',
%          etc. ER is the relative dielectric constant of the medium
%          inside  the waveguide and  FO is the excitation frequency 
%          in GHz. Finally, SGR is the relative condutivity in terms 
%          of the copper condutivity (5.8 x 10^7 S/m). If SGR is not
%          provided the copper condutivity is assumed as default.

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil
function [fc,zm,att,lbg] = cylwg(a,L,mode,er,fo,sgr)

a=a*1e-3;
eo=8.82e-12;
mo=4*pi*1e-7;
sigma=5.8e7;
c=3e8; 
vf=c/sqrt(er);
fo=fo*1e9;
lbd=vf./fo;
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
elseif er < 1
   error('ER must be greater than one.');
end

% Mode definition and Bessel's function roots
if strncmp(mode,'TE',2)
    mn=str2num(strrep(mode,'TE',''));
    n=rem(mn,10);
    m=(mn-n)/10;
    if n == 0
        error('n cannot be zero in TEmn.');
    end
    pmn=pte(m+1,n);
    
elseif strncmp(mode,'TM',2)
    mn=str2num(strrep(mode,'TM',''));
    n=rem(mn,10);
    m=(mn-n)/10;
    if n == 0
        error('n cannot be zero in TMmn.');
    end
    pmn=ptm(m+1,n);
else
   error('The mode must be either TE or TM.'); 
end

% Wavelength numbers and propagation constant 
w=2*pi*fo;

kc=pmn/a;
ko=w/vf;
beta=sqrt(ko.^2-kc^2);

% Cutoff wavelength and cutoff frequency 
lbc=2*pi/kc;
fc=vf/lbc;

% Guided wavelength and modal tranverse impedance
lbr2=(lbd/lbc).^2;
aux=sqrt(1-lbr2);
lbg=lbd./aux;
if strncmp(mode,'TE',2)
    zm=eta/aux;
elseif strncmp(mode,'TM',2)
    zm=eta.*aux;
end

% Attenuation factor and attenuation in dB
Rc=sqrt(w*mo/2/sigma);
if strncmp(mode,'TE',2)
    alpha=Rc/a/zm*(lbr2+m^2/(pmn^2-m^2));
elseif strncmp(mode,'TM',2)
    alpha=Rc/a/zm;
end
att=8.686*alpha*L;

% Output
fc=fc*1e-9;
lbg=lbg*1e2;






