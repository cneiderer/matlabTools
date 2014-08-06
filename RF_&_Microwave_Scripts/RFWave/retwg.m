% RETWG    Provides the cutoff frequency  FC in GHz, modal impedance 
%          ZM, attenuation ATT in dB and guided wavelength LBG im cm
%          for a rectangular waveguide.
%
%	       [FC,ZM,ATT,LBG] = RETWG(A,B,L,MODE,ER,F0,SGR)
%
%          A and B  are the cross section dimensions in  mm  (A > B) 
%          and  L is  the  waveguide  length in m.  MODE  should  be 
%          provided as a string, i.e. 'TE10', 'TM11', etc. ER is the
%          relative  dielectric  constant  of the  medium inside the 
%          waveguide and FO the excitation frequency in GHz. Finally,  
%          SGR  is the relative condutivity  in terms of the  copper  
%          condutivity  (5.8 x 10^7 S/m). If SGR is not provided the
%          copper condutivity is assumed as default.

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [fc,zm,att,lbg] = retwg(a,b,l,mode,er,fo,sgr)

a=a*1e-3;
b=b*1e-3;
eo=8.82e-12;
mo=4*pi*1e-7;
sigma=5.8e7;
c=3e8; 
vf=c/sqrt(er);
fo=fo*1e9;
lbd=vf./fo;
eta=120*pi/sqrt(er);

if nargin > 6
    sigma=sigma*sgr;
end

if a == 0
   error('A cannot be zero.');
elseif b == 0
   error('B cannot be zero.');
elseif er < 1
   error('ER must be greater than one.');
end

% Mode definition
if strncmp(mode,'TE',2)
    mn=str2num(strrep(mode,'TE',''));
elseif strncmp(mode,'TM',2)
    mn=str2num(strrep(mode,'TM','')); 
else
   error('The mode must be either TE or TM.'); 
end
n=rem(mn,10);
m=(mn-n)/10;

% Wavelength numbers and propagation constant 
w=2*pi*fo;
kc=sqrt((m*pi/a)^2+(n*pi/b)^2);
ko=w./vf;
beta=sqrt(ko.^2-kc^2);

% Cutoff wavelength and cutoff frequency 
lbc=2*pi./kc;
fc=vf./lbc;

% Guided wavelength and modal tranverse impedance
lbr2=(lbd/lbc).^2;
aux=sqrt(1-lbr2);
lbg=lbd./aux;
if strncmp(mode,'TE',2)
    zm=eta/aux;
else
    zm=eta*aux;
end

% Attenuation factor and attenuation in dB
A=b*zm;
Rc=sqrt(w*mo/2/sigma);
if strncmp(mode,'TE',2)
    if m==0
        dm=1;
    else
        dm=2;
    end
    if n==0
        dn=1;
    else
        dn=2;
    end
    alpha=Rc./A.*((dn+dm*b/a)*lbr2+aux*(dn*m^2*b^2+dm*n^2*a*b)/(m^2*b^2+n^2*a^2)); 
else
    alpha=2*Rc./A*(m^2*b^3+n^2*a^3)/(m^2*b^2*a+n^2*a^3);
end
att=8.686*alpha*l;

% Output
fc=fc*1e-9;
lbg=lbg*1e2;






