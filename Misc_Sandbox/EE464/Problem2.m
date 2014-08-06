function []=Problem2

% Define variance array
noise_var=[(1/50):(1/50)/4:(1/5)]';
% noise_var=(1/4);

overall_prob_err=zeros(length(noise_var),1);
for ii=1:length(noise_var)
    % Calculate array to take Q of for "X=+1"
    X_pos1_arg=(1-((1/32)*log(3)))/(noise_var(ii));

    % Calculate array to take Q of for "X=-1"
    X_neg1_arg=(((1/32)*log(3))+1)/(noise_var(ii));

    % Calculate overall probability of error
    overall_prob_err(ii)=(Q(X_neg1_arg)*(3/4))+(Q(X_pos1_arg)*(1/4));
end

% Plot the overall probability of error as a function of noise variance
f1=figure(1);
plot(noise_var,overall_prob_err,'LineWidth',2);
xlabel('Noise Varance \sigma = 1/50 through 1/5');
ylabel('Overall Probability of Error');
title('Binary Transmission System');


%% Q calculation sub-function
function y=Q(x)

x=x';
y=0.5*erfc(x/sqrt(2));