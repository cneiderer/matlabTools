function [updated_num] = expand_to_N_decimal_places(num,N)

div_coefficient=10^N;
current_decimal_places=length(num2str(mod(num,10^N)));

test=1;