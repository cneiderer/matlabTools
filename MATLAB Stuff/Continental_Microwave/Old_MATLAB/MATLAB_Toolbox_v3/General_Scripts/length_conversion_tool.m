function [output_length] = length_conversion_tool(spec_conversion,input_length)

%
% length_conversion_tool.m
%
% Description:
%   Converts a length value from one type of units to another.
%
% Inputs:
%   spec_coversion  ->  specific conversion name
%   input_length    ->  length value to be converted
%
% Outputs:
%   output_length   ->  converted length value
%
% Author:
%   Curtis Neiderer, 5/14/2009
%
% Comments / Changes:
%


switch spec_conversion
    case 'in2mm'
        output_length=input_length*(2.54/1)*(1/10);
    case 'in2cm'
        output_length=input_length*(2.54/1);
    case 'in2m'
        output_length=input_length*(2.54/1)*(1/100);
    case 'mm2in'
        output_length=input_length*(1/10)*(1/2.54);
    case 'cm2in'
        output_length=input_length*(1/2.54);
    case 'm2in'
        output_length=input_length*(100/1)*(1/2.54);
    case 'mm2m'
        output_length=input_length*(1/1000);
    case 'cm2m'
        output_length=input_length*(1/100);
end

