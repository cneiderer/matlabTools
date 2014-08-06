function dr = drawdel(c,d,f,t,n,p,s,F,dc)

% drawdel.m  DRAW DELAY
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
% drawdel(c,d,f,t,n,p,s,F)
% c = x1 
% d = y1
% f = x2 or y2
% t = text      "D"
% n = exponent  z^(-n)
% p = orientation: 
%         input ->-D--- output
%     0 = left  ->-D--- right
%     1 = down  ->-D--- up
%     2 = right ->-D--- left
%     3 = up    ->-D--- down
%     ...
%    14 = left  ->-D->- right
%    15 = down  ->-D->- up
%    12 = right ->-D->- left
%    11 = up    ->-D->- down
% s = scale
% F = font size 
% dc= draw color
                         
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

a=(f+c)/2-0.4*s;
b=d;
g=c;
h=(f+d)/2-0.4*s;

if p == 0
 x = a + s*[(c-a)/s, 0.1, 0.1, 0.7, 0.7, 0.1, 0.1, 0.7, 0.7, (f-a)/s];
 y = b + s*[      0,   0, 0.3, 0.3,-0.3,-0.3, 0.3, 0.3,   0,0];
 line(x,y,'Color',dc);
 x1 = a + s*[-0.05, 0.05, -0.05]; y1 = b + s*[ 0.05,    0, -0.05];

 line(x1,y1,'Color',dc)
 text(a+s*0.4,b+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 text(a+s*0.4,b,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(a+s*0.4,b,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 1
 x = g + s*[0,0,0.3,0.3,-0.3,-0.3,0.3,0.3,0,0];
 y = h + s*[(d-h)/s,0.1,0.1,0.7,0.7,0.1,0.1,0.7,0.7,(f-h)/s];
 line(x,y,'Color',dc)
 x1 = g + s*[0.05,0,-0.05]; y1 = h + s*[-0.05,0.05,-0.05];
 line(x1,y1,'Color',dc)
 text(g-s*0.4,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g,h+s*0.4,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g,h+s*0.4,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 2
 x = a + s*[(c-a)/s, 0.1, 0.1, 0.7, 0.7, 0.1, 0.1, 0.7, 0.7, (f-a)/s];
 y = b + s*[      0,   0, 0.3, 0.3,-0.3,-0.3, 0.3, 0.3,   0,0];
 line(x,y,'Color',dc)
 x1 = a + s*[0.85, 0.75, 0.85]; y1 = b + s*[0.05, 0, -0.05];
 line(x1,y1,'Color',dc)
 text(a+s*0.4,b-s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
 text(a+s*0.4,b,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(a+s*0.4,b,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 3
 x = g + s*[0,0,0.3,0.3,-0.3,-0.3,0.3,0.3,0,0];
 y = h + s*[(d-h)/s,0.1,0.1,0.7,0.7,0.1,0.1,0.7,0.7,(f-h)/s];
 line(x,y,'Color',dc)
 x1 = g + s*[0.05,0,-0.05]; y1 = h + s*[0.85,0.75,0.85];
 line(x1,y1,'Color',dc)
 text(g+s*0.4,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','middle')
 text(g,h+s*0.4,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g,h+s*0.4,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 4
 x = a + s*[(c-a)/s, 0.1, 0.1, 0.7, 0.7, 0.1, 0.1, 0.7, 0.7, (f-a)/s];
 y = b + s*[      0,   0, 0.3, 0.3,-0.3,-0.3, 0.3, 0.3,   0,0];
 line(x,y,'Color',dc)
 x1 = a + s*[0.85, 0.75, 0.85]; y1 = b + s*[0.05, 0, -0.05];
 line(x1,y1,'Color',dc)
 text(a+s*0.4,b+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 text(a+s*0.4,b,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(a+s*0.4,b,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 5
 x = g + s*[0,0,0.3,0.3,-0.3,-0.3,0.3,0.3,0,0];
 y = h + s*[(d-h)/s,0.1,0.1,0.7,0.7,0.1,0.1,0.7,0.7,(f-h)/s];
 line(x,y,'Color',dc)
 x1 = g + s*[0.05,0,-0.05]; y1 = h + s*[0.85,0.75,0.85];
 line(x1,y1,'Color',dc)
 text(g-s*0.4,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g,h+s*0.4,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g,h+s*0.4,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 6
 x = a + s*[(c-a)/s, 0.1, 0.1, 0.7, 0.7, 0.1, 0.1, 0.7, 0.7, (f-a)/s];
 y = b + s*[      0,   0, 0.3, 0.3,-0.3,-0.3, 0.3, 0.3,   0,0];
 line(x,y,'Color',dc)
 x1 = a + s*[-0.05, 0.05, -0.05]; y1 = b + s*[ 0.05,    0, -0.05];
 line(x1,y1,'Color',dc)
 text(a+s*0.4,b-s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
 text(a+s*0.4,b,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(a+s*0.4,b,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 7
 x = g + s*[0,0,0.3,0.3,-0.3,-0.3,0.3,0.3,0,0];
 y = h + s*[(d-h)/s,0.1,0.1,0.7,0.7,0.1,0.1,0.7,0.7,(f-h)/s];
 line(x,y,'Color',dc)
 x1 = g + s*[0.05,0,-0.05]; y1 = h + s*[-0.05,0.05,-0.05];
 line(x1,y1,'Color',dc)
 text(g+s*0.4,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','middle')
 text(g,h+s*0.4,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g,h+s*0.4,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 8
 x = a + s*[(c-a)/s, 0.1, 0.1, 0.7, 0.7, 0.1, 0.1, 0.7, 0.7, (f-a)/s];
 y = b + s*[      0,   0, 0.3, 0.3,-0.3,-0.3, 0.3, 0.3,   0,0];
 line(x,y,'Color',dc)
 x1 = a + s*[-0.05, 0.05, -0.05]; y1 = b + s*[ 0.05,    0, -0.05];
 line(x1,y1,'Color',dc)
 x2 = a + s*[0.75,0.85,0.75]; y2 = b + s*[0.05,0,-0.05];
 line(x2,y2,'Color',dc)
 text(a+s*0.4,b+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 text(a+s*0.4,b,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(a+s*0.4,b,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 9
 x = g + s*[0,0,0.3,0.3,-0.3,-0.3,0.3,0.3,0,0];
 y = h + s*[(d-h)/s,0.1,0.1,0.7,0.7,0.1,0.1,0.7,0.7,(f-h)/s];
 line(x,y,'Color',dc)
 x1 = g + s*[0.05,0,-0.05]; y1 = h + s*[-0.05,0.05,-0.05];
 line(x1,y1,'Color',dc)
 x2 = g + s*[0.05,0,-0.05]; y2 = h + s*[0.75,0.85,0.75];
 line(x2,y2,'Color',dc)
 text(g-s*0.4,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g,h+s*0.4,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g,h+s*0.4,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 10
 x = a + s*[(c-a)/s, 0.1, 0.1, 0.7, 0.7, 0.1, 0.1, 0.7, 0.7, (f-a)/s];
 y = b + s*[      0,   0, 0.3, 0.3,-0.3,-0.3, 0.3, 0.3,   0,0];
 line(x,y,'Color',dc)
 x1 = a + s*[0.85, 0.75, 0.85]; y1 = b + s*[0.05, 0, -0.05];
 line(x1,y1,'Color',dc)
 x2 = a + s*[0.05,-0.05,0.05]; y2 = b + s*[0.05,0,-0.05];
 line(x2,y2,'Color',dc)
 text(a+s*0.4,b-s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
 text(a+s*0.4,b,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(a+s*0.4,b,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 11
 x = g + s*[0,0,0.3,0.3,-0.3,-0.3,0.3,0.3,0,0];
 y = h + s*[(d-h)/s,0.1,0.1,0.7,0.7,0.1,0.1,0.7,0.7,(f-h)/s];
 line(x,y,'Color',dc)
 x1 = g + s*[0.05,0,-0.05]; y1 = h + s*[0.85,0.75,0.85];
 line(x1,y1,'Color',dc)
 x2 = g + s*[0.05,0,-0.05]; y2 = h + s*[0.05,-0.05,0.05];
 line(x2,y2,'Color',dc)
 text(g+s*0.4,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','middle')
 text(g,h+s*0.4,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g,h+s*0.4,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 12
 x = a + s*[(c-a)/s, 0.1, 0.1, 0.7, 0.7, 0.1, 0.1, 0.7, 0.7, (f-a)/s];
 y = b + s*[      0,   0, 0.3, 0.3,-0.3,-0.3, 0.3, 0.3,   0,0];
 line(x,y,'Color',dc)
 x1 = a + s*[0.85, 0.75, 0.85]; y1 = b + s*[0.05, 0, -0.05];
 line(x1,y1,'Color',dc)
 x2 = a + s*[0.05,-0.05,0.05]; y2 = b + s*[0.05,0,-0.05];
 line(x2,y2,'Color',dc)
 text(a+s*0.4,b+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 text(a+s*0.4,b,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(a+s*0.4,b,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 13
 x = g + s*[0,0,0.3,0.3,-0.3,-0.3,0.3,0.3,0,0];
 y = h + s*[(d-h)/s,0.1,0.1,0.7,0.7,0.1,0.1,0.7,0.7,(f-h)/s];
 line(x,y,'Color',dc)
 x1 = g + s*[0.05,0,-0.05]; y1 = h + s*[0.85,0.75,0.85];
 line(x1,y1,'Color',dc)
 x2 = g + s*[0.05,0,-0.05]; y2 = h + s*[0.05,-0.05,0.05];
 line(x2,y2,'Color',dc)
 text(g-s*0.4,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g,h+s*0.4,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g,h+s*0.4,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
% ,Line[({g,h}+s*#)& /@ {{0.05,0.05},{0,-0.05},{-0.05,0.05}}]
elseif p == 14
 x = a + s*[(c-a)/s, 0.1, 0.1, 0.7, 0.7, 0.1, 0.1, 0.7, 0.7, (f-a)/s];
 y = b + s*[      0,   0, 0.3, 0.3,-0.3,-0.3, 0.3, 0.3,   0,0];
 line(x,y,'Color',dc)
 x1 = a + s*[-0.05, 0.05, -0.05]; y1 = b + s*[ 0.05,    0, -0.05];
 line(x1,y1,'Color',dc)
 x2 = a + s*[0.75,0.85,0.75]; y2 = b + s*[0.05,0,-0.05];
 line(x2,y2,'Color',dc)
 text(a+s*0.4,b-s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
 text(a+s*0.4,b,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(a+s*0.4,b,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
else
 x = g + s*[0,0,0.3,0.3,-0.3,-0.3,0.3,0.3,0,0];
 y = h + s*[(d-h)/s,0.1,0.1,0.7,0.7,0.1,0.1,0.7,0.7,(f-h)/s];
 line(x,y,'Color',dc)
 x1 = g + s*[0.05,0,-0.05]; y1 = h + s*[-0.05,0.05,-0.05];
 line(x1,y1,'Color',dc)
 x2 = g + s*[0.05,0,-0.05]; y2 = h + s*[0.75,0.85,0.75];
 line(x2,y2,'Color',dc)
 text(g+s*0.4,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','middle')
 text(g,h+s*0.4,'z','FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g,h+s*0.4,n,'FontName','Times','FontSize',F-1,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
end

