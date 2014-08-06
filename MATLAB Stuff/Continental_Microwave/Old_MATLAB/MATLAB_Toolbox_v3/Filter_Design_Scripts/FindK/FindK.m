function K=FindK(filename)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   K = FindK(filename)
%
%   By:  Serhend Arvas. 
% 
%   This program uses the SBOX (S-parameter toolbox) by "Tudor Dima".
%   Specifically (SXPParse.m and Phrase2Word.m)
%
%   The whole toolbox can be downloaded from the Matlab Exchange Website.
%
%   (www.mathworks.com/matlabcentral/fileexchange)
%
%   The toolbox is an EXCELLENT interface for manipulation of Scattering
%   Parameter files in Matlab.
%
%   This function will read in a Touchstone file (.snp) and calculate
%   a quantity K.  The function finds the two highest peaks in |S21|.
%   The frequency of the first peak (lower frequency) is called F_low.
%   The frequency of the second peak (high frequency) is called F_high.
%
%   Then K = ( F_high^2 - F_low^2 ) / ( F_high^2 + F_low^2 )
% 
%   This formula is from the Daniel G. Swanson Jr. article entitled
%   "Narrow-Band Microwave Filter Design.  The article was found in the 
%   October 2007 IEEE Microwave Magazine.  The formula is on page 108.
%
%   This program was written in response to a question posted by member
%   "junz" on the Sonnet Community Forum (www.sonnetlist.com).
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[freq, data, freq_noise, data_noise, Zo]=SXPParse(filename);

% Initializes an empty matrix to store all local maxima
peaks=[];
S21=permute(data(2,1,:),[3 1 2]);
% Search the S-matrices at different frequencies to find local maxima of |S21|
for n=2:length(freq)-1
    if abs(data(2,1,n-1))<abs(data(2,1,n)) && abs(data(2,1,n))>abs(data(2,1,n+1))
        peaks=[peaks; freq(n) abs(S21(n))];
    end
end

% Sort all local maxima in terms of magnitude
peaks=sortrows(peaks,2);

% Find Size of the peaks matrix
[rows,cols]=size(peaks);

% Identify the two highest peaks
peak1=peaks(rows,:);
peak2=peaks(rows-1,:);

% Depending on frequency, assign peakHigh, peakLow
if peak1(1)>peak2(1)
    peakHigh=peak1;
    peakLow=peak2;
else
    peakHigh=peak2;
    peakLow=peak1;
end

% Rename them 
F_high=peakHigh(1);
F_low=peakLow(1);

% The K formula in the paper.
K = ( F_high^2 - F_low^2 ) / ( F_high^2 + F_low^2 );