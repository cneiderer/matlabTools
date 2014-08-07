function ECR = gc2ecr(lat, lon, h, physical_constants)
%     ECR = Gc_ecr(lat, lon, h, physical_constants)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Converts global coordinates to ecr coordinates
%
%   Input:
%        lat  --  geodetic latitude (rad)  (1XN)
%        lon  --  geodetic longitude (rad) (1XN)
%        h    --  altitude above geodetic reference ellipsoid (1XN)
%        physical_constants  --  structure of physical constants.  Required
%                                fields:
%           f_earth     --  earth flattening coefficient
%           re          --  earth equatorial radius (m)
%
%   Output:
%        ECR  --  position vectors in ECR coordinates (3XN)
%                   
%   Required Functions:
%      NONE
%

cos_lat = cos(lat);
sin_lat = sin(lat);
tan_lat = tan(lat);
cos_lon = cos(lon);
sin_lon = sin(lon);

fTerm = (1- physical_constants.f_earth)^2;
den   = sqrt( 1 + fTerm * tan_lat.^2 );

term  = ( physical_constants.re ./ den ) + h .* cos_lat;
x_ECR = term .* cos_lon;
y_ECR = term .* sin_lon;
z_ECR = ( (fTerm * physical_constants.re * tan_lat) ./ den + h.*sin_lat );

ECR = [x_ECR; y_ECR; z_ECR];

return

%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
