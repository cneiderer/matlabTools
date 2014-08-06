%% Probability, Statistics, and Random Processes for Electrical Engineering
%%  Alberto Leon-Garcia
%%

% Replicating Figure 1.2
results=randint(1,100,[0,2]);

figure(1);
xlim([0,101]);
ylim([-1,3]);
plot((1:100),results);

% Replicating Figure 1.3 & Figure 1.4
trials=5000;

results=randint(1,trials,[0,2]);
cnt_0=0; cnt_1=0; cnt_2=0; 
freq_0=zeros(1,trials); freq_1=zeros(1,trials); freq_2=zeros(1,trials);
for ii=1:trials
    switch results(ii)
        case 0
            cnt_0=cnt_0+1;
        case 1
            cnt_1=cnt_1+1;
        case 2
            cnt_2=cnt_2+1;
        otherwise
            
    end
    freq_0(ii)=cnt_0/ii;
    freq_1(ii)=cnt_1/ii;
    freq_2(ii)=cnt_2/ii;
end

figure(2);
plot((1:trials),freq_0,(1:trials),freq_1,(1:trials),freq_2)

%

