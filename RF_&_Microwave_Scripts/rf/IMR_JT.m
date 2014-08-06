% IMR_JT File to generate an IMR plot such as that in Jantzi thesis, p. 22.

A_Error = [0.01;0.05;0.1;0.2;0.5;1;3;6];
A_Error = 10.^(A_Error./20);

P_Error = [0:0.01:5];
P_Error = P_Error * pi / 180;

axis([0 5 0 70]);
hold on;

for num = 1:length(A_Error),
	IMR = 1 + 2 * A_Error(num) / (1 + A_Error(num)^2)* cos(P_Error);
   IMR = IMR ./ (1 - 2 * A_Error(num) / (1 + A_Error(num)^2)* cos(P_Error));
	IMR = 10*log10(IMR);
   plot(P_Error*180/pi, IMR, 'r');
end;

title('Effects of Phase and Amplitude Errors on Image Rejection');
xlabel('Quadrature Phase Error (Degrees)');
ylabel('Image Rejection (dB)');
grid;