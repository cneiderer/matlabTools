function GMST_k = GMST_parameters
%   UNCLASSIFIED
%
%   DESCRIPTION
%      Initialize the Greenwich Mean Sidereal Time Parameters
%
%   Input:
%        none
%
%   Output:
%        GMST_k  --  vector of the Greenwich Mean Sidereal Time Parameters
%
  
% Greenwich Mean Sidereal Time Parameters
GMST_k(1)  = 100.4606184;  % approximate angle (within 0.5 deg) of vernal 
                           % equinox at midnight, beginning year 2000
GMST_k(2)  = 36000.77004;  % (deg/century) converts to earth spin rate 
                           % in dg/day mod 360
GMST_k(3)  = 0.000387933;  % (deg/century^2) accounts for precession of 
                           % earth spin axis over centuries
GMST_k(4)  = 15.04106864;  % (deg/hour) earth spin rate
GMST_k(5)  = 2451545.0;    % (days) Julian day number beginning at 12 noon, 
                           % Jan 1, 2000
GMST_k(6)  = 36525.0;      % (days/century) days elapsed in a century, 
                           % including leap days
GMST_k(7)  = 1721043.5;    % (days) Julian Day number for 0 A.D., but 
                           % padded with leap days for 0 to 1900 A.D.
GMST_k(8)  = 367.0;        % (days) used in conjunction with k_9 to account 
                           % for days per year, plus a leap day every four 
                           % years
GMST_k(9)  = 1.75;         % (days) see k_8
GMST_k(10) = 24.0;         % (hours) used to convert UT in hours to days