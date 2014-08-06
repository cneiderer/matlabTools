function plot_trk_rel_ref(trackdata,radar)

trackdata.rrc=ruv2rrc([trackdata.ruv trackdata.ruv_rate].', radar.site.fs, radar.site.d_RRC_RFC).';
trackdata.amm_rrc=ruv2rrc([trackdata.amm_ruv trackdata.amm_ruv_rate].', radar.site.fs, radar.site.d_RRC_RFC).';
[SqrtposEigs,SqrtvelEigs]=getSQRTcovEigs(trackdata.rrc_covariance);
[ammSqrtposEigs,ammSqrtvelEigs]=getSQRTcovEigs(trackdata.amm_rrc_covariance);





figure; plot(truth.time(3:end),vec_norm(trackrrc(3:end,1:3)-truth.RRC(1:3,3:end).'),'.');
hold on; plot(truth.time(3:end),3*SqrtposEigs(3:end));



figure;
subplot(2,1,1);
hold on; 
plot_color_coded(truth.time,vec_norm(ammtrackrrc(:,1:3)-truth.RRC(1:3,:).'),trackdata.track_type);
plot(truth.time(3:end),3*ammSqrtposEigs(3:end));

subplot(2,1,2);
hold on; 
plot_color_coded(truth.time,vec_norm(ammtrackrrc(:,4:6)-truth.RRC(4:6,:).'),trackdata.track_type);
plot(truth.time(3:end),3*ammSqrtvelEigs(3:end));


figure;
subplot(2,1,1);
hold on; 
plot_color_coded(truth.time,vec_norm(trackrrc(:,1:3)-truth.RRC(1:3,:).'),trackdata.track_type);
plot(truth.time(3:end),3*SqrtposEigs(3:end));

subplot(2,1,2);
hold on; 
plot_color_coded(truth.time,vec_norm(trackrrc(:,4:6)-truth.RRC(4:6,:).'),trackdata.track_type);
plot(truth.time(3:end),3*SqrtvelEigs(3:end));