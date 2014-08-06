function []=Problem5(num_trials)

%% Organize grade data based on provided histogram
bin_size=(120-25)/20; % Histogram provided ranges ~ 25 to 120 in 20 bins
bin_loc=[25+(bin_size/2):bin_size:120-(bin_size/2)]'; % Calculate bin centers
grade_freq=[2,2,1,3,2,2,3,4,4,3,8,7,11,7,1,4,3,5,3,5]'; % Grade freq per bin

% Center grades per bin at bin centers since you don't know the actual grades
midterm_grades=[];
for ii=1:length(bin_loc)
    for jj=1:grade_freq(ii)
        midterm_grades=[midterm_grades;bin_loc(ii)];
    end
end

%% Randomly sample RVs X1, X2, X3, X4
% num_trials=length(midterm_grades);
sampled_RVs=NaN(num_trials,4);
for ii=1:4
    rand_indx=randi(length(midterm_grades),num_trials,1);
    sampled_RVs(1:num_trials,ii)=midterm_grades(rand_indx);
end

%% Sum RVs and plot histograms
num_bins=25;

% X1
X1=sampled_RVs(1:end,1);
f1=figure(1);
hist(X1,num_bins);
xlabel('X1');
ylabel('Count');
title(['Part (a) - RV X1 sampled ',num2str(num_trials),' times']);

% X1+X2
sum_X1_X2=sampled_RVs(1:end,1)+sampled_RVs(1:end,2);
f2=figure(2);
hist(sum_X1_X2,num_bins);
xlabel('X1 + X2');
ylabel('Count');
title(['Part (c) - Sum of RVs X1+X2, each RV sampled ',num2str(num_trials),' times']);

% X1+X2+X3
sum_X1_X2_X3=sampled_RVs(1:end,1)+sampled_RVs(1:end,2)+sampled_RVs(1:end,3);
f3=figure(3);
hist(sum_X1_X2_X3,num_bins);
xlabel('X1 + X2 + X3');
ylabel('Count');
title(['Part (c) - Sum of RVs X1+X2+X3, each RV sampled ',...
    num2str(num_trials),' times']);

% X1+X2+X3+X4
sum_X1_X2_X3_X4=sampled_RVs(1:end,1)+sampled_RVs(1:end,2)+...
    sampled_RVs(1:end,3)+sampled_RVs(1:end,4);
f4=figure(4);
hist(sum_X1_X2_X3_X4,num_bins);
xlabel('X1 + X2 + X3 + X4');
ylabel('Count');
title(['Part (c) - Sum of RVs X1+X2+X3+X4, each RV sampled ',...
    num2str(num_trials),' times']);

