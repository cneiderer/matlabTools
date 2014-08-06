function drl = drawvs(c,d,f,n,t,p,s,F,dc)

% drawvs.m    DRAW VOLTAGE SOURCE
%   
%                 Drawing Filter Realizations
%   
%   Authors: Miroslav D. Lutovac, Dejan V. Tosic, 1999/02/21
%   lutovac@iritel.bg.ac.yu    http://galeb.etf.bg.ac.yu/~lutovac/
%   tosic@galeb.etf.bg.ac.yu   http://www.rcub.bg.ac.yu/~tosicde/
%   Copyright (c) 1999-2000 by Lutovac & Tosic
%   $Revision: 1.21 $  $Date: 2000/10/03 13:45$
%   
%   References:
%   Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans
%        Filter Design for Signal Processing
%           Using MATLAB and Mathematica
%        Prentice Hall - ISBN 0-201-36130-2 
%         http://www.prenhall.com/lutovac
%
                         
% This file is part of DrawFilt toolbox for MATLAB.
% Refer to the file LICENSE.TXT for full details.
%                        
% DrawFilt version 2.1, Copyright (c) 1999-2000 M. Lutovac and D. Tosic
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; see LICENSE.TXT for details.
%                       
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%                       
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc.,  59 Temple Place,  Suite 330,  Boston,
% MA  02111-1307  USA,  http://www.fsf.org/

a=(f+c)/2-0.25*s;
b=d;
g=c;
h=(f+d)/2-0.25*s;

xy = 0:0.02:1;
xc1 = s*0.25*sin(2*pi*xy);
yc1 = s*0.25*cos(2*pi*xy);


if p == 0
 x = (f+c)/2 + xc1;   y = d + yc1;
 line(x,y,'Color',dc)
 x2 = a + s*[(c-a)/s, 0];    y2 = b + s*[0, 0];
 line(x2,y2,'Color',dc)
 x3 = a + s*[0.5, (f-a)/s];  y3 = b + s*[0, 0];
 line(x3,y3,'Color',dc)
 text((c+f)/2,b+s*0.6,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 text((c+f)/2,b+s*0.3,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 x4 = a + s*[0.35, 0.35];    y4 = b + s*[-0.05, 0.05];
 line(x4,y4,'Color',dc)
 x4 = a + s*[0.3, 0.4];    y4 = b + s*[0, 0];
 line(x4,y4,'Color',dc)
 x4 = a + s*[0.1, 0.2];    y4 = b + s*[0, 0];
 line(x4,y4,'Color',dc)
elseif p == 1
 y = (f+d)/2 + yc1;  x = c + xc1;
 line(x,y,'Color',dc)
 x = g + s*[0, 0];   y = h + s*[(d-h)/s, 0];
 line(x,y,'Color',dc)
 x = g + s*[0, 0];  y = h + s*[0.5, (f-h)/s];
 line(x,y,'Color',dc)
 text(g-s*0.3,h+s*0.25,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','top')
 text(g-s*0.3,h+s*0.25,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','bottom')
 x4 = g + s*[-0.05, 0.05]; y4 = h + s*[0.15, 0.15];
 line(x4,y4,'Color',dc)
 x4 = g + s*[-0.05, 0.05];        y4 = h + s*[0.35, 0.35];
 line(x4,y4,'Color',dc)
 x4 = g + s*[0, 0];        y4 = h + s*[0.3, 0.4];
 line(x4,y4,'Color',dc)
elseif p == 2
 x = (f+c)/2 + xc1;          y = d + yc1;
 line(x,y,'Color',dc)
 x2 = a + s*[(c-a)/s, 0];    y2 = b + s*[0, 0];
 line(x2,y2,'Color',dc)
 x3 = a + s*[0.5, (f-a)/s];  y3 = b + s*[0, 0];
 line(x3,y3,'Color',dc)
 text((c+f)/2,b-s*0.6,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
 text((c+f)/2,b-s*0.3,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
 x4 = a + s*[0.15, 0.15];    y4 = b + s*[-0.05, 0.05];
 line(x4,y4,'Color',dc)
 x4 = a + s*[0.3, 0.4];    y4 = b + s*[0, 0];
 line(x4,y4,'Color',dc)
 x4 = a + s*[0.1, 0.2];    y4 = b + s*[0, 0];
 line(x4,y4,'Color',dc)
elseif p == 3
 y = (f+d)/2 + yc1;    x = c + xc1;
 line(x,y,'Color',dc)
 x = g + s*[0, 0];     y = h + s*[(d-h)/s, 0];
 line(x,y,'Color',dc)
 x = g + s*[0, 0];     y = h + s*[0.5, (f-h)/s];
 line(x,y,'Color',dc)
 text(g+s*0.3,h+s*0.25,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','top')
 text(g+s*0.3,h+s*0.25,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
 x4 = g + s*[-0.05, 0.05]; y4 = h + s*[0.15, 0.15];
 line(x4,y4,'Color',dc)
 x4 = g + s*[-0.05, 0.05];        y4 = h + s*[0.35, 0.35];
 line(x4,y4,'Color',dc)
 x4 = g + s*[0, 0];        y4 = h + s*[0.1, 0.2];
 line(x4,y4,'Color',dc)
elseif p == 4
 x = (f+c)/2 + xc1;   y = d + yc1;
 line(x,y,'Color',dc)
 x2 = a + s*[(c-a)/s, 0];    y2 = b + s*[0, 0];
 line(x2,y2,'Color',dc)
 x3 = a + s*[0.5, (f-a)/s];  y3 = b + s*[0, 0];
 line(x3,y3,'Color',dc)
 text((c+f)/2,b-s*0.6,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
 text((c+f)/2,b-s*0.3,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
 x4 = a + s*[0.35, 0.35];    y4 = b + s*[-0.05, 0.05];
 line(x4,y4,'Color',dc)
 x4 = a + s*[0.3, 0.4];    y4 = b + s*[0, 0];
 line(x4,y4,'Color',dc)
 x4 = a + s*[0.1, 0.2];    y4 = b + s*[0, 0];
 line(x4,y4,'Color',dc)
elseif p == 5
 y = (f+d)/2 + yc1;  x = c + xc1;
 line(x,y,'Color',dc)
 x = g + s*[0, 0];   y = h + s*[(d-h)/s, 0];
 line(x,y,'Color',dc)
 x = g + s*[0, 0];  y = h + s*[0.5, (f-h)/s];
 line(x,y,'Color',dc)
 text(g+s*0.3,h+s*0.25,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','top')
 text(g+s*0.3,h+s*0.25,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
 x4 = g + s*[-0.05, 0.05]; y4 = h + s*[0.15, 0.15];
 line(x4,y4,'Color',dc)
 x4 = g + s*[-0.05, 0.05];        y4 = h + s*[0.35, 0.35];
 line(x4,y4,'Color',dc)
 x4 = g + s*[0, 0];        y4 = h + s*[0.3, 0.4];
 line(x4,y4,'Color',dc)
elseif p == 6
 x = (f+c)/2 + xc1;          y = d + yc1;
 line(x,y,'Color',dc)
 x2 = a + s*[(c-a)/s, 0];    y2 = b + s*[0, 0];
 line(x2,y2,'Color',dc)
 x3 = a + s*[0.5, (f-a)/s];  y3 = b + s*[0, 0];
 line(x3,y3,'Color',dc)
 text((c+f)/2,b+s*0.6,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 text((c+f)/2,b+s*0.3,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 x4 = a + s*[0.15, 0.15];    y4 = b + s*[-0.05, 0.05];
 line(x4,y4,'Color',dc)
 x4 = a + s*[0.3, 0.4];    y4 = b + s*[0, 0];
 line(x4,y4,'Color',dc)
 x4 = a + s*[0.1, 0.2];    y4 = b + s*[0, 0];
 line(x4,y4,'Color',dc)
else
 y = (f+d)/2 + yc1;    x = c + xc1;
 line(x,y,'Color',dc)
 x = g + s*[0, 0];     y = h + s*[(d-h)/s, 0];
 line(x,y,'Color',dc)
 x = g + s*[0, 0];     y = h + s*[0.5, (f-h)/s];
 line(x,y,'Color',dc)
 text(g-s*0.3,h+s*0.25,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','top')
 text(g-s*0.3,h+s*0.25,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','bottom')
 x4 = g + s*[-0.05, 0.05]; y4 = h + s*[0.15, 0.15];
 line(x4,y4,'Color',dc)
 x4 = g + s*[-0.05, 0.05];        y4 = h + s*[0.35, 0.35];
 line(x4,y4,'Color',dc)
 x4 = g + s*[0, 0];        y4 = h + s*[0.1, 0.2];
 line(x4,y4,'Color',dc)
end
