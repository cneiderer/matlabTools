function plot_track(trackdata,truth)

figure;
hold on;
title('Normal Filter');
plot(trackdata.det_time(3:end),truth.RUV(1,(3:end))-trackdata.det_ruv((3:end),1)+trackdata.rdc_time(3:end).*truth.RUV(4,(3:end)).', 'kx')
line([trackdata.det_time(3:end); trackdata.det_time(3:end)],[truth.RUV(1,(3:end))-trackdata.ruv(1,3:end); truth.RUV(1,(3:end))-trackdata.pred_ruv(3:end,1)],'Color','k')
line([trackdata.det_time(3:end-1); trackdata.det_time(4:end)],[truth.RUV(1,(1:end-1))-trackdata.ruv(1,1:end-1); truth.RUV(1,(2:end))-trackdata.pred_ruv(1,2:end)],'Color','k')
ylim([-5 5]);
