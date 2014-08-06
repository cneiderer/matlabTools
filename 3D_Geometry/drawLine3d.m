function varargout = drawLine3d(lin, varargin)
%DRAWLINE3D draw the line in the current Window
%
%   H = drawline3d(LINE);
%   Draws the line LINE on the current axis, by clipping with the current
%   axis. If line is not clipepd by the axis, function return -1.
%
%   See also:
%   lines3d, createLine3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 17/02/2005.
%

%   HISTORY
%   30/10/2008 replace intersectPlaneLine by intersectLinePlane


lim = get(gca, 'xlim');
xmin = lim(1);
xmax = lim(2);
lim = get(gca, 'ylim');
ymin = lim(1);
ymax = lim(2);
lim = get(gca, 'zlim');
zmin = lim(1);
zmax = lim(2);


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
piZ0 = intersectLinePlane(lin, planeZ0);
piZ1 = intersectLinePlane(lin, planeZ1);
piY0 = intersectLinePlane(lin, planeY0);
piY1 = intersectLinePlane(lin, planeY1);
piX1 = intersectLinePlane(lin, planeX1);
piX0 = intersectLinePlane(lin, planeX0);

% concatenate points into one array
points = [piX0;piX1;piY0;piY1;piZ0;piZ1];

% sort point according to position on line
pos = linePosition3d(points, lin);
ind = find(~isnan(pos));

points = sortrows(points);

% keep only the two points delimiting the line
nv = length(ind)/2;
pts = points((nv:nv+1),:);

h = line(pts(:,1)', pts(:,2)', pts(:,3)');
if ~isempty(varargin)
    set(h, varargin{:});
end

if nargout>0
    varargout{1}=h;
end