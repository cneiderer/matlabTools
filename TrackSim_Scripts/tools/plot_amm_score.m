function plot_amm_score(detection,amm,Tupper,Tlower)
figure;
title('AMM Score');
hold on;
grid on;
plot_color_coded(gca,detection.time,amm.score,amm.model);


line([min(detection.time) max(detection.time)],[Tupper Tupper]);
line([min(detection.time) max(detection.time)],[Tlower Tlower]);
set(gca,'xlim',[min(detection.time) max(detection.time)]);

if 1
    line([amm.b2e amm.b2e],[-100 100],'LineStyle',':','DisplayName','b2e','Color','g');
    
    line([amm.e2b amm.e2b],[-100 100],'LineStyle',':','DisplayName','e2b','Color','m');
    
    line([amm.e2m amm.e2m],[-100 100],'LineStyle',':','DisplayName','e2m','Color','b');
    
    line([amm.m2e amm.m2e],[-100 100],'LineStyle',':','DisplayName','m2e','Color','g');
end