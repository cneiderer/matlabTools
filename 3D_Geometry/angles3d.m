function angles3d(varargin)
%ANGLES3D  conventions for manipulating angles in 3D
%
%   Contrary to the plane, there is no oriented angled in 3D. Angles are
%   comprised between 0 and PI.
%
%   Spherical angles are defined by 3 angles:
%   - theta, the colatitude, representing angle with Oz axis
%   - phi, the azimut, representing angle with Ox axis of horizontal
%       projection of the direction
%   - psi, which denotes the rotation around the normal direction
%
%   Spherical coordinates can be represented by Theta, phi, and the
%   distance RHO to the origin.
%
%
%   See also
%   anglePoints3d, angleSort3d, sphericalAngle, randomAngle3d
%   dihedralAngle, polygon3dNormalAngle
%
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.
% Licensed under the terms of the LGPL, see the file "license.txt"
