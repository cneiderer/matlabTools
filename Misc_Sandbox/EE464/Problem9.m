function [] = Problem9

% Parameters for cases (a)-(f)
mean1=0;
mean2=0;
sigma1=1;
sigma2=1;
correlation_coefficient=0;

test=1;

% Plot pdf results from each set of parameters
[x,y] = meshgrid(-3:.1:3);

% Joint pdf of X and Y
f_XY=(1/(2*pi*sigma1*sigma2*sqrt(1-correlation_coefficient^2)))*...
    exp((-1/(2*(1-correlation_coefficient^2)))*...
    ((x-mean1)/sigma1)^2-...
    (2*correlation_coefficient*((x-mean1)/sigma1)*((y-mean2)/sigma2))+...
    ((y-mean2)/sigma2)^2);

% Plot 
close all;
figure;
meshc(x,y,f_XY);
axis([-3,3,-3,3,0,3]);


%%
x=-3;
y=-3;
f_XY=(1/(2*pi*sigma1*sigma2*sqrt(1-correlation_coefficient^2)))*...
    exp((-1/(2*(1-correlation_coefficient^2)))*...
    ((x-mean1)/sigma1)^2-...
    (2*correlation_coefficient*((x-mean1)/sigma1)*((y-mean2)/sigma2))+...
    ((y-mean2)/sigma2)^2);

test=1;

%%
for ii=1:size(x)
    f_XY(1,ii)=(1/(2*pi*sigma1*sigma2*sqrt(1-correlation_coefficient^2)))*...
        exp((-1/(2*(1-correlation_coefficient^2)))*...
        ((x(ii)-mean1)/sigma1)^2-...
        (2*correlation_coefficient*((x(ii)-mean1)/sigma1)*((y(ii)-mean2)/sigma2))+...
        ((y(ii)-mean2)/sigma2)^2);
end
f_XY=ones(61,1)*f_XY;

test=1;