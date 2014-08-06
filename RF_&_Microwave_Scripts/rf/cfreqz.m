% CFREQZ  Function to plot pole-zero plot and transfer function of complex poles
%         and zeros
% 
%    CFREQZ (zeros, poles, k) plots the pole zero diagram and tranfer function specified
%         by the given poles and zeros, with gain k
%

function[]=cfreqz(zeros,poles,k);

subplot(2,1,1);
zplane(zeros,poles);

subplot(2,1,2);
freqs = -pi:2*pi/255:pi;
h = freqz(poly(zeros), poly(poles), freqs, 2*pi);
plot(freqs, 20 * log10(abs(h*k)));
grid on;
