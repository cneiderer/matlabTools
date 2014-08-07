function [height] = Calc_ht(sv, T_rrc_ecr, Re, Rp)
%     [height] = Calc_ht(sv, T_rrc_ecr, Re, Rp)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculate the altitude using RRC coordinates measured from earth
%      center.
%
%   Input:
%        sv         --  1x3 RRC states measured from earth center
%        T_rrc_ecr  --  RRC to ECR transformation matrix
%        Re         --  Equatorial radius of the earth
%        Rp         --  Polar radius of the earth
%
%   Output:
%        height -- the height above the surface of the earth (meters) (1x1)
%                   
%   Required Functions:
%        norm
%        sqrt
%


K      =   Re^2 / Rp^2 - 1;

Pecr        =   T_rrc_ecr * sv(1:3);
sPhi        =   Pecr(3)/ norm(Pecr);    % sin of the geocentric latitude
height      =   norm(sv(1:3)) -  Re / sqrt(1 + K*sPhi^2) ;

return

%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
