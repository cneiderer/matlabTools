% FREQS1  Function to find the frequency response of a filter at 1 frequency
% 
%    [H] = FREQS1 (B, A, W) calls FREQS and returns just the response of the frequency specified.
%       This is to make up for the morons who wrote FREQS without considering that someone may 
%       want the frequency response at only one point.

function [H] = freqs1 (B,A,W)
Htemp = freqs(B, A, [1 W]);
H = Htemp(2);