function drl = drawlnd(c,d,f,n,t,p,s,F,dc)

% drawlnd.m  DRAW INDUCTOR
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
xy01 = ceil(50*(acos(1/1.5)/(2*pi)+0.25))/50;
xy02 = ceil(50*(-acos(1/1.5)/(2*pi)-0.25))/50;
xy = 0:0.02:1;
xy1 = -0.25:0.02: xy01; xy2 = xy02:0.02:xy01;
xy3 = xy02:0.02:0.25;   xy3(length(xy3)+1) = 0.25;

if p == 0
 x = (f+c)/2-0.2*s + s*0.15*sin(2*pi*xy1);
 y = d + s*0.15*cos(2*pi*xy1);
 line(x,y,'Color',dc)
 x = (f+c)/2 + s*0.15*sin(2*pi*xy2);
 y = d + s*0.15*cos(2*pi*xy2);
 line(x,y,'Color',dc)
 x = (f+c)/2 + 0.2*s + s*0.15*sin(2*pi*xy3);
 y = d + s*0.15*cos(2*pi*xy3);
 line(x,y,'Color',dc)
 x2 = a + s*[(c-a)/s, 0.05];
 y2 = b + s*[      0,   0];
 line(x2,y2,'Color',dc)
 x3 = a + s*[0.75, (f-a)/s];
 y3 = b + s*[  0, 0];
 line(x3,y3,'Color',dc)
 text((c+f)/2,b+s*0.5,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 text((c+f)/2,b+s*0.2,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
elseif p == 1
 y = (f+d)/2-0.2*s + s*0.15*sin(2*pi*xy1);
 x = c - s*0.15*cos(2*pi*xy1);
 line(x,y,'Color',dc)
 y = (f+d)/2 + s*0.15*sin(2*pi*xy2);
 x = c - s*0.15*cos(2*pi*xy2);
 line(x,y,'Color',dc)
 y = (f+d)/2 + 0.2*s + s*0.15*sin(2*pi*xy3);
 x = c - s*0.15*cos(2*pi*xy3);
 line(x,y,'Color',dc)
 x = g + s*[      0,   0];
 y = h + s*[(d-h)/s, 0.05];
 line(x,y,'Color',dc)
 x = g + s*[   0, 0];
 y = h + s*[0.75, (f-h)/s];
 line(x,y,'Color',dc)
 text(g-s*0.25,h+s*0.4,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','top')
 text(g-s*0.25,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','bottom')
elseif p == 2
 x = (f+c)/2-0.2*s + s*0.15*sin(2*pi*xy1);
 y = d + s*0.15*cos(2*pi*xy1);
 line(x,y,'Color',dc)
 x = (f+c)/2 + s*0.15*sin(2*pi*xy2);
 y = d + s*0.15*cos(2*pi*xy2);
 line(x,y,'Color',dc)
 x = (f+c)/2 + 0.2*s + s*0.15*sin(2*pi*xy3);
 y = d + s*0.15*cos(2*pi*xy3);
 line(x,y,'Color',dc)
 x2 = a + s*[(c-a)/s, 0.05];
 y2 = b + s*[      0,   0];
 line(x2,y2,'Color',dc)
 x3 = a + s*[0.75, (f-a)/s];
 y3 = b + s*[  0, 0];
 line(x3,y3,'Color',dc)
 text((c+f)/2,b-s*0.45,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
 text((c+f)/2,b-s*0.15,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
else
 y = (f+d)/2-0.2*s + s*0.15*sin(2*pi*xy1);
 x = c - s*0.15*cos(2*pi*xy1);
 line(x,y,'Color',dc)
 y = (f+d)/2 + s*0.15*sin(2*pi*xy2);
 x = c - s*0.15*cos(2*pi*xy2);
 line(x,y,'Color',dc)
 y = (f+d)/2 + 0.2*s + s*0.15*sin(2*pi*xy3);
 x = c - s*0.15*cos(2*pi*xy3);
 line(x,y,'Color',dc)
 x = g + s*[      0,   0];
 y = h + s*[(d-h)/s, 0.05];
 line(x,y,'Color',dc)
 x = g + s*[   0, 0];
 y = h + s*[0.75, (f-h)/s];
 line(x,y,'Color',dc)
 text(g+s*0.15,h+s*0.4,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','top')
 text(g+s*0.15,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
end
