function T_RRC_RFC = get_T_rrc_rfc(clock, az, el)
%     T_RRC_RFC = Get_T_RRC_RFC(clock, az, el)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculates the RRC to RFC position transformation matrix given the
%   orientation of the radar and some physical constants.
%
%   Input:
%        clock      --  radar clocking angle (rad)
%        az         --  radar azimuth angle (rad)
%        el         --  radar elevation angle (rad)
%
%   Output:
%        T_RRC_RFC  --  RRC to RFC position transformation matrix
%                   
%   Required Functions:
%        NONE


cos_clock = cos(clock);
sin_clock = sin(clock);
cos_az    = cos(az);
sin_az    = sin(az);
cos_el    = cos(el);
sin_el    = sin(el);

%Rotation matrix about the roll angle
Tnu       =   [  cos_clock           sin_clock              0.;   ...
                -sin_clock           cos_clock              0.;   ...
                   0.                   0.                  1.];
%
%Rotation matrix about the elevation angle
Tel       =   [    1.                   0.                  0.;   ...
                   0.                cos_el            -sin_el;   ...
                   0.                sin_el             cos_el];
%
%Rotation matrix about the azimuth angle
Ta        =   [  cos_az                 0.              sin_az;  ...
                   0.                   1.                  0.;       ...
                -sin_az                 0.              cos_az];

T0        =   [   -1.                   0.                  0.;      ...
                   0.                   0.                  1.;      ...
                   0.                   1.                  0.];
%

T_RRC_RFC = Tnu * Tel * Ta * T0;

return

%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
