function [] = max_flat_attenuation_curves

%
% max_flat_attenuation_curves.m
%
% Description:
%   Calculates and plots the attenuation characteristics of the max flat 
%   filter using the 3dB band-edge point as the corner frequency when 
%   calculating epsilon.  
%
% Inputs:
%   N/A
%
% Outputs:
%   figure of the max flat filter attenuation curves
%
% Author:
%   Curtis Neiderer, 1/19/2009
%
% Comments / Changes:
%

% Define corner attenuation as 3dB band-edge point
corner_attenuation=3;

% Calculate epsilon
epsilon=10^(corner_attenuation/10)-1;

% Calculate attenuation for each filter order at various frequency ratios
% and plot the data
freq_ratio=1.01:0.001:11;
filter_order=50;
cmap=colormap(colorcube);
plot_colors=cmap(1:filter_order,:);
filter_char_legend={};
for ii=1:filter_order

    attenuation_matrix=[];
    for jj=1:length(freq_ratio)

        % Calculate Attenuation Loss
        attenuation=10*log10(1+epsilon*(freq_ratio(jj))^(2*ii));
        
        % Build attenuation_matrix
        attenuation_matrix=[attenuation_matrix;freq_ratio(jj),attenuation];
        
        clear attenuation
        
    end
    
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
title(['Max Flat Filter Attenuation Characteristic: L_A_r = 3dB'],...
    'FontSize',18,'FontWeight','bold')
legend(filter_char_legend,'Location','EastOutside','FontWeight','bold')
hold off;

% Resize the figure window
set(gcf,'Position',[200,200,800,600]);