function [] = Problem9_LG114

% Parameters for cases (a)-(f)
mean1=zeros(1,6);
mean2=zeros(1,6);
sigma1=ones(1,6);
sigma2=[1,1,1,2,2,10];
correlation_coefficient=[0,0.8,-0.8,0,0.8,0.8];

% Create figure
figure(1);
hold on;

% Loop through parameter values
for jj=1:1

    % Create vectors x and y to plot pdf
    x=(-10:.01:10)';
    y=(-10:.01:10)';
    f_XY=NaN(length(x),1);

    % Joint pdf of X and Y
    for ii=1:length(x)
        f_XY(ii,1)=(1/(2*pi*sigma1(jj)*sigma2(jj)*sqrt(1-correlation_coefficient(jj)^2)))*...
            exp((-1/(2*(1-correlation_coefficient(jj)^2)))*...
            ((x(ii)-mean1(jj))/sigma1(jj))^2-...
            (2*correlation_coefficient(jj)*((x(ii)-mean1(jj))/sigma1(jj))*((y(ii)-mean2(jj))/sigma2(jj)))+...
            ((y(ii)-mean2(jj))/sigma2(jj))^2);
    end

    test=1;

    % Plot pdf results from each set of parameters
    [X,Y] = meshgrid(-3:.125:3);
    Z = peaks(X,Y);
    meshc(X,Y,Z);
    axis([-3 3 -3 3 -10 5])
    
    plot3(x,y,f_XY,'LineWidth',2);
    hold on;

    test=1;
    
end


