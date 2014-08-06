function dr = drawcap(c,d,f,n,t,p,s,F,dc)

% drawcap.m  DRAW CAPACITOR
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
xy = 1.1*s;

if p == 0
 x1 = a + s*[(c-a)/s, 0.35];   y1 = b + s*[   0,   0];
 x2 = a + s*[   0.35, 0.35];   y2 = b + s*[-0.2, 0.2];
 x3 = a + s*[(f-a)/s, 0.45];   y3 = b + s*[   0,   0];
 x4 = a + s*[   0.45, 0.45];   y4 = b + s*[-0.2, 0.2];
 line(x1,y1,'Color',dc)
 line(x3,y3,'Color',dc)
 line(x2,y2,'LineWidth',xy,'Color',dc)
 line(x4,y4,'LineWidth',xy,'Color',dc)
 text(a+s*0.4,b+s*0.55,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 text(a+s*0.4,b+s*0.25,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
elseif p == 1
 x1 = g + s*[      0, 0   ];  y1 = h + s*[(d-h)/s, 0.35];
 x2 = g + s*[   -0.2, 0.2 ];  y2 = h + s*[   0.35, 0.35];
 x3 = g + s*[      0, 0   ];  y3 = h + s*[(f-h)/s, 0.45];
 x4 = g + s*[   -0.2, 0.2 ];  y4 = h + s*[   0.45, 0.45];
 line(x1,y1,'Color',dc)
 line(x3,y3,'Color',dc)
 line(x2,y2,'LineWidth',xy,'Color',dc)
 line(x4,y4,'LineWidth',xy,'Color',dc)
 text(g-s*0.3,h+s*0.4,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','top')
 text(g-s*0.3,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','bottom')
elseif p == 2
 x1 = a + s*[(c-a)/s, 0.35];   y1 = b + s*[   0,   0];
 x2 = a + s*[   0.35, 0.35];   y2 = b + s*[-0.2, 0.2];
 x3 = a + s*[(f-a)/s, 0.45];   y3 = b + s*[   0,   0];
 x4 = a + s*[   0.45, 0.45];   y4 = b + s*[-0.2, 0.2];
 line(x1,y1,'Color',dc)
 line(x3,y3,'Color',dc)
 line(x2,y2,'LineWidth',xy,'Color',dc)
 line(x4,y4,'LineWidth',xy,'Color',dc)
 text(a+s*0.4,b-s*0.55,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
 text(a+s*0.4,b-s*0.25,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
else
 x1 = g + s*[      0, 0   ];  y1 = h + s*[(d-h)/s, 0.35];
 x2 = g + s*[   -0.2, 0.2 ];  y2 = h + s*[   0.35, 0.35];
 x3 = g + s*[      0, 0   ];  y3 = h + s*[(f-h)/s, 0.45];
 x4 = g + s*[   -0.2, 0.2 ];  y4 = h + s*[   0.45, 0.45];
 line(x1,y1,'Color',dc)
 line(x3,y3,'Color',dc)
 line(x2,y2,'LineWidth',xy,'Color',dc)
 line(x4,y4,'LineWidth',xy,'Color',dc)
 text(g+s*0.3,h+s*0.4,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','top')
 text(g+s*0.3,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
end
