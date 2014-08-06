function [percent_increase]=calculate_percent_increase(rnd_lbs)

for ii=1:length(rnd_lbs)-1
    percent_increase(ii,1)=ceil(100-(rnd_lbs(ii)/rnd_lbs(ii+1))*100);
end
