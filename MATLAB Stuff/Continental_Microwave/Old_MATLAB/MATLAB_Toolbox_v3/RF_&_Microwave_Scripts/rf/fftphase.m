% FFTPHASE  Function to find phase of a particular frequency from an FFT
% 
%    [P] = FFTPHASE (samples,fs,f0) calculates the phase of the signal at f0 by
%       performing an FFT of the samples.
%
%    [P] = FFTPHASE (samples,fs,f0,window) multiplies by the chosen window before 
%       performing the FFT.  The Kaiser window requires that a value for K be
%       given as the fifth argument.
% 
%       If the samples are complex, distinction is made between positive and negative 
%       frequencies

function [P] = fftamp(samples, fs, f0, varargin);

complex = 0;
if (iscmplx(samples)==1),
   complex = 1;
end;

if (size(samples,1)==1),
	samples = transpose(samples);
end;   

l = length(samples);
W = boxcar(l);
if nargin > 3,
  	switch lower(varargin{1})
  		case 'bartlett', W = bartlett(l);
		case 'blackman', W = blackman(l);
  		case 'boxcar', W = boxcar(l);
  		case 'hamming', W = hamming(l);
  		case 'hanning', W = hanning(l);
  		case 'kaiser', W = kaiser(l, varargin(2)); 
     	otherwise, W = boxcar(l);   
  	end;
end; 

samples = samples .* W;

% Next highest power of 2 greater than or equal to
% length(samples):

NFFT=2.^(ceil(log(length(samples))/log(2)));

if (complex == 0),
	if (f0 > fs/2) | (f0 < 0),
  		warning('Invalid f0');
	end;

	% Take fft, padding with zeros, length(FFTX)==NFFT
	FFTX=fft(samples,NFFT);
   
   PX=angle(FFTX);            % Take phase of X

	f=(0:NFFT-1)*fs/NFFT;

	P = interp1(f,PX,f0);
end;

if (complex == 1),
	if (abs(f0) > fs/2),
  		warning('Invalid f0');
	end;

	% Take fft, padding with zeros, length(FFTX)==NFFT
	FFTX=fftshift(fft(samples,NFFT));
	PX=angle(FFTX);            % Take phase of X

	f=(-(NFFT/2):NFFT/2-1)*fs/NFFT;

	P = interp1(f,PX,f0);
end;