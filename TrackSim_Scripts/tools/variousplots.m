figure;
hold on
grid on
title('Tom Kurien IMM')
xlabel('Time (sec)')
ylabel('Model Probability')
plot(trackdata.det_time,trackdata.imm_mProb);
legend(gca,'6 State','10 State')
ylim(gca,[0 1])

figure;
hold on
grid on
title('Poor Man''s IMM')
xlabel('Time (sec)')
ylabel('Model Probability')
plot(trackdata.det_time,trackdata.imm.p6,'Color','c','DisplayName','6 State Probability');
plot(trackdata.det_time,trackdata.imm.p8b,'Color','k','DisplayName','8 State Probability');
plot(trackdata.det_time,trackdata.imm.p10b,'Color','m','DisplayName','10 State Probability');
legend show
ylim(gca,[0 1])

plot_amm_score(trackdata,Tupper,Tlower)


