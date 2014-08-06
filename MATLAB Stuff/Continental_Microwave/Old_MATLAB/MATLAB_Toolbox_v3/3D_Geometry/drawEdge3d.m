function varargout = drawEdge3d(edges, varargin)
%DRAWEDGE3D draw the edge in the current Window
%
%   drawEdge(EDGE)
%   draw the edge EDGE on the current axis. EDGE has the form:
%   [x1 y1 z1 x2 y2 z2].
%   No clipping is performed.
%
%
%   Note: deprecated, use geom2d/drawEdge instead (more generic)
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY
%   04/01/2007: remove unused variables
%   

warning('IMAEL:deprecatedFunction', ...
    'This function is deprecated, use ''geom2d/drawEdge'' instead');

pts = [edges(:,1:3); edges(:,4:6)];

h = line(pts(:,1)', pts(:,2)', pts(:,3)');
if ~isempty(varargin)
    set(h, varargin{:});
end

if nargout>0
    varargout{1}=h;
end