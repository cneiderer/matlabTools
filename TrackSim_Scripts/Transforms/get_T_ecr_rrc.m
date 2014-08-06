function T_ECR_RRC = get_T_ecr_rrc(lat, lon)
%
%     T_ECR_RRC = Get_T_ecr_rrc(lat, lon)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculate the ECR to RRC position transformation matrix
%
%   Input:
%        lat  --  radar location latitude, in radians
%        lon  --  radar location longitude, in radians
%
%   Output:
%        T_ECR_RRC  -- ECR to RRC position transformation matrix
%                   
%   Required Functions:
%      none
%

T_ECR_RRC = [ -sin(lon)               cos(lon)                  0;...
                -sin(lat)*cos(lon)  -sin(lat)*sin(lon)        cos(lat);...
                 cos(lat)*cos(lon)   cos(lat)*sin(lon)        sin(lat)];
%
return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
