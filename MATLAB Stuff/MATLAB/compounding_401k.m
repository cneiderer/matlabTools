function [balance_growth]=compounding_401k()

annual_contribution=10000;
current_balance=40000;
min_growth_per_year=.05;
retirement_age=65;
current_age=26;
years_experience=3;
current_salary=70500;
min_raise_per_year=.03;
company_401k_match=.04;
company_retirement_contribution=.03;

timeline=current_age:retirement_age;
balance_growth=zeros(length(timeline),5);
for ii=1:length(timeline)
    contribution_percentage=(annual_contribution/current_salary)*100;
    balance_growth(ii,:)=[timeline(ii),current_balance,...
        years_experience,current_salary,contribution_percentage];
    current_balance=current_balance+annual_contribution+current_salary...
        *(company_401k_match+company_retirement_contribution)...
        +current_balance*min_growth_per_year;
    current_salary=current_salary*(1+min_raise_per_year);
    years_experience=years_experience+1;
end

