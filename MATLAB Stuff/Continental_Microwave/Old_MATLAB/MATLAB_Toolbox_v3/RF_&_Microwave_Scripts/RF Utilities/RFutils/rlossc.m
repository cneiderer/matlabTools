function R1=rlossc(Z,Freq,Zo,linetype);
% Return Loss Plot
%
% Plot Return Loss as a function of frequency
% Default display is figure(5)
%
% Usage : rlossc(Z,Freq,Zo,linetype)
%
%    e.g. rlossc(Z,Freq,50,'r')

% N.Tucker www.activefrance.com 2008

figure(5);
clf;
chartname=sprintf(' Return Loss  (Zo=%g)',Zo);
set(5,'name',chartname);

Zr=Z;
p=(Zr-Zo)./(Zr+Zo);
s=(1+abs(p))./(1-abs(p));
R1=20.*log10(abs(p));
plot(Freq,R1,linetype,'LineWidth',2);
grid;

title(chartname);
xlabel('Frequency MHz');
ylabel('Return Loss dB');

axis('square');
V=[min(Freq),max(Freq),-40,0];
axis(V);
