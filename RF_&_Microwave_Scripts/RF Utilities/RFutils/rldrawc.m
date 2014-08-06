function R1=rldrawc(Z,Freq,Zo,linetype);
% Return Loss trace
%
% Plot additional Return Loss trace on existing plot in specified colour
%
% Usage : rlossc(Z,Freq,Zo,linetype)
%         
% e.g.  rldrawc(Z1,Freq,Zo,'g-') 
%           

% N.Tucker www.activefrance.com 2008

hold on;
Zr=Z;
p=(Zr-Zo)./(Zr+Zo);
s=(1+abs(p))./(1-abs(p));
R1=20.*log10(abs(p));
plot(Freq,R1,linetype,'LineWidth',2);
hold off;