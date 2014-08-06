function plot_trk_rel_ref2(amm,imm,kf,truth,radar)

kf.rrc=ruv2rrc([kf.sv(:,1:3) kf.sv(:,4:6)].', radar.site.fs, radar.site.d_RRC_RFC).';
amm.rrc=ruv2rrc([amm.sv(:,1:3) amm.sv(:,4:6)].', radar.site.fs, radar.site.d_RRC_RFC).';

[SqrtposEigs,SqrtvelEigs]=getSQRTcovEigs(kf.cov);
[ammSqrtposEigs,ammSqrtvelEigs]=getSQRTcovEigs(amm.cov);
[immSqrtposEigs,immSqrtvelEigs]=getSQRTcovEigs(imm.p);

amm_color='b';
normal_color='g';
imm_color='m';
dimm_color='c';

figure;
ah(1)=subplot(2,1,1);
title('Position Error');
hold on;
grid on
if 1
plot(gca,truth.time,vec_norm(imm.x(:,1:3)-truth.RRC(1:3,:).'),'Color',imm_color,'DisplayName','Tom Kurien IMM Position Error');
plot(gca,truth.time,vec_norm(amm.rrc(:,1:3)-truth.RRC(1:3,:).'),'Color',amm_color,'DisplayName','AMM Position Error');
plot(gca,truth.time,vec_norm(kf.rrc(:,1:3)-truth.RRC(1:3,:).'),'Color',normal_color,'DisplayName','Normal Position Error');
end
if 0
    plot(truth.time(3:end),3*ammSqrtposEigs(3:end),'-','LineWidth',1.5,'Color',amm_color,'DisplayName','3 \sigma Uncertainty - AMM');
    plot(truth.time(3:end),3*SqrtposEigs(3:end),'-','LineWidth',1.5,'Color',normal_color,'DisplayName','3 \sigma Uncertainty - Normal');
    plot(truth.time(3:end),3*immSqrtposEigs(3:end),'-','LineWidth',1.5,'Color',imm_color,'DisplayName','3 \sigma Uncertainty - Tom Kurien IMM');
end
legend show
set(gca,'yscale','log')

ah(2)=subplot(2,1,2);
title('Velocity Error');
hold on;
grid on
if 1
plot(gca,truth.time,vec_norm(imm.x(:,4:6)-truth.RRC(4:6,:).'),'Color',imm_color,'DisplayName','Tom Kurien IMM Position Error');
plot(gca,truth.time,vec_norm(amm.rrc(:,4:6)-truth.RRC(4:6,:).'),'Color',amm_color,'DisplayName','AMM Position Error');
plot(gca,truth.time,vec_norm(kf.rrc(:,4:6)-truth.RRC(4:6,:).'),'Color',normal_color,'DisplayName','Normal Position Error');
end
if 0
    plot(truth.time(3:end),3*ammSqrtposEigs(3:end),'-','LineWidth',1.5,'Color',amm_color,'DisplayName','3 \sigma Uncertainty - AMM');
    plot(truth.time(3:end),3*SqrtposEigs(3:end),'-','LineWidth',1.5,'Color',normal_color,'DisplayName','3 \sigma Uncertainty - Normal');
    plot(truth.time(3:end),3*immSqrtposEigs(3:end),'-','LineWidth',1.5,'Color',imm_color,'DisplayName','3 \sigma Uncertainty - Tom Kurien IMM');
end
legend show
set(gca,'yscale','log')


