function [fig_handles] = joint_pdf_XY()

% mean1=zeros(1,6);
% mean2=zeros(1,6);
% sigma1=ones(1,6);
% sigma2=[1,1,1,2,2,10];
% correlation=[0,0.8,-0.8,0,0.8,0.8];
% part=['a','b','c','d','e','f'];

% mean1=1;
% mean2=0;
% sigma1=3/2;
% sigma2=3/2;
% correlation=1/2;
% part='X';

% mean1=-1/sqrt(2);
% mean2=1;
% sigma1=2;
% sigma2=2;
% correlation=0;
% part='Y';

mean1=0;
mean2=0;
sigma1=2;
sigma2=3;
correlation=0;
part='Y,Z | X';

fig_handles=[];
for ii=1
   fig_handles=[fig_handles,...
       plot_joint_pdf(mean1(ii),mean2(ii),...
       sigma1(ii),sigma2(ii),correlation(ii),ii,part)]; 
end


function [fig_h] = plot_joint_pdf(m1,m2,s1,s2,rho,fig_num,part)

%
fig_h=[];
fig_h=[fig_h,figure(fig_num)];
hold on;

%
mu=[m1,m2]; 
Sigma=[s1,rho;rho,s2];

x=-3:.2:3;
y=-3.5:.2:3.5;

[X,Y]=meshgrid(x,y);
F=mvnpdf([X(:),Y(:)],mu,Sigma);
F=reshape(F,length(y),length(x));
surf(X,Y,F);
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);

axis([-3,3,-3.5,3.5,0,.1]);

grid on;
xlabel('Y'); 
ylabel('Z'); 
zlabel('Probability Density');

title({['Problem 6 (LG 6.54) - Densisty of ',part],...
    ['\mu1 = ',num2str(m1),', \mu2 = ',num2str(m2),...
    ', \sigma1 = ',num2str(s1),', \sigma2 = ',num2str(s2),...
    ', \rho = ',num2str(rho)]});

hold off;

fig_h=[fig_h,figure(fig_num+1)];
contour(X,Y,F);

% axis([-2,4,-3,3]);
axis([-3,3,-3.5,3.5]);


grid on;
xlabel('Y'); 
ylabel('Z'); 
zlabel('Probability Density');

title({['Problem 6 (LG 6.54) - Densisty of ',part,],...
    ['\mu1 = ',num2str(m1),', \mu2 = ',num2str(m2),...
    ', \sigma1 = ',num2str(s1),', \sigma2 = ',num2str(s2),...
    ', \rho = ',num2str(rho)]});

hold off;


