function [Scaling_Range] = temp_drift_scaling(T_lo,T_hi,mat_index)

%
% temp_drift_scaling.m
%
% Inputs:
%   T_lo        ->  min operating temperature
%   T_hi        ->  max operating temperature
%   mat_index    ->  material index [1-6]
%
% Outputs:
%   Scaling_Range   -> min & max scaling factors
%
% Author:
%   Curtis Neiderer, 5/14/2009
%
% Notes / Changes:
%   Version 1.1: 5/14/2009
%       Basic scaling factor calculations, modeled after WASP-Net Tutorial
%       example.
%

% Material Lookup
temp_co=temp_coefficient_lookup(mat_index);

% Calculate Scaling Factors
lo_scale=temp_co*(T_lo-20);
hi_scale=temp_co*(T_hi-20);
Scaling_Range=[lo_scale,hi_scale];

test=1;


%%%%% ---------- %% Sub-Functions %% ---------- %%%%%
function [temp_co]=temp_coefficient_lookup(index)

if index==6
    temp_co=input('Define the temp coefficient of your material: ');
else
    % index,name,temp_coefficient
    material_list={...
        '1','Aluminum','23*10^-6';
        '2','Copper','17*10^-6';
        '3','Brass','18*10^-6';
        '4','Silver','20*10^-6';
        '5','INVAR','1.18*10^-6'};
    temp_co=str2num(material_list{Material,3});
end
