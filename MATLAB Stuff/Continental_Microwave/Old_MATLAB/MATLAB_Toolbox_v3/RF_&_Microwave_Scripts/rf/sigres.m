% SIGRES  Function to plot the signal response of a complex system
% 
%    SIGRES (x, y) plots the magnitude of the signal response of the system
%			which created Y when given X.
%
function[] = sigres(x,y)
[txy,f]=tfe(x,y);
plot(-pi:2*pi/(length(f)-1):pi,20*log10(abs(fftshift(txy))));
