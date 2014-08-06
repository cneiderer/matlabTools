function [] = rect_wg_mode_cutoff_freq

%
% rect_wg_mode_cutoff_freq(m,n).m
%
% Description:
%
% Inputs:
%
% Outputs:
%
% Author:
%   Curtis Neiderer, 1/21/2009
%
% Comments / Changes:
%

% Define constants
freespace_permeability=4*pi*10^-7; % Units [Henry/m]
freespace_permittivity=8.854*10^-12; % Units: [Farad/m]

% Define material constants
relative_permeability=1;
relative_permittivity=1;
% relative_permittivity=2.08; % Teflon = 2.08 [Farad/m]
surface_resistivity=5.8*10^7; % Copper = 5.8*10^7 [Siemens/m]

% Define waveguide dimensions
WG_a=1.872; 
WG_b=0.872;
units='in';

% Convert to correct units
if strcmpi(units,'in') || strcmpi(units,'inch') || strcmpi(units,'inches')
    WG_a=WG_a*(2.54/1)*(1/100);
    WG_b=WG_b*(2.54/1)*(1/100);
elseif strcmpi(units,'cm') || strcmpi(units,'centimeter') || strcmpi(units,'centimeters')
    WG_a=WG_a/100;
    WG_b=WG_b/100;
elseif strcmpi(units,'m') || strcmpi(units,'meter') || strcmpi(units,'meters')
    WG_a=WG_a;
    WG_b=WG_b;
else
    error('Units are in an unrecognized format, use either [in,cm, or m]')
end

% Calculate cutoff frequencies for various modes and store
compiled_list=[];
for n=0:10
    for m=0:10
        if m~=0 || n~=0
        
            % Cutoff frequency calculation [GHz]
            cutoff_freq=(1/(2*pi*sqrt(freespace_permeability*freespace_permittivity*...
                relative_permeability*relative_permittivity)))*sqrt(((m*pi)/WG_a)^2+((n*pi)/WG_b)^2);

            freq=cutoff_freq+(.01*cutoff_freq);

            % Wave number, "k" calculation [m^-1]
            wave_number=((2*pi*freq*sqrt(relative_permittivity))/(3*10^8));

            % Phase Constant, "beta" calculation [m^-1]
            phase_constant=sqrt(wave_number^2-((m*pi)/WG_a)^2-((n*pi)/WG_b)^2); 

            % Surface resistance, "Rs" calculation [Ohm]
            surface_resistance=sqrt((2*pi*freq*freespace_permeability)/(2*surface_resistivity));

            % Instrinsic impedance, "nu" calculation [Ohm]
            intrinsic_impedance=377*sqrt(relative_permeability/relative_permittivity);

            % Attenuation due to conductor [Neper/m]
            cond_att_Np=(surface_resistance/(WG_a^3*WG_b*phase_constant*wave_number*intrinsic_impedance))*...
                ((2*WG_b*pi^2)+(WG_a^3*wave_number^2)); 

            % Convert attenuation from [Np/m] to [dB/m], (Note: 1 Neper = 20/ln(10))
            cond_att_dB=cond_att_Np*(20/log(10));

            compiled_list=[compiled_list;m,n,cutoff_freq,cond_att_Np,cond_att_dB];
        
        end
    end
end

test=1;

%% --------------- %% Sub-Functions %% --------------- %%

% function [cond_att] = calc_cond_att
%                                 
% %% Calculate attenuation due to conductor loss at various modes
% freq=15*10^9;
% m=1;
% n=0;
% 
% % Wave number, "k" calculation [m^-1]
% wave_number=((2*pi*freq*sqrt(relative_permittivity))/(3*10^8));
% 
% % Phase Constant, "beta" calculation [m^-1]
% phase_constant=sqrt(wave_number^2-((m*pi)/WG_a)^2-((n*pi)/WG_b)^2); 
% 
% % Surface resistance, "Rs" calculation [Ohm]
% surface_resistance=sqrt((2*pi*freq*freespace_permeability)/(2*surface_resistivity));
% 
% % Instrinsic impedance, "nu" calculation [Ohm]
% intrinsic_impedance=377*sqrt(relative_permeability/relative_permittivity);
% 
% % Attenuation due to conductor [Neper/m]
% cond_att_Np=(surface_resistance/(WG_a^3*WG_b*phase_constant*wave_number*intrinsic_impedance))*...
%     ((2*WG_b*pi^2)+(WG_a^3*wave_number^2)); 
% 
% % Convert attenuation from [Np/m] to [dB/m], (Note: 1 Neper = 20/ln(10))
% cond_att_dB=cond_att_Np*(20/log(10));
% 
% test=2;