function plot_ruv_residuals(trackdata)

residualOneSigma=zeros(size(trackdata.ruv_var));
residualOneSigma(:,2:3)=sqrt(trackdata.ruv_var(:,2:3) + trackdata.det_ruv_var(:,2:3));
residualOneSigma(:,1)=sqrt(trackdata.ruv_var(:,1) + trackdata.det_ruv_var(:,1)+trackdata.rdc_time.^2.*trackdata.ruv_rate_var(:,1));

figure;
hr(1)=subplot(3,1,1);
hold on;
grid on
title('RUV Track Residuals for Normal Filter');
ylabel('Range (m)');
plot_color_coded(gca,trackdata.det_time,trackdata.resid_ruv(:,1),trackdata.track_type);
plot(trackdata.det_time,2*residualOneSigma(:,1),'k.');
plot(trackdata.det_time,-2*residualOneSigma(:,1),'k.');

hr(2)=subplot(3,1,2);
hold on;
grid on
plot_color_coded(gca,trackdata.det_time,trackdata.resid_ruv(:,2),trackdata.track_type);
plot(trackdata.det_time,2*residualOneSigma(:,2),'k.');
plot(trackdata.det_time,-2*residualOneSigma(:,2),'k.');
ylabel('U (msines)');

hr(3)=subplot(3,1,3);
hold on;
grid on
plot_color_coded(gca,trackdata.det_time,trackdata.resid_ruv(:,3),trackdata.track_type);
plot(trackdata.det_time,2*residualOneSigma(:,3),'k.');
plot(trackdata.det_time,-2*residualOneSigma(:,3),'k.');
ylabel('V (msines)');
xlabel('Time (sec)');
linkaxes(hr,'x');



amm_residualOneSigma=zeros(size(trackdata.amm_ruv_var));
amm_residualOneSigma(:,2:3)=sqrt(trackdata.amm_ruv_var(:,2:3) + trackdata.det_ruv_var(:,2:3));
amm_residualOneSigma(:,1)=sqrt(trackdata.amm_ruv_var(:,1) + trackdata.det_ruv_var(:,1)+trackdata.rdc_time.^2.*trackdata.amm_ruv_rate_var(:,1));

figure;
hr(1)=subplot(3,1,1);
hold on;
grid on
title('RUV Track Residuals for AMM Filter');
plot_color_coded(gca,trackdata.det_time,trackdata.amm_resid_ruv(:,1),trackdata.amm_track_type);
plot(trackdata.det_time,2*amm_residualOneSigma(:,1),'k.');
plot(trackdata.det_time,-2*amm_residualOneSigma(:,1),'k.');
ylabel('Range (m)');

hr(2)=subplot(3,1,2);
hold on;
grid on
plot_color_coded(gca,trackdata.det_time,trackdata.amm_resid_ruv(:,2),trackdata.amm_track_type);
plot(trackdata.det_time,2*amm_residualOneSigma(:,2),'k.');
plot(trackdata.det_time,-2*amm_residualOneSigma(:,2),'k.');
ylabel('U (msines)');

hr(3)=subplot(3,1,3);
hold on;
grid on
plot_color_coded(gca,trackdata.det_time,trackdata.amm_resid_ruv(:,3),trackdata.amm_track_type);
plot(trackdata.det_time,2*amm_residualOneSigma(:,3),'k.');
plot(trackdata.det_time,-2*amm_residualOneSigma(:,3),'k.');
ylabel('V (msines)');
xlabel('Time (sec)');

linkaxes(hr,'x');