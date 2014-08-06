% x=dist_samples;
% mu=mean(dist_samples);
% sigma=std(dist_samples);
% xTrunc=400;
% 
% % pdf_truncnorm = @(x,mu,sigma) normpdf(x,mu,sigma) ./ normcdf(xTrunc,mu,sigma);
% pdf_unknownDist = @(x,mu,sigma) normpdf(x,mu,sigma) ./ normcdf(xTrunc,mu,sigma);
% 
% start = [mean(x),std(x)];
% 
% [paramEsts,paramCIs] = mle(x, 'pdf',pdf_unknownDist, 'start',start, 'lower',[-Inf 0]);
% 
% acov = mlecov(paramEsts, x, 'pdf',pdf_unknownDist);
% stderr = sqrt(diag(acov));
% 
% xgrid = linspace(1.1*min(x),1.1*max(x),200);
% pdfgrid = pdf_normmixture(xgrid,paramEsts(1),paramEsts(2),paramEsts(3),paramEsts(4),paramEsts(5));
% hold on; plot(xgrid,pdfgrid,'-');

%%
x=dist_samples;

pdf_normmixture = @(x,p,mu1,mu2,sigma1,sigma2) ...
                         p*normpdf(x,mu1,sigma1) + (1-p)*normpdf(x,mu2,sigma2);
                     
pStart = .5;
muStart = quantile(x,[.25 .75]);
sigmaStart = sqrt(var(x) - .25*diff(muStart).^2);
start = [pStart muStart sigmaStart sigmaStart];

lb = [0 -Inf -Inf 0 0];
ub = [1 Inf Inf Inf Inf];

paramEsts = mle(x, 'pdf',pdf_normmixture, 'start',start, 'lower',lb, 'upper',ub);

statset('mlecustom');

options = statset('MaxIter',300, 'MaxFunEvals',600);
paramEsts = mle(x, 'pdf',pdf_normmixture, 'start',start, ...
                          'lower',lb, 'upper',ub, 'options',options);
                      
xgrid = linspace(1.1*min(x),1.1*max(x),200);
pdfgrid = pdf_normmixture(xgrid,paramEsts(1),paramEsts(2),paramEsts(3),paramEsts(4),paramEsts(5));
hold on; plot(xgrid,pdfgrid,'-'); hold off
xlabel('x'); ylabel('Probability Density');