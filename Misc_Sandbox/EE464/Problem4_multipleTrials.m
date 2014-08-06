function []=Problem4_multipleTrials(num_trials,num_packets)

% num_packets_array=100:100:1000;
% num_packets_array=1100:100:2000;
% num_packets_array=2100:100:3000;
% num_packets_array=3100:100:4000;
% num_packets_array=4100:100:5000;
% num_trials=100;

% f_num=0; 
% tic
% for kk=1:length(num_packets_array)
% 
%     display(['Iteration: ',num2str(kk)]);
%     
%     num_packets=num_packets_array(kk);
    
    multipleTrials_packetCount=NaN(num_trials,1);
    for jj=1:num_trials        
        % Generate send file
        send_file=[1:num_packets]';

        % Create empty receive file
        receive_file=NaN(num_packets,1);

        ii=0;
        packet_cnt=0;
        packets_received=[];
        while ii==0
            % Randomly select packet numbers to send
            random_packet=randi(num_packets,1,1);
            packet_cnt=packet_cnt+1;

            % Place packet in receive file
            receive_file(random_packet)=random_packet;
            packets_received=[packets_received;random_packet];

            % Check to see if whole file has been received
            if receive_file==send_file
                ii=1;
            end
        end

        % Collect packet count from each trial
        multipleTrials_packetCount(jj)=packet_cnt;
    end

    %% Plot histogram of packets received
    
%     f_num=f_num+1;
%     figure(f_num);
    f1=figure(1);

    hist(multipleTrials_packetCount,20);
    xlabel('X number of packets sent to receive entire file');
    ylabel('Number of trials with X number of packets');
    title([num2str(num_packets),' Packet File: ',num2str(num_trials),' Trials']);
    hold on;

    % Find limits of histogram
    n=hist(multipleTrials_packetCount,20);
    n_max=max(n);

    % Calculate the estimate for the expectation of X
    expectation_est_hi=(num_packets*log(num_packets))+num_packets;
    expectation_est_lo=num_packets*log(num_packets);

    % Calculate mean, standard deviation, and variance from simulation
    mean_pkts_sent=mean(multipleTrials_packetCount);
    std_pkts_sent=std(multipleTrials_packetCount);
    var_pkts_sent=var(multipleTrials_packetCount);

    % Add E[X] estimate, sim mean, sim std plots to figure
%     plot([8000,8000],[0,n_max],'--k','LineWidth',2);
    plot([expectation_est_hi,expectation_est_hi],[0,n_max],'--c','LineWidth',2);
    plot([expectation_est_lo,expectation_est_lo],[0,n_max],'--c','LineWidth',2);
    plot([mean_pkts_sent,mean_pkts_sent],[0,n_max],'--g','LineWidth',2);
    plot([mean_pkts_sent-std_pkts_sent,mean_pkts_sent-std_pkts_sent],[0,n_max],...
        '--r','LineWidth',2);
    plot([mean_pkts_sent+std_pkts_sent,mean_pkts_sent+std_pkts_sent],[0,n_max],...
        '--r','LineWidth',2);
    
    % Add legend with rounded numbers
    legend('',...
        ['X = 8000, P(X >= 8000) = ',num2str(sum(multipleTrials_packetCount>=8000)/num_trials)],...
        ['E[X] Estimate "High" = ',num2str((round(100*expectation_est_hi))/100)],...
        ['E[X] Estimate "Low" = ',num2str((round(100*expectation_est_lo))/100)],...
        ['Simulation Mean \mu = ',num2str((round(100*mean_pkts_sent))/100)],...
        ['Simulation Standard Deviation \sigma = ',num2str((round(100*std_pkts_sent))/100)]);
    hold off;

    save(['D:\My_Courses\USC_Courses\EE464_FA2010\Homeworks\',...
        'pktSim_1000Trials_n1000.mat'],'multipleTrials_packetCount');
    
    test=1;
    
%     time=round(((toc/60)*100)/100)-time;
%     display(['... Time Elapsed = ',num2str(time),' minutes']);
% end
% total_time=round((toc/60)*100)/100;
% display(['... Time Elapsed = ',num2str(total_time),' minutes']);