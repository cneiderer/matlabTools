function varargout = transforms3d(varargin)
%TRANSFORMS3D  Conventions for manipulating 3D affine transforms
%
%   By 'transform' we mean an affine transform. A 3D affine transform
%   can be represented by a 4*4 matrix.
%
%   Example
%   % create a translation by the vector [10 20 30]:
%   T = [1 0 0 10;0 1 0 20;0 0 1 30;0 0 0 1];
%
%   See also
%   translation3d, scale3d
%   rotationOx, rotationOy, rotationOz
%   composeTransforms3d
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.
% Licensed under the terms of the LGPL, see the file "license.txt"
