function [total_int,mths_to_payoff]=...
    mths_to_car_payoff_and_total_interest(payment,int_rate,outstanding)

% MTHS_TO_CAR_PAYOFF_AND_TOTAL_INTEREST
%
% Description:
%   Calculates the months until car loan is paid off and the total interest
%   paid over that period, given the payment amount entered.  [Note: For
%   the purposes of this script 1 month = 30 days.]
%
% Inputs:
%   payment     -   average monthly payment
%   int_rate    -   annual percentage rate of loan
%   outstanding -   outstanding principal balance
% 
% Outputs:
%   total_int   -   total interest paid of remaining life of loan
%   mths_to_payoff  -   total months left in life of loan
%
% Author:
%   Curtis Neiderer, 7/16/2010
%
% Change History Log:
%

if nargin < 3
    outstanding=9436.93;
    int_rate=0.0704;
end

payment_days=30;

current_balance=outstanding;
interest=0;
total_int=0;
mths_to_payoff=0;
while current_balance > 0
    mths_to_payoff=mths_to_payoff+1;
    if current_balance+interest < payment
        payment=current_balance+interest;
    end
    
    current_balance=current_balance-payment+interest;
    interest=((int_rate*current_balance)/365)*payment_days;
    total_int=total_int+interest;
    
    if current_balance < 10^-4
        current_balance=0;
    end
end
