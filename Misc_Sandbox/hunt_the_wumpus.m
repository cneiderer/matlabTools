function [maze_map,sum_total] = hunt_the_wumpus

possible=(1:20)';
maze_map=zeros(20,4);
maze_map(:,1)=possible;
room_cnt=zeros(20,1);
for ii=1:20
    sum_total=get_sum(maze_map);
    room_cnt(ii)=3; 
    possible=possible(possible~=ii);
    
    for jj=1:3
        if (maze_map(ii,jj+1) == 0) && ~isempty(possible)
            room=possible(randi([1,length(possible)]));
            
            cnt=0;
            while (any(maze_map(ii,:) == room) || ~(room_cnt(room) < 3))
                cnt=cnt+1;
                room=possible(randi([1,length(possible)]));
            end
            room_cnt(room)=room_cnt(room)+1;
            maze_map(ii,jj+1)=room;
            
            for kk=1:3
                if (maze_map(room,kk+1) == 0)
                    maze_map(room,kk+1)=ii;
                    break;
                end
            end
            
            if (room_cnt(room) == 3)
                possible=possible(possible~=room);
            end
        end      
    end 
end

test=1;

function [sum_total] = get_sum(maze_map);
sum_total=NaN(20,1);
for ii=1:20
    sum_total(ii)=sum(sum(maze_map(:,2:4)==ii));
end