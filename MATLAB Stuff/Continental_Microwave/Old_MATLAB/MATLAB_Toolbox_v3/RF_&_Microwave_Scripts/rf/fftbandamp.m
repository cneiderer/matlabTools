% FFTBANDAMP  Function to find rms amplitude of a particular band from an FFT
% 
%    [A] = FFTBANDAMP (samples,fs,fl,fh,n) calculates the rms magnitude of the signal
%          in the band between fl and fh by performing an FFT of the samples, using n
%          points in the band.
%
%
%    [A] = FFTBANDAMP (samples,fs,fl,fh,n,window) multiplies by the chosen window before 
%          performing the FFT.  The Kaiser window requires that a value for K be
%          given as the seventh argument.
%   
%          If the samples are complex, distinction is made between positive and negative 
%          frequencies

function [A] = fftbandamp(samples, fs, fL, fH, n, varargin);

if (n < 2),
   error('Too few points in band');
end;

complex = 0;
if (iscmplx(samples)==1),
   complex = 1;
end;

if (size(samples,1)==1),
	samples = transpose(samples);
end;   

l = length(samples);
W = boxcar(l);
if nargin > 5,
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
   if (fH > fs/2) | (fL < 0) | (fH < fL),
  		error('Invalid band');
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

	fb = fL:(fH-fL)/(n - 1):fH;
	A = rms(interp1(f,MX,fb));
end;

if (complex == 1),
	if (abs(fH) > fs/2) | (abs(fL) > fs/2) | (fH < fL),
  		error('Invalid band');
	end;

	% Take fft, padding with zeros, length(FFTX)==NFFT
	FFTX=fftshift(fft(samples,NFFT));
	MX=abs(FFTX);            % Take magnitude of X

	% Scale the FFT so that it is not a function of the 
	% length of x.
	MX=MX/l;

	f=(-(NFFT/2):NFFT/2-1)*fs/NFFT;
   
   fb = fL:(fH-fL)/(n - 1):fH;
	A = rms(interp1(f,MX,fb));
end;