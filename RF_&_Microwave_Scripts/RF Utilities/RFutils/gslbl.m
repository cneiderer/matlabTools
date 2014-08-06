function pts=gslbl(ltext)
% Graphics Label
%
% Add leader and text label at point on chart selected by mouse.
%
% Usage: gslbl('Text Label');
%
% Select first end of leader with mouse.
% Select second end of leader with mouse.

% N.Tucker www.activefrance.com 2008

zoom off;
hold on;

[x1,y1]=ginput(1);
[x2,y2]=ginput(1);
leadlen=0.2.*sqrt((x2-x1).^2+(y2-y1).^2);
plot([x1 x2 (x2+leadlen)],[y1 y2 y2])
text((x2+leadlen),y2,ltext);

hold off;