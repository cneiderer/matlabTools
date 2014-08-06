% GAUSSSQNR  Function to calculate SQNR of A/D converter with Gaussian input
% 
%    GAUSSSQNR (L, MQL, STD) calculates the SQNR of an L-level A/D converter
%        with maximum quantization level 'MQL' and a Gaussian input with 
%        standard deviation 'STD'.  Answer is in dB.

function [SQNR] = GaussSQNR(L, MQL, STD);

L = round(L);
delta = 2 * MQL / (L - 1);
alpha = delta / STD;

if (iseven(L)),
	QNSR = 1 - 2/sqrt(2*pi)*alpha*(L-1)*exp(-(L/2-1)^2*alpha^2/2);
	QNSR = QNSR + (L-1)^2/4*alpha^2*erfc((L/2-1)*alpha/sqrt(2));

	for num = 0:(L/2-2),
   	QNSR = QNSR + alpha^2*(2*num+1)^2/4*(erf((num+1)*alpha/sqrt(2)) - erf(num*alpha/sqrt(2)));
   	QNSR = QNSR - 2/sqrt(2*pi)*alpha*(2*num+1)*exp(-num^2*alpha^2/2)*(1-exp(-alpha^2/2*(2*num+1)));
	end;
end;

if (isodd(L)),
	QNSR = 1 - 2/sqrt(2*pi)*alpha*(L-1)*exp(-L^2*alpha^2/8);
	QNSR = QNSR + (L-1)^2/4*alpha^2*erfc(L/2*alpha/sqrt(2));

	for num = 1:round(L/2-1/2),
   	QNSR = QNSR + alpha^2*num^2*(erf((num+1/2)*alpha/sqrt(2)) - erf((num-1/2)*alpha/sqrt(2)));
   	QNSR = QNSR + 4/sqrt(2*pi)*alpha*num*exp(-(num^2+1/4)*alpha^2/2)*(exp(-alpha^2/2*num)-exp(alpha^2/2*num));
	end;
end;

SQNR = 10*log10(1/QNSR);