function [packet_cnt,packets_received,f1]=Problem4(num_packets)

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

% Plot histogram of packets received
f1=figure(1);
hist(packets_received,20);