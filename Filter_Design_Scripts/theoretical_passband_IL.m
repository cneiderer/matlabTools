function [passband_attenuation]=theoretical_passband_IL(varargin)

%
% theoretical_passband_IL.m
%
% Description:
%   Calculates the theoretical insertion loss across the designated
%   passband.
%
% Inputs:
%   passband_ripple         -> [dB]
%   center_freq             -> [GHz]
%   lo_corner_freq          -> [GHz]
%   hi_corner_freq          -> [GHz]
%   lo_attenuation_freq     -> [GHz]
%   hi_attenuation_freq     -> [GHz]
%   desired_attenuation     -> [dB]
%   waveguide_a             -> [in]
%   waveguide_b             -> [in]
%   iris_thickness          -> [in]
%
% Outputs:
%   passband_attenuation
%
% Author:
%   Curtis Neiderer, 4/15/2009
%
% Notes / Changes:
%

%%
if nargin==10
    % Details of desired filter design are
    passband_ripple=varargin{1};
    center_freq=varargin{2};
    lo_corner_freq=varargin{3};
    hi_corner_freq=varargin{4};
    lo_attenuation_freq=varargin{5};
    hi_attenuation_freq=varargin{6};
    desired_attenuation=varargin{7};
    waveguide_a=varargin{8};
    waveguide_b=varargin{9};
    iris_thickness=varargin{10};
else
    % Prompt for details of desired filter design
    passband_ripple=input('Please enter the passband ripple [dB]: ');
    center_freq=input('Please enter the center frequency [GHz]: ');
    lo_corner_freq=...
        input('Please enter the low edge of the passband [GHz]: ');
    hi_corner_freq=...
        input('Please enter the high edge of the passband [GHz]: ');
    lo_attenuation_freq=...
        input('Please enter the low attenuation frequency [GHz]: ');
    hi_attenuation_freq=...
        input('Please enter the high attenuation frequency [GHz]: ');
    desired_attenuation=...
        input('Please enter the desired attenuation [dB]: ');
    waveguide_a=...
        input('Please enter the a dimension of the waveguide [in]: ');
    waveguide_b=...
        input('Please enter the b dimension of the waveguide [in]: ');
    iris_thickness=input('Please enter the iris thickness [in]: ');
end

%% Calculate the guide wavelengths
lo_corner_guideLambda=guide_wavelength_calc(lo_corner_freq,waveguide_a);
hi_corner_guideLambda=guide_wavelength_calc(hi_corner_freq,waveguide_a);
center_freq_guideLambda=(lo_corner_guideLambda+hi_corner_guideLambda)/2;
lo_attenuation_guideLambda=...
    guide_wavelength_calc(lo_attenuation_freq,waveguide_a);
hi_attenuation_guideLambda=...
    guide_wavelength_calc(hi_attenuation_freq,waveguide_a);

%% Calculate guide wavelength fractional bandwidth and fractional bandwidth
bandwidth_guideLambda=(lo_corner_guideLambda-hi_corner_guideLambda)/...
    center_freq_guideLambda;
bandwidth=(hi_corner_freq-lo_corner_freq)/center_freq;

%% Calculate attenuation frequency ratios
lo_attenuation_freq_ratio=abs((2/bandwidth_guideLambda)*...
    ((center_freq_guideLambda-lo_attenuation_guideLambda)/...
    center_freq_guideLambda));
hi_attenuation_freq_ratio=abs((2/bandwidth_guideLambda)*...
    ((center_freq_guideLambda-hi_attenuation_guideLambda)/...
    center_freq_guideLambda));

%% Calculate epsilon
epsilon=(10^(passband_ripple/10))-1;

%% Calculate filter order
lo_filter_order=...
    ceil(real(solve([num2str(desired_attenuation),'=10*log10(1+(',...
    num2str(epsilon),'*(cosh(order*acosh(',...
    num2str(lo_attenuation_freq_ratio),')))^2))'],'order')));
lo_filter_order=double(lo_filter_order(1));
hi_filter_order=...
    ceil(real(solve([num2str(desired_attenuation),'=10*log10(1+(',...
    num2str(epsilon),'*(cos(order*acos(',...
    num2str(hi_attenuation_freq_ratio),')))^2))'],'order')));
hi_filter_order=double(hi_filter_order(1));

filter_order=max([lo_filter_order,hi_filter_order]);

% Double-check attenuation based on filter_order calculation
actual_lo_attenuation=10*log10(1+epsilon*...
    (cosh(filter_order*acosh(lo_attenuation_freq_ratio)))^2);
actual_hi_attenuation=10*log10(1+epsilon*...
    (cos(filter_order*acos(hi_attenuation_freq_ratio)))^2);

%% Calculate passband IL
passband_freqs=(lo_corner_freq:.00001:hi_corner_freq)';
passband_guideLambdas=[];
passband_freq_ratios=[];
passband_attenuation=[]; 
% passband_attenuation2=[];
for ii=1:length(passband_freqs)
    
    % guide wavelength calc
    temp_guideLambda=guide_wavelength_calc(passband_freqs(ii),waveguide_a);
    passband_guideLambdas=[passband_guideLambdas;temp_guideLambda];
        
    % attenuation freq ratio calc
    temp_freq_ratio=abs((2/bandwidth_guideLambda)*...
        ((center_freq_guideLambda-temp_guideLambda)/...
        center_freq_guideLambda));  
    passband_freq_ratios=[passband_freq_ratios;temp_freq_ratio];
    
    % actual attenuation calc
    temp_atten=10*log10(1+epsilon*...
        (cosh(filter_order*acosh(temp_freq_ratio)))^2);   
	passband_attenuation=[passband_attenuation;temp_atten];
    
%     temp_atten2=10*log10(1+epsilon*...
%         (cos(filter_order*acos(temp_freq_ratio)))^2);
%     passband_attenuation2=[passband_attenuation2;temp_atten2];
        
    % clear temporary variables
    clear temp_guideLamba temp_freq_ratio temp_atten temp_atten2
    
end

test=1;

% Plot theoretical passband 
pb=figure(1);
plot(passband_freqs,passband_attenuation);
xlim([(lo_corner_freq*.999) (hi_corner_freq*1.001)]);

test=1;

%%%%% ---------- %% Sub-Functions %% ---------- %%%%%

%% Calculates the guide wavelength in inches
function [guideLambda] = guide_wavelength_calc(freq,waveguide_a)
guideLambda=1/sqrt((0.08472*freq)^2-(1/(2*waveguide_a))^2);