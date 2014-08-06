figure(1);
mu = [0 0];
Sigma = [1 0.8; 0.8 10];
x1 = -3:.2:3; x2 = -3:.2:3;
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu,Sigma);
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
axis([-3 3 -3 3 0 .4])
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');
title('mu 1 = 0, mu 2 = 0, sigma 1 = 1, sigma 2 = 1, ro = 0.8')

%%
figure(2);
mu = [0 0]; Sigma = [1 -0.8; -0.8 10];
[X1,X2] = meshgrid(linspace(-3,3,25)', linspace(-3,3,25)');
X = [X1(:) X2(:)];
p = mvnpdf(X, mu, Sigma);
surf(X1,X2,reshape(p,25,25));
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');