function table = get_atmos_table
%   UNCLASSIFIED
%
%   DESCRIPTION
%       Obtains parameters from atmospheric table
%
%   Input:
%        None
%
%   Output:
%        table -- structure with the following fields
%           base_density   --  in kg/m^3
%           base_altitude  --  in meters
%           scale_height   --  in meters
%           exponent       --  unitless
%                   


% As in Table V (U) Standard Atmosphere Parameters (Comdoc Rev N)
% This table is unclassified, and the values contained are thus also
% unclassified.

table.base_density = [ 1.225 % kg/m^3
        0.36392
        0.088035
        0.013225
        0.0014275
        0.0008616
        6.4211e-005
        6.958e-006
        3.416e-006
        5.604e-007
        9.708e-008
        2.222e-008
        2.076e-009
        1.916e-011];

table.base_altitude = [ 0 % meters
        11019
        20063
        32162
        47350
        51413
        71802
        86000
        90000
        100000
        110000
        120000
        150000
        300000];

table.scale_height = [ -44850.5 % meters
                6372.606
                204123.4
                80293.46
                8047.316
                -101034
                -113337
                5622.543
                -336962
                679507.9
                18351.52
                26848.8
                92607.05
                317338.2];
%
%The zeros here represent N/A
table.exponent = [ -4.305
                 0
             32.92
             12.85
                 0
            -11.52
            -16.61
                 0
               -60
               120
              3.39
              3.16
             4.865
             7.374];                
