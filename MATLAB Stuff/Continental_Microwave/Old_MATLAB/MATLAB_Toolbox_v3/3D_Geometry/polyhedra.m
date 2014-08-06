function polyhedra(varargin)
%POLYHEDRA  description of functions operating on 3D polyhedra
%   
%   Polyhedra are represented as meshes, i.e. by a couple {V,F} with:
%   - V being a set of vertices, represented by a Nv*3 array
%   - F being a set of faces, represented either by a Nf-by-3, a Nf-by-4
%   array, or by a Nf-by-1 array of cells, each cell containing indices of
%   vertices for a given face.
%
%   See also
%   faceCentroids, faceNormal, polyhedronNormalAngle
%   createCube, createCubeOctahedron, createIcosahedron, createOctahedron
%   createRhombododecahedron, createTetrahedron, createTetrakaidecahedron
%   createSoccerBall, createMengerSponge
%   minConvexHull, steinerPolytope
%   drawPolyhedron, triangulateFaces, meshReduce
%
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.
% Licensed under the terms of the LGPL, see the file "license.txt"
