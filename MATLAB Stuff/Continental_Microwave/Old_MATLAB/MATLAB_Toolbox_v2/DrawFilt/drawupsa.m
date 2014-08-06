function dr = drawupsa(c,d,f,t,n,p,s,F,dc)

% drawupsa   DRAW UP SAMPLER
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
 x1 = a + s*[0.2, 0.2, 0.25, 0.15, 0.2]; y1 = b - s*[ 0.15, -0.15, -0.05, -0.05, -0.15];
 line(x1,y1,'Color',dc)
 text(a+s*0.4,b+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 text(a+s*0.45,b,n,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','middle')
elseif p == 1
 x = g + s*[0,0,0.3,0.3,-0.3,-0.3,0.3,0.3,0,0];
 y = h + s*[(d-h)/s,0.1,0.1,0.7,0.7,0.1,0.1,0.7,0.7,(f-h)/s];
 line(x,y,'Color',dc)
 x1 = g + s*[0.05,0,-0.05]; y1 = h + s*[-0.05,0.05,-0.05];
 line(x1,y1,'Color',dc)
 x1 = g -s*0.4 + s*[0.2, 0.2, 0.25, 0.15, 0.2]; y1 = h + s*0.4 - s*[ 0.15, -0.15, -0.05, -0.05, -0.15];
 line(x1,y1,'Color',dc)
 text(g-s*0.4,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g+s*0.05,h+s*0.4,n,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','middle')
elseif p == 2
 x = a + s*[(c-a)/s, 0.1, 0.1, 0.7, 0.7, 0.1, 0.1, 0.7, 0.7, (f-a)/s];
 y = b + s*[      0,   0, 0.3, 0.3,-0.3,-0.3, 0.3, 0.3,   0,0];
 line(x,y,'Color',dc)
 x1 = a + s*[0.85, 0.75, 0.85]; y1 = b + s*[0.05, 0, -0.05];
 line(x1,y1,'Color',dc)
 x1 = a + s*[0.2, 0.2, 0.25, 0.15, 0.2]; y1 = b - s*[ 0.15, -0.15, -0.05, -0.05, -0.15];
 line(x1,y1,'Color',dc)
 text(a+s*0.4,b-s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
 text(a+s*0.45,b,n,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','middle')
elseif p == 3
 x = g + s*[0,0,0.3,0.3,-0.3,-0.3,0.3,0.3,0,0];
 y = h + s*[(d-h)/s,0.1,0.1,0.7,0.7,0.1,0.1,0.7,0.7,(f-h)/s];
 line(x,y,'Color',dc)
 x1 = g + s*[0.05,0,-0.05]; y1 = h + s*[0.85,0.75,0.85];
 line(x1,y1,'Color',dc)
 x1 = g -s*0.4 + s*[0.2, 0.2, 0.25, 0.15, 0.2]; y1 = h + s*0.4 - s*[ 0.15, -0.15, -0.05, -0.05, -0.15];
 line(x1,y1,'Color',dc)
 text(g+s*0.4,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','middle')
 text(g+s*0.05,h+s*0.4,n,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','middle')
elseif p == 4
 x = a + s*[(c-a)/s, 0.1, 0.1, 0.7, 0.7, 0.1, 0.1, 0.7, 0.7, (f-a)/s];
 y = b + s*[      0,   0, 0.3, 0.3,-0.3,-0.3, 0.3, 0.3,   0,0];
 line(x,y,'Color',dc)
 x1 = a + s*[0.85, 0.75, 0.85]; y1 = b + s*[0.05, 0, -0.05];
 line(x1,y1,'Color',dc)
 x1 = a + s*[0.2, 0.2, 0.25, 0.15, 0.2]; y1 = b - s*[ 0.15, -0.15, -0.05, -0.05, -0.15];
 line(x1,y1,'Color',dc)
 text(a+s*0.4,b+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 text(a+s*0.45,b,n,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','middle')
elseif p == 5
 x = g + s*[0,0,0.3,0.3,-0.3,-0.3,0.3,0.3,0,0];
 y = h + s*[(d-h)/s,0.1,0.1,0.7,0.7,0.1,0.1,0.7,0.7,(f-h)/s];
 line(x,y,'Color',dc)
 x1 = g + s*[0.05,0,-0.05]; y1 = h + s*[0.85,0.75,0.85];
 line(x1,y1,'Color',dc)
 x1 = g -s*0.4 + s*[0.2, 0.2, 0.25, 0.15, 0.2]; y1 = h + s*0.4 - s*[ 0.15, -0.15, -0.05, -0.05, -0.15];
 line(x1,y1,'Color',dc)
 text(g-s*0.4,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
 text(g+s*0.05,h+s*0.4,n,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','middle')
elseif p == 6
 x = a + s*[(c-a)/s, 0.1, 0.1, 0.7, 0.7, 0.1, 0.1, 0.7, 0.7, (f-a)/s];
 y = b + s*[      0,   0, 0.3, 0.3,-0.3,-0.3, 0.3, 0.3,   0,0];
 line(x,y,'Color',dc)
 x1 = a + s*[-0.05, 0.05, -0.05]; y1 = b + s*[ 0.05,    0, -0.05];
 line(x1,y1,'Color',dc)
 x1 = a + s*[0.2, 0.2, 0.25, 0.15, 0.2]; y1 = b - s*[ 0.15, -0.15, -0.05, -0.05, -0.15];
 line(x1,y1,'Color',dc)
 text(a+s*0.4,b-s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
 text(a+s*0.45,b,n,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','middle')
elseif p == 7
 x = g + s*[0,0,0.3,0.3,-0.3,-0.3,0.3,0.3,0,0];
 y = h + s*[(d-h)/s,0.1,0.1,0.7,0.7,0.1,0.1,0.7,0.7,(f-h)/s];
 line(x,y,'Color',dc)
 x1 = g + s*[0.05,0,-0.05]; y1 = h + s*[-0.05,0.05,-0.05];
 line(x1,y1,'Color',dc)
 x1 = g -s*0.4 + s*[0.2, 0.2, 0.25, 0.15, 0.2]; y1 = h + s*0.4 - s*[ 0.15, -0.15, -0.05, -0.05, -0.15];
 line(x1,y1,'Color',dc)
 text(g+s*0.4,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','middle')
 text(g+s*0.05,h+s*0.4,n,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','middle')
end
