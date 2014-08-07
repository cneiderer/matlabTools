%% interesting plots
figure; 
plot(detection.time, imm.mProb);

plot_trk_rel_ref2(amm, imm, kf, truth2, radar) 

plot_amm_score(detection, amm, Tupper, Tlower) 



figure;
hold on;
title('Normal Filter');
plot(detection.time(3:end),truth.RUV(1,(3:end))-detection.ruv((3:end),1)+detection.rdc_time(3:end).*truth.RUV(4,(3:end)).', 'kx')
line([detection.time(3:end); detection.time(3:end)],[truth.RUV(1,(3:end))-detection.ruv(1,3:end); truth.RUV(1,(3:end))-detection.pred_ruv(3:end,1)],'Color','k')
line([detection.time(3:end-1); detection.time(4:end)],[truth.RUV(1,(1:end-1))-detection.ruv(1,1:end-1); truth.RUV(1,(2:end))-detection.pred_ruv(1,2:end)],'Color','k')
ylim([-5 5]);