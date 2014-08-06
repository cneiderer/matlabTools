% LOADSPICE Reads in SPICE data from .out file
%
%	[Y] = LOADSPICE(filename) Reads in data from file filename.
%       GREP must be present and in path 

function [Y] = loadspice(infname)

com = sprintf('grep -i -v -e\\* -e[A-D] -e[F-Z] %s | grep -i -ee > temp.asc', infname);
dos(com);
clear com;

% Read in data

disp('Loading data file');
load('temp.asc');
delete('temp.asc');

Y = temp;