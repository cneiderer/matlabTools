% NETMATCH provides design parameters for one stage RF amplifier.
%
%	       [Gp,Gmax,K,F,ZS,ZL] = NETMACH(SPV,NPV,OPT)
%
%          Gp, Gmax, K and F  are the power gain, maximum avaliable, 
%          stability factor and noise figure, respectively. All  are
%          given in  dB,  except K which is adimensional.  ZS and ZL
%          are the matching impedancies for the source and load net-
%          works.  Source and load impedancies are equal to 50 Ohms.
%
%          SPV = [ mS11 pS11 mS21 pS21 mS12 pS12 mS22 pS22 ]  is the
%          transistor S parameter vector. mSij is the magnitude  and 
%          pSij is the angle (in degree) of the Sij parameter.
%
%          NPV = [ Fmin mRHOm pRHOm Rn ] is the transistor noise pa-
%          rameter vector.  Fmin  is the minimum noise figure in dB, 
%          mRHO and  pRHO are the magnitude and phase of the optimum
%          reflection coefficient,  and  Rn is  the normalized noise 
%          resistor.
%
%          The OPT parameter is optional.  If  OPT = 'Fmin'  then ZS 
%          and ZL are calculated for minimum noise figure.

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002,
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil


function [Gp,Gmax,K,F,Zs,Zl] = netmatch(spv,npv,opt)

% Matrix S e determinante de S
Smag=vec2mat(spv(1:2:end),2)';
Sfase=vec2mat(spv(2:2:end),2)';
S=Smag.*exp(j*Sfase/180*pi);
detS = det(S);

% Parametro de ruido
if not(isempty(npv))
    mrhom=npv(2);
    frhom=npv(3);
    rhom=mrhom*exp(j*frhom*pi/180);
    Fm=npv(1);
    Rn=npv(4); 
end

if nargin < 3
% Coeficientes rhos e rhol para maximo ganho
    A1=1+Smag(1,1)^2-Smag(2,2)^2-(abs(detS))^2;
    A2=1+Smag(2,2)^2-Smag(1,1)^2-(abs(detS))^2;
    B1=S(1,1)-detS*conj(S(2,2));
    B2=S(2,2)-detS*conj(S(1,1));
    if A1>0
        rhos=(A1-sqrt(A1^2-4*(abs(B1))^2))/2/B1;
    else
        rhos=(A1+sqrt(A1^2-4*(abs(B1))^2))/2/B1;
    end
    if A2>0
        rhol=(A2-sqrt(A2^2-4*(abs(B2))^2))/2/B2;
    else
        rhol=(A2+sqrt(A2^2-4*(abs(B2))^2))/2/B2;
    end
else
% Coeficientes rhos e rhol para figura de ruido minima
    if isempty(npv)
        error('Please, enter noise parameter vetor npv');
    else
        rhos=rhom;
        rhol=conj(S(1,2)*S(2,1)*rhos/(1-S(1,1)*rhos)+S(2,2));
    end
end

% Impedancias equivalentes dos circuitos de casamento, Zs e Zl
Zs=50*(1+rhos)/(1-rhos);
Zl=50*(1+rhol)/(1-rhol);

% Ganho maximo de potencia 
gp=(1-abs(rhol)^2)*Smag(2,1)^2/(abs(1-S(2,2)*rhol)^2-abs(S(1,1)-detS*rhol)^2);
Gp=10*log10(gp+eps);

% Paramentro K
K=(1-Smag(1,1)^2-Smag(2,2)^2+abs(detS)^2)/(2*abs(S(1,2)*S(2,1)));

% Ganho maximo estavel 
gms=abs(S(2,1)/S(1,2));

% Ganho maximo
if K<1
    Gmax=10*log10(gms);
else
    gma=gms*(K-sqrt(K^2-1));
    Gmax=10*log10(gma);
end

% Figura de ruido
if isempty(npv)
    F=[];
else  
    Fm=10^(Fm/10);
    F=Fm+4*Rn*abs(rhos-rhom)^2/(abs(1+rhom)^2*(1-abs(rhos)^2));
    F=10*log10(F);
end    
