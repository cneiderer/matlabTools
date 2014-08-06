function [] = calculate_edge_attenuation

%
% calculate_edge_attenuation.m
%
% Description:
%
% Inputs:
%   passband_ripple
%   
% Outputs:
%
% Author:
%

%% Prompt for details of desired filter
ripple=input('Please enter the passband ripple [dB]: ');
center_freq=input('Please enter the center frequency [GHz]: ');
lo_corner_freq=input('Please enter the low edge of the passband [GHz]: ');
hi_corner_Freq=input('Please enter the high edge of the passband [GHz]: ');
lo_attenuation_freq=input('Please enter the low attenuation frequency [GHz]: ');
hi_attenuation_freq=input('Please enter the high attenuation frequency [GHz]: ');
waveguide_a=input('Please enter the a dimension of the waveguide [in]: ');
waveguide_b=input('Please enter the b dimension of the waveguide [in]: ');

%%
% Calculate the guide wavelengths



% Calculate the operating wavelengths
center_lambda=((3*10^8)/center_freq)*(100/2.54);

lo_atten_lambda=1/sqrt((.08472*lo_attenuation_freq)^2-(1/(2*waveguide_a))^2);
hi_atten_lambda=1/sqrt((.08472*hi_attenuation_freq)^2-(1/(2*waveguide_a))^2);




%% Calculate epsilon
epsilon=(10^(ripple/10))-1;

%% Calculate attenuation for each filter order 

%
lo_atten_ratio=(2/bandwidth)*((center_lambda-lo_atten_lambda)/center_lambda);
hi_atten_ratio=(2/bandwidth)*((center_lambda-hi_atten_lambda)/center_lambda);

for n=1:20

        % Calculate attenuation
        low_corner_attenuation=10*log10(1+(epsilon*(cos(n*acos(freq_ratio)))^2));
        hi_corner_attenuation=10*log10(1+(epsilon*(cos(n*acos(freq_ratio)))^2));
    
        % Format for display
        possibilities(n,:)=[n,low_corner_attenuation,hi_corner_attenuation];
        
end

disp(possibilities)


%% ---------- %% Sub-Functions %% ---------- %%
