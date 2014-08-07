function mc_position_error(num_runs,radar,truth)


save_dir='D:\Documents and Settings\clarkss\My Documents\Raytheon\MATLAB\TrackSim\MMsim_output\newtraj2\';


for ii=1:num_runs
    load(fullfile(save_dir,strcat('run_',num2str(ii),'_out.mat')));


    if ii==1
        mc_amm_pos_err=zeros(length(detection.time),num_runs);
        mc_pos_err=zeros(length(detection.time),num_runs);
        mc_amm_vel_err=zeros(length(detection.time),num_runs);
        mc_vel_err=zeros(length(detection.time),num_runs);
    end

kf.rrc=ruv2rrc([kf.sv(:,1:3) kf.sv(:,4:6)].', radar.site.fs, radar.site.d_RRC_RFC).';
amm.rrc=ruv2rrc([amm.sv(:,1:3) amm.sv(:,4:6)].', radar.site.fs, radar.site.d_RRC_RFC).';

[SqrtposEigs,SqrtvelEigs]=getSQRTcovEigs(kf.cov);
[ammSqrtposEigs,ammSqrtvelEigs]=getSQRTcovEigs(amm.cov);
[immSqrtposEigs,immSqrtvelEigs]=getSQRTcovEigs(imm.p);

    mc_imm_pos_err(:,ii)=vec_norm(imm.x(:,1:3)-truth.RRC(1:3,:).').^2;
    mc_amm_pos_err(:,ii)=vec_norm(amm.rrc(:,1:3)-truth.RRC(1:3,:).').^2;
    mc_pos_err(:,ii)=vec_norm(kf.rrc(:,1:3)-truth.RRC(1:3,:).').^2;
    mc_imm_vel_err(:,ii)=vec_norm(imm.x(:,4:6)-truth.RRC(4:6,:).').^2;
    mc_amm_vel_err(:,ii)=vec_norm(amm.rrc(:,4:6)-truth.RRC(4:6,:).').^2;
    mc_vel_err(:,ii)=vec_norm(kf.rrc(:,4:6)-truth.RRC(4:6,:).').^2;
    
end





amm_color='b';
normal_color='g';
imm_color='m';

figure;
ah(1)=subplot(2,1,1);
title('Position Error');
hold on;
grid on
plot(truth.time,sqrt(sum(mc_amm_pos_err,2))./(num_runs),'Color',amm_color,'DisplayName','AMM Position Error');
plot(truth.time,sqrt(sum(mc_imm_pos_err,2))./(num_runs),'Color',imm_color,'DisplayName','IMM Position Error');
plot(truth.time,sqrt(sum(mc_pos_err,2))./(num_runs),'Color',normal_color,'DisplayName','Normal Position Error');
set(gca,'yscale','log')

ah(2)=subplot(2,1,2);
title('Velocity Error');
hold on;
grid on
plot(truth.time,sqrt(sum(mc_imm_vel_err,2))./(num_runs),'Color',imm_color,'DisplayName','IMM Velocity Error');
plot(truth.time,sqrt(sum(mc_amm_vel_err,2))./(num_runs),'Color',amm_color,'DisplayName','AMM Velocity Error');
plot(truth.time,sqrt(sum(mc_vel_err,2))./(num_runs),'Color',normal_color,'DisplayName','Normal Velocity Error');
set(gca,'yscale','log')

linkaxes(ah,'x');