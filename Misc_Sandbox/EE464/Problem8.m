function Problem8()

%% Load data
load('dist_samples.mat');

%% Plot Histogram of Samples and Rough Fit of Data
figure(1);
hold on;
hist(dist_samples,100);

[x,y]=hist(dist_samples,100); 

minZeroInd=find(x==0,1);
maxZeroInd=find(x==0,1,'last');
medianZeroInd=median(find(x==0));
maxCnt1=find(x==max(x(1:minZeroInd)));
maxCnt2=find(x==max(x(maxZeroInd:end)));

X=[x(1), x(maxCnt1), x(medianZeroInd), x(maxCnt2), x(end)];
Y=[y(1), y(maxCnt1), y(medianZeroInd), y(maxCnt2), y(end)];

XX=linspace(min(Y)-10,max(Y)+10,100);
% XX=linspace(min(Y),max(Y),100);
YY=interp1(Y,X,XX,'cubic','extrap');
plot(XX,YY,'-r','LineWidth',2);

title('HWK #5, Prob 8: "\mu" is the secret message hidden in the parameters of the distribution');
xlabel('Sample Value');
ylabel('Probability Density');
legend('Sample Histogram','Rough Spline Fit');
% hold off;

%% Abstract Distribution Information
x=dist_samples;

pdf_normmixture = @(x,p,mu1,mu2,sigma1,sigma2) ...
    p*normpdf(x,mu1,sigma1) + (1-p)*normpdf(x,mu2,sigma2);
                     
pStart = .5;
muStart = quantile(x,[.5 .5]);
sigmaStart = sqrt(var(x) - .25*diff(muStart).^2);
start = [pStart muStart sigmaStart sigmaStart];

lb = [0 -Inf -Inf 0 0];
ub = [1 Inf Inf Inf Inf];

options = statset('MaxIter',1000, 'MaxFunEvals',1500);
paramEsts = mle(x, 'pdf',pdf_normmixture, 'start',start, ...
    'lower',lb, 'upper',ub, 'options',options);
               
text(125,-10,['X_1 ~ Gaussian with \mu_1 \approx ', num2str(paramEsts(2)),...
    ', \sigma_1 \approx ', num2str(paramEsts(4)), ...
    ', p(X_1) \approx ', num2str(paramEsts(1))]);
text(125,-20,['X_2 ~ Gaussian with \mu_2 \approx ', num2str(paramEsts(3)),...
    ', \sigma_2 \approx ', num2str(paramEsts(5)),...
    ', p(X_2) \approx ', num2str(1-paramEsts(1))]);