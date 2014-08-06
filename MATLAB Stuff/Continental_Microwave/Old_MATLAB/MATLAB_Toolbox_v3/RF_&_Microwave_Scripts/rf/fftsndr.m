% FFTSNDR  Function to find SNR from an FFT
% 
%    [SNR, SDR, SINAD, SFDR, ENOB] = FFTSNDR (samples, fsample, fsignal, fcenter, fband) calculates
%       the SNR, SDR, SINAD, SFDR, and ENOB of the samples with a signal at fsignal and a signal 
%       band centered at fcenter and fband Hz wide, with the samples taken at fsample.
%
%		  If the samples are complex, the distinction is made between positive and negative frequencies.
%		  An optional sixth argument allows the data to be windowed, see PLOTFFT.  A Hanning window 
%       usually gives good results.
%
%       The DC peak is removed before ratios are calculated.  If the input signal is not full scale,
%       the ratios reported do not correspond to the maximum achievable.  Peak SFDR may correspond to
%       an input less than full-scale.


function [SNR, SDR, SINAD, SFDR, ENOB] = FFTSNDR(samples, fsample, fsignal, fcenter, fband, varargin);

fband = abs (fband);
fsample = abs (fsample);

complex = 0;
if (iscmplx (samples) == 1),
   complex = 1;
end;

LBE = fcenter - fband / 2;
UBE = fcenter + fband / 2;
NFFT=2 .^(ceil (log (length (samples)) / log (2)));

if (complex == 1),
   f=(-(NFFT / 2):NFFT / 2 - 1) * fsample / NFFT;
end;   

if (complex == 0),
	NumUniquePts = ceil ((NFFT + 1) / 2);
   f = (0:NumUniquePts - 1) * fsample / NFFT;
end;

[temp, Lindex] = min (abs (f - LBE));
[temp, Uindex] = min (abs (f - UBE));
[temp, Sindex] = min (abs (f - fsignal));

% Find the DC term to be excluded

tempindex = 1;
while ((fftamp(samples, fsample, f(tempindex), varargin{:}) >= ...
   fftamp(samples, fsample, f(tempindex + 1), varargin{:})) & (tempindex < Uindex)),
   tempindex = tempindex + 1;
end;

DCIndex = tempindex;

Lindex = max([Lindex DCIndex]);

% Consider the signal to be all bins until the amplitude is not monotonically decreasing
% away from the signal center

tempindex = Sindex;
while ((fftamp(samples, fsample, f(tempindex), varargin{:}) >= ...
   fftamp(samples, fsample, f(tempindex + 1), varargin{:})) & (tempindex < Uindex)),
   tempindex = tempindex + 1;
end;

SUBE = tempindex;

tempindex = Sindex;
while ((fftamp(samples, fsample, f(tempindex), varargin{:}) >= ...
   fftamp(samples, fsample, f(tempindex - 1), varargin{:})) & (tempindex > Lindex)),
   tempindex = tempindex - 1;
end;

SLBE = max ([tempindex DCIndex]);

% Lets now consider all harmonics of the signal index to the upper band edge

Fharmonic = 2*fsignal:fsignal:UBE;
DistP = sum (fftamp (samples, fsample, Fharmonic, varargin{:}).^2);

NDmaxA = max(fftamp(samples, fsample, f(Lindex:SLBE - 1), varargin{:}));
NDmaxA = max([NDmaxA fftamp(samples, fsample, f(SUBE + 1:Uindex), varargin{:})]);

NoiseP = sum (fftamp (samples, fsample, f(Lindex:SLBE - 1), varargin{:}).^2);
NoiseP = NoiseP + sum (fftamp(samples, fsample, f(SUBE + 1:Uindex), varargin{:}).^2);
NoiseP = NoiseP - DistP;

SignalP = sum (fftamp (samples, fsample, f(SLBE:SUBE), varargin{:}).^2);
SignalmaxA = fftamp (samples, fsample, fsignal, varargin{:});

SNR = 10 * log10 (SignalP / NoiseP);
SDR = 10* log10 (SignalP / DistP);
SINAD = 10 * log10 (SignalP / (NoiseP + DistP));
SFDR = 20 * log10 (SignalmaxA / NDmaxA);
ENOB = (SINAD - 1.76)/6.02;