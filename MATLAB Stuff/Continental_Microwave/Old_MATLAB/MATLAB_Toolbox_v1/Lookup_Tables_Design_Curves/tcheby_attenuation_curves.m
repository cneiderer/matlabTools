function [] = tcheby_attenuation_curves(passband_ripple)

%
% tcheby_attenuation_curves.m
%
% Description:
%
% Inputs:
%   passband_ripple
%   
% Outputs:
%   plot of attenuation characteristic 
%
% Author:
%   Curtis Neiderer, 20090109
%

if nargin==1
    passband_ripple=varargin{1};
else
    passband_ripple=input('Please enter the passband ripple of the filter characteristic you desire [dB]: ');
end

% Calculate epsilon
epsilon=(10^(passband_ripple/10))-1;

% Calculate attenuation for each filter order at various frequency ratios
% and plot the data
freq_ratio=1.01:0.01:11;
filter_order=1:20;
cmap=colormap(colorcube);
plot_colors=cmap(1:20,:);
filter_char_legend={};
for ii=1:length(filter_order)

    attenuation_matrix=[];
    for jj=1:length(freq_ratio)

        % Calculate attenuation
        % attenuation=10*log10(1+(epsilon*(cos(filter_order*acos(center_freq/lower_corner_freq)))^2));
        attenuation=10*log10(1+(epsilon*(cos(filter_order(ii)*acos(freq_ratio(jj))))^2));
        
        % Build attenuation_matrix
        attenuation_matrix=[attenuation_matrix;freq_ratio(jj),attenuation];
        
        clear attenuation
        
    end
    
%     % Store filter_order data
%     filter_characteristic(ii).filter_order=filter_order(ii);
%     filter_characteristic(ii).attenuation=attenuation_matrix(:,2);
    
    % Plot filter attenuation characteristic
    if ii==1
        semilogx(attenuation_matrix(:,1)-1,attenuation_matrix(:,2));
        set(findobj(gca,'Type','line','Color',[0 0 1]),'Color',plot_colors(ii,:))
        hold on;
    else   
    	plot(attenuation_matrix(:,1)-1,attenuation_matrix(:,2));
        set(findobj(gca,'Type','line','Color',[0 0 1]),'Color',plot_colors(ii,:))
        hold on;  
    end
    
    filter_char_legend{ii,1}=['n = ',num2str(ii)];

end

% Format the plot
grid on;
set(gca,'YLim',[0,200]);
set(gca,'YTick',[0:10:200],'FontWeight','bold');
set(gca,'YMinorGrid','on');

ylabel('L_A [dB]','FontSize',12,'FontWeight','bold');
xlabel('| \omega/\omega_1 | - 1','FontSize',12,'FontWeight','bold');
title(['Tchebyschev Filter Attenuation Characteristic: L_A_r = ',num2str(passband_ripple),'dB'],...
    'FontSize',18,'FontWeight','bold')
legend(filter_char_legend,'Location','EastOutside','FontWeight','bold')
hold off;

% Resize the figure window
set(gcf,'Position',[200,200,800,600]);