% L1PSD Script to plot the theoretical power spectrum of the GPS L1 signal

% Set the reference level
ref = -130;

%Set the thermal noise level
noise = -111;

f = 1500:0.01:1650;
CA = sinc((1575.42 - f)/1.023).^2./1.023;
P = sinc((1575.42 - f)/10.23).^2./10.23;

L1 = (CA + P/2);

plot(f, dbP(L1) + ref, 'b', f, noise*ones(1,length(f)), 'r');

axis ([1550 1600 ref-50 noise+5]);
title('Theoretical GPS L1 Signal Spectrum');
xlabel('Frequency (MHz)');
ylabel('Received Power dBm');
grid;