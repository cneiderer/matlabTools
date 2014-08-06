% [a,b]=hist(dist_samples,[80,160,240,320,400]);
[a,b]=hist(dist_samples,100);

% a=a(a~=0);
% b=b(a~=0);

pp = splinefit(b,a,25);
xx=linspace(min(b),max(b),100);
y=ppval(pp,xx);
figure(1);
plot(b,a,'.',xx,y);

%
yy = interp1(b,a,xx,'pchip');
figure(2);
plot(b,a,'.',xx,yy);

%
yi = interp1(b,a,xx,'cubic');
figure(3);
plot(b,a,'.',xx,yi);

%
figure(10);
hold on;
hist(dist_samples,100);

[x,y]=hist(dist_samples,100); 

minZeroInd=find(x==0,1);
maxZeroInd=find(x==0,1,'last');
medianZeroInd=median(find(x==0));
maxCnt1=find(x==max(x(1:minZeroInd)));
maxCnt2=find(x==max(x(maxZeroInd:end)));

% X=[x(1:minZeroInd-1), x(medianZeroInd), x(maxZeroInd+1:end)];
% Y=[y(1:minZeroInd-1), y(medianZeroInd), y(maxZeroInd+1:end)];

% X=[x(1:maxCnt1), x(medianZeroInd), x(maxCnt2:end)];
% Y=[y(1:maxCnt1), y(medianZeroInd), y(maxCnt2:end)];

X=[x(1), x(maxCnt1), x(medianZeroInd), x(maxCnt2), x(end)];
Y=[y(1), y(maxCnt1), y(medianZeroInd), y(maxCnt2), y(end)];

XX=linspace(135,max(Y),100);
YY=interp1(Y,X,XX,'cubic','extrap');
figure(10);
plot(XX,YY,'-r','LineWidth',2);

% pp=splinefit(Y,X,15);
% yy=ppval(pp,XX);
% plot(XX,yy,'.-g','LineWidth',2);

title('HWK #5, Prob 8: "\mu" is the secret message');
xlabel('Sample Value');
ylabel('Probability Density');
legend('Sample Histogram','Rough Cubic Spline Fit');

hold off;

