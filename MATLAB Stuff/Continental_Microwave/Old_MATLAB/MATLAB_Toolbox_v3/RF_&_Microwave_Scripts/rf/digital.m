% DIGITAL  Function to plot digital signals
% 
%    DIGITAL (arguments) plots using stairs, and adjusts the axis for visibility.
% 

function [] = digital(varargin);

stairs(varargin{:});

a = axis;
range = a(4) - a(3);

axis([a(1) a(2) a(3)-range/4 a(4)+range/4]);