% FFTAMP  Function to find amplitude of a particular frequency from an FFT
% 
%    [A] = FFTAMP (samples,fs,f0) calculates the magnitude of the signal at f0 by
%       performing an FFT of the samples.
%
%    [A] = FFTAMP (samples,fs,f0,window) multiplies by the chosen window before 
%       performing the FFT.  The Kaiser window requires that a value for K be
%       given as the fifth argument.
% 
%       If the samples are complex, distinction is made between positive and negative 
%       frequencies

function [A] = fftamp(samples, fs, f0, varargin);

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
      case 'hann', W = hann(l);
      case 'triang', W = triang(l);   
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
	NumUniquePts = ceil((NFFT+1)/2);

	% fft is symmetric, throw away second half
	FFTX=FFTX(1:NumUniquePts);
	MX=abs(FFTX);            % Take magnitude of X

	% Multiply by 2 to take into account the fact that we
	% threw out second half of FFTX above
	MX=MX*2;
	MX(1)=MX(1)/2;   % Account for endpoint uniqueness
	MX(length(MX))=MX(length(MX))/2;  % We know NFFT is even

	% Scale the FFT so that it is not a function of the 
	% length of x.
	MX=MX/l;

	f=(0:NumUniquePts-1)*fs/NFFT;

	A = interp1(f,MX,f0);
end;

if (complex == 1),
	if (abs(f0) > fs/2),
  		warning('Invalid f0');
	end;

	% Take fft, padding with zeros, length(FFTX)==NFFT
	FFTX=fftshift(fft(samples,NFFT));
	MX=abs(FFTX);            % Take magnitude of X

	% Scale the FFT so that it is not a function of the 
	% length of x.
	MX=MX/l;

	f=(-(NFFT/2):NFFT/2-1)*fs/NFFT;

	A = interp1(f,MX,f0);
end;