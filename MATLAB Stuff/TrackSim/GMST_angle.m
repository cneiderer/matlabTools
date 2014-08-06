function angle_GMST = GMST_angle(year, day, UT, GMST_k)
%
%     angle_GMST = GMST_angle(year, day, UT, GMST_k)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculates the Greenwich Mean Sidereal Time angle, in degrees
%
%   Input:
%        year  --  year (e.g. 1988)
%        day   --  day  (day of year, integer, Jan 1 = 1),
%        UT    --  Universal Time = hours since midnight along Greenwich
%                  Meridian; 0<=UT<=24, (1XN)
%        GMST_k
%
%   Output:
%        angle_GMST  --  Greenwich Mean Sidereal Time angle (deg)
%                   
%   Required Functions:
%        none
%

% Definition of Julian Day: 
%   JD = GMST_k(7) + GMST_k(8)*year - fix(GMST_k(9)*year) + day+UT/GMST_k(10);

% Julian Day at 0 hours UT
JD_0 = GMST_k(7) + GMST_k(8)*year - fix(GMST_k(9)*year) + day; 
T_0  = (JD_0 - GMST_k(5)) / GMST_k(6);

angle_GMST = rem(GMST_k(1) + GMST_k(2)*T_0 + GMST_k(3)*T_0.^2 ...
                  + GMST_k(4)*UT, 360);
%

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
