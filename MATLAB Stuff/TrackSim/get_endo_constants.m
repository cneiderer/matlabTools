function endo = get_endo_constants(sys_saps, map_saps)
%   UNCLASSIFIED
%
%   DESCRIPTION
%       Returns ENDO constants
%
%   Input:
%        sys_saps     --  structure of system saps with the following
%                         fields
%           sys_sap_4060     --  Alpha profile upper reference height
%           sys_sap_4061     --  Alpha profile lower reference height
%           sys_sap_4062     --  Nominal ballistic coefficient for heights
%                                greater than alpha profile upper reference
%                                height
%           sys_sap_4063     --  Nominal ballistic coefficient for heights
%                                less than alpha profile lower reference 
%                                height
%
%        map_saps     --  structure of system saps with the following
%                         fields
%           map_tp_sap_1059  --  Beta profile midpoint slope scaling factor
%
%   Output:
%        endo -- structure with the following fields
%           h0          --  Alpha profile upper reference height
%           h1          --  Alpha profile lower reference height
%           beta0       --  
%           beta1       --  
%           beta_mid    --  The midpoint between beta0 and beta1
%           h_mid       --  The midpoint between h0 and h1
%           del_height  --  (h1 - h0) / 2
%           del_beta    --  (beta1 - beta0) / 2
%           beta_k1     --  Nominal ballistic coefficient for heights
%                           greater than alpha profile upper reference
%                           height
%           beta_k2     --  
%           beta_k3     --  
%                   

if nargin ~=2
   error('Please pass in sap values into get_endo_constants.');
end

%Check to make sure the input structures have the proper fields
if (~isfield( sys_saps, 'sys_sap_4060')) || isempty(sys_saps.sys_sap_4060)
   error('get_endo_constants:  Please provide a value for sys_sap_4060');
elseif (~isfield(sys_saps, 'sys_sap_4061')) || isempty(sys_saps.sys_sap_4061)
   error('get_endo_constants:  Please provide a value for sys_sap_4061');
elseif (~isfield(sys_saps, 'sys_sap_4062')) || isempty(sys_saps.sys_sap_4062)
   error('get_endo_constants:  Please provide a value for sys_sap_4062');
elseif (~isfield(sys_saps, 'sys_sap_4063')) || isempty(sys_saps.sys_sap_4063)
   error('get_endo_constants:  Please provide a value for sys_sap_4063');
elseif (~isfield(map_saps, 'map_tp_sap_1059')) || isempty(map_saps.map_tp_sap_1059)
   error('get_endo_constants:  Please provide a value for map_tp_sap_1059');
end

endo.h0          =    sys_saps.sys_sap_4060;
endo.h1          =    sys_saps.sys_sap_4061;

endo.beta0       =    sys_saps.sys_sap_4062;
endo.beta1       =    sys_saps.sys_sap_4063;
                                         
endo.beta_mid    =    ( endo.beta0 + endo.beta1 ) / 2.0;
endo.h_mid       =    ( endo.h0    + endo.h1    ) / 2.0;

endo.del_height  =    ( endo.h0    - endo.h1    ) / 2.0;
endo.del_beta    =    ( endo.beta0 - endo.beta1 ) / 2.0;

endo.beta_k1     =    map_saps.map_tp_sap_1059 * endo.del_beta / endo.del_height;
endo.beta_k2     =    ( 3 * endo.del_beta - 2 * endo.beta_k1 * endo.del_height)  / endo.del_height^2;
endo.beta_k3     =    (-2 * endo.del_beta + endo.beta_k1 * endo.del_height)      / endo.del_height^3;
