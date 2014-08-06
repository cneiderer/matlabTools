function dr = drawamp(c,d,f,t,l,p,s,F)

% drawamp.m  DRAW AMPLIFIER
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
 x1 = a + s*[0.6, 0.2, 0.2, 0.6, (f-a)/s];
 y1 = b + s*[  0, 0.3,-0.3,   0,       0];
 x2 = a + s*[(c-a)/s, 0.2];  y2 = b + s*[0, 0];
 line(x1,y1);  line(x2,y2);
 text(a+s*0.5,b+s*0.3,l,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','cap')
 text(a+s*0.5,b+s*0.3,t,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','baseline')
elseif p == 1
 x1 = g + s*[0,0.3,-0.3,0,0];
 y1 = h + s*[0.6,0.2,0.2,0.6,(f-h)/s];
 x2 = g + s*[0,0];  y2 = h + s*[(d-h)/s,0.2];
 line(x1,y1);  line(x2,y2);
 text(g-s*0.2,h+s*0.5,l,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','cap')
 text(g-s*0.2,h+s*0.5,t,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','baseline')
elseif p == 2
 x1 = a + s*[0.2,0.6,0.6,0.2,(c-a)/s];
 y1 = b + s*[0,0.3,-0.3,0,0];
 x2 = a + s*[(f-a)/s,0.6];  y2 = b + s*[0,0];
 line(x1,y1);  line(x2,y2);
 text(a+s*0.3,b-s*0.3,l,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','cap')
 text(a+s*0.3,b-s*0.3,t,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','baseline')
elseif p == 3
 x1 = g + s*[0,0.3,-0.3,0,0];
 y1 = h + s*[0.2,0.6,0.6,0.2,(d-h)/s];
 x2 = g + s*[0,0];  y2 = h + s*[(f-h)/s,0.6];
 line(x1,y1);  line(x2,y2);
 text(g+s*0.2,h+s*0.3,l,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','cap')
 text(g+s*0.2,h+s*0.3,t,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','baseline')
elseif p == 4
 x1 = a + s*[0.6, 0.2, 0.2, 0.6, (f-a)/s];
 y1 = b + s*[  0, 0.3,-0.3,   0,       0];
 x2 = a + s*[(c-a)/s, 0.2];  y2 = b + s*[0, 0];
 line(x1,y1);  line(x2,y2);
 text(a+s*0.5,b-s*0.3,l,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','cap')
 text(a+s*0.5,b-s*0.3,t,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','baseline')
elseif p == 5
 x1 = g + s*[0,0.3,-0.3,0,0];
 y1 = h + s*[0.6,0.2,0.2,0.6,(f-h)/s];
 x2 = g + s*[0,0];  y2 = h + s*[(d-h)/s,0.2];
 line(x1,y1);  line(x2,y2);
 text(g+s*0.2,h+s*0.5,l,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','cap')
 text(g+s*0.2,h+s*0.5,t,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','baseline')
elseif p == 6
 x1 = a + s*[0.2, 0.6, 0.6, 0.2, (c-a)/s];
 y1 = b + s*[  0, 0.3,-0.3,   0, 0];
 x2 = a + s*[(f-a)/s, 0.6];  y2 = b + s*[0, 0];
 line(x1,y1);  line(x2,y2);
 text(a+s*0.3,b+s*0.3,l,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','cap')
 text(a+s*0.3,b+s*0.3,t,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','baseline')
else
 x1 = g + s*[0,0.3,-0.3,0,0];
 y1 = h + s*[0.2,0.6,0.6,0.2,(d-h)/s];
 x2 = g + s*[0,0];  y2 = h + s*[(f-h)/s,0.6];
 line(x1,y1);  line(x2,y2);
 text(g-s*0.2,h+s*0.3,l,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','cap')
 text(g-s*0.2,h+s*0.3,t,'FontName','Times-Italic','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','baseline')
end
