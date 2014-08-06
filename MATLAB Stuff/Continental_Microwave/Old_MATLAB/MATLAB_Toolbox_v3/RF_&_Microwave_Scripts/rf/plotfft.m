% PLOTFFT  Function to plot FFT
% 
%    PLOTFFT (samples, fs, vpp) plots the magnitude of the FFT of samples, normalizing
%       the frequency axis to the sampling rate fs and the magnitude to vpp.
% 
%    PLOTFFT (samples, fs, vpp, 'WINDOW') first multiplies by an appropriate
%       window (bartlett, blackman, boxcar, hamming, hanning, or kaiser).
%       The kaiser window requires beta as a fourth input.
%
%       If the samples are complex, distinction is made between positive and negative 
%       frequencies.

function [] = sd_fft(samples, fs, vpp, varargin);

complex = 0;
if (iscmplx(samples)==1),
   complex = 1;
end;

NFFT=2.^(ceil(log(length(samples))/log(2)));

if (complex == 0),
	NumUniquePts = ceil((NFFT+1)/2);
	f=(0:NumUniquePts-1)*fs/NFFT;
end;

if (complex == 1),
	f=(-(NFFT/2):NFFT/2-1)*fs/NFFT;
end;

A = fftamp(samples, fs, f, varargin{:})*2/vpp;

plot(f, dbV(A));

