function plot_trk_rel_ref(trackdata,truth,radar)

trackdata.rrc=ruv2rrc([trackdata.ruv trackdata.ruv_rate].', radar.site.fs, radar.site.d_RRC_RFC).';
trackdata.amm_rrc=ruv2rrc([trackdata.amm_ruv trackdata.amm_ruv_rate].', radar.site.fs, radar.site.d_RRC_RFC).';
[SqrtposEigs,SqrtvelEigs]=getSQRTcovEigs(trackdata.rrc_covariance);
[ammSqrtposEigs,ammSqrtvelEigs]=getSQRTcovEigs(trackdata.amm_rrc_covariance);





% figure; plot(truth.time(3:end),vec_norm(trackdata.rrc(3:end,1:3)-truth.RRC(1:3,3:end).'),'.');
% hold on; plot(truth.time(3:end),3*SqrtposEigs(3:end));



figure;
ah(1)=subplot(2,1,1);
title('AMM Position Error');
hold on; 
grid on
plot_color_coded(gca,truth.time,vec_norm(trackdata.amm_rrc(:,1:3)-truth.RRC(1:3,:).'),trackdata.amm_track_type);
plot(truth.time(3:end),3*ammSqrtposEigs(3:end),'-k','LineWidth',1.5);
set(gca,'yscale','log')

ah(2)=subplot(2,1,2);
title('AMM Velocity Error');
hold on; 
grid on
plot_color_coded(gca,truth.time,vec_norm(trackdata.amm_rrc(:,4:6)-truth.RRC(4:6,:).'),trackdata.amm_track_type);
plot(truth.time(3:end),3*ammSqrtvelEigs(3:end),'-k','LineWidth',1.5);
linkaxes(ah,'x');
set(gca,'yscale','log')

figure;
th(1)=subplot(2,1,1);
title('Position Error');
hold on;
grid on
plot_color_coded(gca,truth.time,vec_norm(trackdata.rrc(:,1:3)-truth.RRC(1:3,:).'),trackdata.track_type);
plot(truth.time(3:end),3*SqrtposEigs(3:end),'-k','LineWidth',1.5);
set(gca,'yscale','log')

th(2)=subplot(2,1,2);
title('Velocity Error');
hold on; 
grid on
plot_color_coded(gca,truth.time,vec_norm(trackdata.rrc(:,4:6)-truth.RRC(4:6,:).'),trackdata.track_type);
plot(truth.time(3:end),3*SqrtvelEigs(3:end),'-k','LineWidth',1.5);
linkaxes(th,'x')
set(gca,'yscale','log')