function T1=mldrawc(Z,Freq,Zo,linetype);
% Mismatch Loss trace
%
% Plot additional Mismatch Loss trace on existing plot in specified colour
%
% Usage : mldrawc(Z,Freq,Zo,linetype)
%         
% e.g.  mldrawc(Z1,Freq,Zo,'g-') 

% N.Tucker www.activefrance.com 2008

hold on;
Zr=Z;
p=(Zr-Zo)./(Zr+Zo);
s=(1+abs(p))./(1-abs(p));
R1=real(20.*log10(p));     % Rloss dB
LinPwr=10.0.^(R1./10);     % Linear Ratio Of Reflected Power
TransPwr=1-LinPwr;         % Transmitted Power
T1=10.0.*log10(TransPwr);  % Trans dB
plot(Freq,T1,linetype,'LineWidth',2);
hold off;
