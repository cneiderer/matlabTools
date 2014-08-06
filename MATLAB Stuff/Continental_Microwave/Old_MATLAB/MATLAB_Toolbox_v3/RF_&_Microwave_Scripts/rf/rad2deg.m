% RAD2DEG  Convert a vector from radians to degrees
% 
%    [deg] = RAD2DEG (rad) converts rad into degrees
% 

function [deg] = rad2deg (rad)
deg = rad * 180 / pi;
