% COMPARE  Function to plot two vectors of different scales on same x axis
% 
%    COMPARE (y1, y2) plots y1 and y2 using the index of y1 as x axis
% 
%    COMPARE (x1, y1, y2) plots y1 and y2 using x1 as x axis
%

function [] = compare(varargin);

plot(varargin{1:nargin-1});

H = ishold;

hold on;

axis tight;
a = axis;
axis auto;
x = a(1):(a(2)-a(1))/(length(varargin{nargin})-1):a(2);

plot(x,varargin{nargin});

if (H == 0)
   hold off;
end;   
