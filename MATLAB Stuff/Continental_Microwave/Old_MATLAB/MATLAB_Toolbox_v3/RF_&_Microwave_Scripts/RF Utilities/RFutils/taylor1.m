function taywin =taylor1(N);

% Calculation of modified Taylor distribution for monotonically decreasing
% sidelobe levels. Ref JASIK 20-9  / 2-27 (1st edition 1961)
%
% N  = number of elements in whole array
%
% x  = Distance measured from centre of aperture
% L  = Total length of aperture
% Jo = Zero-order Bessel function of first kind
% B  = Parameter that fixes ratio of R of main beam amplitude to amplitude
%      of first side lobe by R = 4.60333 sinh(pi.B)/pi.B  For B=0 the value
%      of R is simply 4.60333 (lin V) or 13.2dB (dB pwr) characteristic of
%      a uniform distribution.
%
%      1st Sidelobe ratio dB    Value of B
%             15                  0.355769
%             20                  0.738600
%             25                  1.022920
%             30                  1.276160
%             35                  1.513630
%             40                  1.741480
%
%  Note :- For an N source array of length 2 the spacing is 2/N not!
%          2/(N-1) i.e the end element is (2/N)/2 in from the end.
%

% N.Tucker www.activefrance.com 2008

L=2;                 % Total aperture length in units (dimensionless)
B=0.738;             % Indirect ratio parameter selected from table above
%B=1.74148;
%B=0.1;

R=20.*log10(sinh(pi*B)/(pi*B))+13.261;

deltax=2/(N);
x1=(deltax/2-1:deltax:1-deltax/2);
[R,C]=size(x1);
J=1;
for I=1:C,
 if x1(1,I)>=0,
   x(1,J)=x1(1,I);
   J=J+1;
 end
end
x;
X=[(x-1),x]';
AxLINAMP=(1./(2.*pi)).*bessel(0,(j.*pi.*B.*sqrt(1-(2.*x./L).^2)));
AxLINAMPnorm=AxLINAMP./max(AxLINAMP);
taywin=[AxLINAMPnorm(N./2:-1:1) AxLINAMPnorm];

