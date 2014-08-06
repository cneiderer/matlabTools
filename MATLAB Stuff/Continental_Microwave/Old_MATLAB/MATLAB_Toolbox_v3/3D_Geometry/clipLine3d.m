function edge = clipLine3d(line, box)
%CLIPLINE3D clip a line with a box and return an edge
%
%   EDGE = clipLine3d(LINE, BOX);
%   Clips the line LINE with the bounds given in BOX, and returns the
%   corresponding edge.
%
%   See also:
%   lines3d, createLine3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 30/10/2008 from drawLine3d

%   HISTORY
%   30/10/2008 replace intersectPlaneLine by intersectLinePlane

% get box limits
xmin = box(1);
xmax = box(2);
ymin = box(3);
ymax = box(4);
zmin = box(5);
zmax = box(6);

% box faces parallel to Oxy
planeZ0 = [xmin ymin zmin 1 0 0 0 1 0];
planeZ1 = [xmin ymin zmax 1 0 0 0 1 0];

% box faces parallel to Oxz
planeY0 = [xmin ymin zmin 1 0 0 0 0 1];
planeY1 = [xmin ymax zmin 1 0 0 0 0 1];

% box faces parallel to Oyz
planeX0 = [xmin ymin zmin 0 1 0 0 0 1];
planeX1 = [xmax ymin zmin 0 1 0 0 0 1];

% compute intersection point with each plane
piZ0 = intersectLinePlane(line, planeZ0);
piZ1 = intersectLinePlane(line, planeZ1);
piY0 = intersectLinePlane(line, planeY0);
piY1 = intersectLinePlane(line, planeY1);
piX1 = intersectLinePlane(line, planeX1);
piX0 = intersectLinePlane(line, planeX0);

% concatenate resulting points
points = [piX0;piX1;piY0;piY1;piZ0;piZ1];

% sort points according to their position on line
pos = linePosition3d(points, line);
ind = find(~isnan(pos));

% keep median points wrt to position
nv = length(ind)/2;

% create resulting edge
x1 = points(ind(nv), 1);
eps = 1e-14;
if xmin-x1<eps && x1-xmax<eps
    edge = [points(nv, :) points(nv+1, :)];
else
    edge = [NaN NaN NaN NaN NaN NaN];
end
