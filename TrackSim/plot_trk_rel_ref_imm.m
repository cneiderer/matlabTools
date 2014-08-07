function plot_trk_rel_ref_imm(trackdata,truth,radar)

[imm_SqrtposEigs,imm_SqrtvelEigs]=getSQRTcovEigs(trackdata.imm.rrc_cov);

trackdata.rrc=ruv2rrc([trackdata.ruv trackdata.ruv_rate].', radar.site.fs, radar.site.d_RRC_RFC).';
[SqrtposEigs,SqrtvelEigs]=getSQRTcovEigs(trackdata.rrc_covariance);




normal_color='m';
imm_color='b';


figure;
ah(1)=subplot(2,1,1);
title('Position Error');
hold on; 
grid on
plot(gca,truth.time,vec_norm(trackdata.imm.rrc_state(:,1:3)-truth.RRC(1:3,:).'),'Color',imm_color,'DisplayName','AMM Position Error');
plot(gca,truth.time,vec_norm(trackdata.rrc(:,1:3)-truth.RRC(1:3,:).'),'Color',normal_color,'DisplayName','AMM Position Error');
plot(truth.time(3:end),3*imm_SqrtposEigs(3:end),'-','LineWidth',1.5,'Color',imm_color,'DisplayName','3 \sigma Uncertainty - AMM');
plot(truth.time(3:end),3*SqrtposEigs(3:end),'-','LineWidth',1.5,'Color',normal_color,'DisplayName','3 \sigma Uncertainty - AMM');

set(gca,'yscale','log')

ah(2)=subplot(2,1,2);
title('Velocity Error');
hold on; 
grid on
plot(gca,truth.time,vec_norm(trackdata.imm.rrc_state(:,4:6)-truth.RRC(4:6,:).'),'Color',imm_color,'DisplayName','Normal Velocity Error');
plot(gca,truth.time,vec_norm(trackdata.rrc(:,4:6)-truth.RRC(4:6,:).'),'Color',normal_color,'DisplayName','AMM Position Error');
plot(truth.time(3:end),3*imm_SqrtvelEigs(3:end),'-','LineWidth',1.5,'Color',imm_color,'DisplayName','3 \sigma Uncertainty - AMM');
plot(truth.time(3:end),3*SqrtposEigs(3:end),'-','LineWidth',1.5,'Color',normal_color,'DisplayName','3 \sigma Uncertainty - AMM');
linkaxes(ah,'x');
set(gca,'yscale','log')


