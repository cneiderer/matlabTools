figure;

%
mu=[0,0,0]; 
Sigma=[1 1 1;1 2 2; 1 2 3];

%
x=-4:.2:3;
y=-2:.2:4;
z=-2:.2:2;

%
[X,Y,Z]=meshgrid(x,y,z);
F=mvnpdf([X(:),Y(:)],mu,Sigma);
F=reshape(F,length(y),length(x),length(z));
surf(X,Y,Z,F);
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);

axis([-4,3,-2,4,0,.2]);

grid on;
xlabel('Y1'); 
ylabel('Y2'); 
zlabel('Probability Density');

title({['Problem 6 (LG 6.54) - Densisty of ',part,],...
    ['\mu1 = ',num2str(m1),', \mu2 = ',num2str(m2),...
    ', \sigma1 = ',num2str(s1),', \sigma2 = ',num2str(s2),...
    ', \rho = ',num2str(rho)]});

hold off;

fig_h=[fig_h,figure(fig_num+1)];
contour(x,y,F);

% axis([-2,4,-3,3]);
axis([-4,3,-2,4]);


grid on;
xlabel('X1'); 
ylabel('X2'); 
zlabel('Probability Density');

title({['Problem 6 (LG 6.54) - Densisty of ',part,],...
    ['\mu1 = ',num2str(m1),', \mu2 = ',num2str(m2),...
    ', \sigma1 = ',num2str(s1),', \sigma2 = ',num2str(s2),...
    ', \rho = ',num2str(rho)]});

hold off;