function plot_color_coded(ax,x,y,c)


hold on;
h=[];
u_c=unique(c(c~=0));
colors= ...
[   0 0 0
    0     1     0
    1     0     1
    0.2500    0.1125         1];

for ii=1:length(u_c)
    list=c==u_c(ii);
    h(ii)=plot(ax,x(list),y(list),'.','Color',colors(u_c(ii),:),'DisplayName',num2str(u_c(ii)));
    
end
legend(gca,'show')
    
    