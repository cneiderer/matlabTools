function hamwin =hamming1(N);
% Hamming window function
%
% N  = Number of points in window vector

% N.Tucker www.activefrance.com 2008

[Row,Col]=size(N);
n=0:1:(N-1);
hamwin=0.54-0.46*cos((n*2*pi)/(N-1));
