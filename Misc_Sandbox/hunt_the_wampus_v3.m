function [maze_map] = hunt_the_wampus_v3

possible=(1:20)';
possible_matrix=repmat((1:20)',1,4);
maze_map=zeros(20,4);
% maze_map(:,1)=possible;
room_cnt=zeros(20,1);

for ii=1:4
    possible_vector=possible;
    for ii=1:20
        possible_vector=
        room=possible_vector(randi([1,length(possible_vector)]));
    