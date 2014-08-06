function varargout = drawCircleArc3d(arc, varargin)
%DRAWCIRCLEARC3D draw a 3D circle arc
%
%   drawCircleArc3d([XC YC ZC R THETA PHI PSI START EXTENT])
%   [XC YC ZC]  : coordinate of arc center
%   R           : arc radius
%   [PHI THETA] : orientation of arc normal (theta : 0->pi).
%   PSI         : roll of arc (rotation of circle origin)
%   START       : starting angle of arc, from arc origin
%   EXTENT      : extent of arc arc (can be negative)
%   
%   Drawing options can be specified, as for the plot command.
%
%   See also
%   drawCircleArc
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 21/02/2005
%

%   HISTORY
%   27/06/2007: change 3D angle convention

if iscell(arc)
    h = [];
    for i=1:length(arc)
        h = [h drawCircleArc3d(arc{i}, varargin{:})];
    end
    if nargout>0
        varargout{1}=h;
    end
    return;
end

if size(arc, 1)>1
    h = [];
    for i=1:size(arc, 1)
        h = [h drawCircleArc3d(arc(i,:), varargin{:})];
    end
    if nargout>0
        varargout{1}=h;
    end
    return;
end

% get center and radius
xc  = arc(:,1);
yc  = arc(:,2);
zc  = arc(:,3);
r   = arc(:,4);

% get angle of normal
theta   = arc(:,5);
phi     = arc(:,6);
psi     = arc(:,7);

% get starting angle and angle extent of arc
start   = arc(:,8);
extent  = arc(:,9);

% positions on circle arc
N   = 64;
t   = linspace(start, start+extent, N);

% compute coordinate of points
x   = r*cos(t)';
y   = r*sin(t)';
z   = zeros(length(t), 1);
curve   = [x y z];

% transformation to apply to the arc
tr      = translation3d(xc, yc, zc);
rot1    = rotationOz(-psi);
rot2    = rotationOy(-theta);
rot3    = rotationOz(-phi);
trans   = tr*rot3*rot2*rot1;

% transform circle arc
curve   = transformPoint3d(curve, trans);

h = drawCurve3d(curve, varargin{:});


if nargout>0
    varargout{1}=h;
end

