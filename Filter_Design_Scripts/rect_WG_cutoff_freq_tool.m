function [cutoff_freq] = rect_WG_cutoff_freq_tool(m,n,WG_a,WG_b,units)

%
% rect_WG_cutoff_freq_tool.m
%
% Description:
%   Calculates the cutoff frequency of rectangular waveguide.
%
% Inputs:
%   m       ->
%   n       ->
%   WG_a    ->  a dimension of waveguide
%   WG_b    ->  b dimension of waveguide
%   units   ->  
%
% Outputs:
%   cutoff_freq
%
% Author:
%   Curtis Neiderer, 5/14/2009
%
% Comments / Changes:
%

% Convert to meters if necessary
switch units
    case 'in'
        a=length_conversion_tool('in2m',WG_a);
        b=length_conversion_tool('in2m',WG_b);
    case 'mm'
        a=length_conversion_tool('mm2m',WG_a);
        b=length_conversion_tool('mm2m',WG_b);
    case 'cm'
        a=length_conversion_tool('cm2m',WG_a);
        b=length_conversion_tool('cm2m',WG_b);
end

% Calculate cutoff frequency
cutoff_freq=((3*10^8)/2)*sqrt((m/a)^2+(n/b)^2);