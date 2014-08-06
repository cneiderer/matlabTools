x=rand(10000,1);
k=0.005:0.01:0.995;
figure(1);
hist(x,k);
[bin_cnts,bin_locs]=hist(x,k);
hold on;
plot((0:1),mean(bin_cnts)*ones(2,1),'--r','Linewidth',2);
hold off;

figure(2);
[f,x_]=ecdf(x);
stairs(x_,f,'LineWidth',2);

%%%%%%%%%%

x=rand(100,16)<0.5;

y=sum(x,2);

