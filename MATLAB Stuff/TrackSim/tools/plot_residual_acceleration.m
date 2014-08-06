function plot_residual_acceleration(truth,trackdata,radar,constants)



figure; 
title('Residual Acceleration');
ylabel('Residual Acceleration m/s^2');
xlabel('Time (sec)');
hold on
grid on
h(1)=plot(trackdata.det_time(3:end),trackdata.amm_acceleration(3:end,3),'b:','Displayname','AMM Residual Acceleration');
%plot_color_coded(gca,trackdata.det_time(3:end),trackdata.amm_acceleration(3:end,3),trackdata.amm_track_type(3:end));
hold on; h(2)=plot(trackdata.det_time(3:end),trackdata.acceleration(3:end,3),'g-.','Displayname','Normal Filter Residual Acceleration');
%plot_color_coded(gca,trackdata.det_time(3:end),trackdata.acceleration(3:end,3),trackdata.track_type(3:end));
plot(truth.time(2:end),truth.residial_acc(2:end),'-k','LineWidth',1.5);

%find exo to boost track type transition
e2b_amm=find(diff(trackdata.amm_track_type)==1)+1;
plot(trackdata.det_time(e2b_amm),trackdata.amm_acceleration(e2b_amm,3),'bp','MarkerFaceColor','b')
text(trackdata.det_time(e2b_amm),trackdata.amm_acceleration(e2b_amm,3),'EXO->BST','FontSize',8)

%find boost to exo track type transition
b2e_amm=find(diff(trackdata.amm_track_type)==-1)+1;
plot(trackdata.det_time(b2e_amm),trackdata.amm_acceleration(b2e_amm,3),'bp','MarkerFaceColor','b')
text(trackdata.det_time(b2e_amm),trackdata.amm_acceleration(b2e_amm,3),'BST->EXO','FontSize',8)

%find exo to boost track type transition
e2b=find(diff(trackdata.track_type)==1)+1;
plot(trackdata.det_time(e2b),trackdata.acceleration(e2b,3),'gp','MarkerFaceColor','g')
text(trackdata.det_time(e2b),trackdata.acceleration(e2b,3),'EXO->BST','FontSize',8)

%find boost to exo track type transition
b2e=find(diff(trackdata.track_type)==-1)+1;
plot(trackdata.det_time(b2e),trackdata.acceleration(b2e,3),'gp','MarkerFaceColor','g')
text(trackdata.det_time(b2e),trackdata.acceleration(b2e,3),'BST->EXO','FontSize',8)
grid on

legend(gca,h)