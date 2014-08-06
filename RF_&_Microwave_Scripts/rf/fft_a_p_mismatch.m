% FFT_A_P_MISMATCH  Amplitude and phase mismatch of two signals from an FFT
% 
%    [A] = FFT_A_P_MISMATCH (samples1,samples2,fs,f0) calculates the amplitude 
%       and phase mismatch of the signals at f0 by performing an FFT of the 
%       samples.
%
%    [A] = FFT_A_P_MISMATCH (samples1,samples2,fs,f0,window) multiplies by the
%       chosen window before performing the FFT.  The Kaiser window requires
%       that a value for K be given as the fifth argument.
% 
%       If the samples are complex, distinction is made between positive and
%       negative frequencies.

function [A, P] = fft_a_p_mismatch(samples1, samples2, fs, f0, varargin);

A1 = fftamp(samples1, fs, f0, varargin{:});
A2 = fftamp(samples2, fs, f0, varargin{:});
A = max(A1/A2, A2/A1);


P1 = fftphase(samples1, fs, f0, varargin{:});
P2 = fftphase(samples2, fs, f0, varargin{:});
P = abs(P1 - P2);