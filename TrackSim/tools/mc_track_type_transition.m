function [e2b_amm_times,b2e_amm_times,e2b_times,b2e_times]= mc_track_type_transition(data_loc,num_runs)

e2b_amm_times=[];
b2e_amm_times=[];
e2b_times=[];
b2e_times=[];

for ii=1:num_runs
    load(fullfile(data_loc,strcat('run_',num2str(ii),'_out.mat')));
%find exo to boost track type transition
e2b_amm=find(diff(trackdata.amm_track_type)==1)+1;
e2b_amm_times=[e2b_amm_times trackdata.det_time(e2b_amm).'];

%find boost to exo track type transition
b2e_amm=find(diff(trackdata.amm_track_type)==-1)+1;
b2e_amm_times=[b2e_amm_times trackdata.det_time(b2e_amm).'];

%find exo to boost track type transition
e2b=find(diff(trackdata.track_type)==1)+1;
e2b_times=[e2b_times trackdata.det_time(e2b).'];

%find boost to exo track type transition
b2e=find(diff(trackdata.track_type)==-1)+1;
b2e_times=[b2e_times trackdata.det_time(b2e).'];

end


amm_color='g';
normal_color='b';

figure; 
ax(1)=subplot(3,1,1);
title('Residual Acceleration');
ylabel('Residual Acceleration m/s^2');
xlabel('Time (sec)');
hold on
grid on
plot(truth.time(2:end),truth.residial_acc(2:end),'-k','LineWidth',1.5);
ax(2)=subplot(3,1,2);
title('AMM Track Type Transitions');
ylabel('Number of Runs');
xlabel('Time (sec)');
hold on
grid on
hist(e2b_amm_times,300,'Color',amm_color);
hist(b2e_amm_times,300,'Color',amm_color);
ax(3)=subplot(3,1,3);
title('Track Type Transitions');
ylabel('Number of Runs');
xlabel('Time (sec)');
hold on
grid on
hist(e2b_times,300,'Color',normal_color);
hist(b2e_times,300,'Color',normal_color);
linkaxes(ax,'x');


 
