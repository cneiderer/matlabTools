function drawAxis3d(varargin)
%DRAWAXIS3D  draw a coordinate system and an origin
%
%   drawAxis3d
%	Adds 3 cylinders to the current axis, corresponding to the directions
%	of the 3 basis vectors Ox, Oy and Oz.
%	Ox vector is red, Oy vector is green, and Oz vector is blue.
%
%   Example
%   drawAxis
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2007-08-14,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.
% Licensed under the terms of the LGPL, see the file "license.txt"

% geometrical data
origin = [0 0 0];
v1 = [1 0 0];
v2 = [0 1 0];
v3 = [0 0 1];

% default parameters
L = 1;
r = L/10;

% extract parameters from input
if ~isempty(varargin)
	L = varargin{1};
end
if length(varargin)>1
	r = varargin{2};
end

% draw 3 cylinders and a ball
hold on;
drawCylinder([origin origin+v1*L r], 8, 'facecolor', 'r', 'edgecolor', 'none');
drawCylinder([origin origin+v2*L r], 8, 'facecolor', 'g', 'edgecolor', 'none');
drawCylinder([origin origin+v3*L r], 8, 'facecolor', 'b', 'edgecolor', 'none');
drawSphere([origin 2*r], 'faceColor', 'black');

