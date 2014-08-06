function dr4tbl = draw4tbl(c,d,f,n,t,p,s,F,dc)

% draw4tbl.m  DRAW 4 TERMINAL BLOCK 
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

if p == 0
 x1 = a + s*[0.6, 0.6, 0.2, 0.2, 0.6, 0.6, (f-a)/s];
 y1 = b + s*[  0, 0.3, 0.3,-0.3,-0.3,   0,  0];
 x1 = a + s*[0.6, 0.6, 0.2, 0.2, 0.6, 0.6];
 y1 = b + s*[  0, 0.3, 0.3,-0.3,-0.3,   0];
 x2 = a + s*[(c-a)/s, 0.2];  y2 = b + s*[  0.2, 0.2];
 x3 = a + s*[(c-a)/s, 0.2];  y3 = b + s*[ -0.2,-0.2];
 x4 = a + s*[ 0.24, 0.28];   y4 = b + s*[-0.15,-0.2];
 x5 = a + s*[ 0.32, 0.28, 0.28];   y5 = b + s*[-0.15,-0.2, -0.25];
 x6 = a + s*[ 0.48, 0.56, 0.48, 0.56];  y6 = b + s*[ 0.05, 0.05,-0.05,-0.05];
 x7 = a + s*[ 0.24, 0.32];   y7 = b + s*[ 0.15, 0.25];
 x8 = a + s*[ 0.32, 0.24];   y8 = b + s*[ 0.15, 0.25];
 line(x1,y1,'Color',dc);  line(x2,y2,'Color',dc);  line(x3,y3,'Color',dc);
 line(x4,y4,'Color',dc);  line(x5,y5,'Color',dc);
 line(x7,y7,'Color',dc);  line(x8,y8,'Color',dc);
  x7 = a + s*[0.6, (f-a)/s];  y7 = b + s*[0.2,  0.2];
  line(x7,y7,'Color',dc);
  x7 = a + s*[0.6, (f-a)/s];  y7 = b - s*[0.2,  0.2];
  line(x7,y7,'Color',dc);
  x6 = a + s*[ 0.48, 0.56, 0.48, 0.56];  y6 = b + s*[ 0.25, 0.25,0.15,0.15];
  line(x6,y6,'Color',dc);
  x6 = a + s*[ 0.48, 0.52, 0.56];  y6 = b - s*[0.15, 0.25,0.15];
  line(x6,y6,'Color',dc);
 text(a+s*0.4,b+s*0.55,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom');
 text(a+s*0.4,b+s*0.35,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
elseif p ==1
 x1 = a + s*[0.6, 0.6, 0.2, 0.2, 0.6, 0.6];
 y1 = b + s*[  0, 0.3, 0.3,-0.3,-0.3,   0];
 x2 = a + s*[(c-a)/s, 0.2];  y2 = b + s*[  0.2, 0.2];
 x3 = a + s*[(c-a)/s, 0.2];  y3 = b + s*[ -0.2,-0.2];
 x4 = a + s*[ 0.24, 0.28];   y4 = b + s*[0.25,0.2];
 x5 = a + s*[ 0.32, 0.28, 0.28];   y5 = b + s*[0.25,0.2, 0.15];
 x6 = a + s*[ 0.48, 0.56, 0.48, 0.56];  y6 = b + s*[ 0.05, 0.05,-0.05,-0.05];
 x7 = a + s*[ 0.24, 0.32];   y7 = b + s*[-0.15,-0.25];
 x8 = a + s*[ 0.32, 0.24];   y8 = b + s*[-0.15,-0.25];
 line(x1,y1,'Color',dc);  line(x2,y2,'Color',dc);  line(x3,y3,'Color',dc);
 line(x4,y4,'Color',dc);  line(x5,y5,'Color',dc);
 line(x7,y7,'Color',dc);  line(x8,y8,'Color',dc);
  x7 = a + s*[0.6, (f-a)/s];  y7 = b + s*[0.2,  0.2];
  line(x7,y7,'Color',dc);
  x7 = a + s*[0.6, (f-a)/s];  y7 = b - s*[0.2,  0.2];
  line(x7,y7,'Color',dc);
  x6 = a + s*[ 0.48, 0.56, 0.48, 0.56];  y6 = b - s*[ 0.15, 0.15,0.25,0.25];
  line(x6,y6,'Color',dc);
  x6 = a + s*[ 0.48, 0.52, 0.56];  y6 = b + s*[0.25, 0.15,0.25];
  line(x6,y6,'Color',dc);
 text(a+s*0.4,b+s*0.55,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom');
 text(a+s*0.4,b+s*0.35,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
elseif p ==2
 x1 = a + s*[0.2, 0.2, 0.6, 0.6, 0.2, 0.2];
 y1 = b + s*[  0, 0.3, 0.3,-0.3,-0.3,   0];
 x2 = a + s*[(f-a)/s, 0.6];  y2 = b + s*[  0.2, 0.2];
 x3 = a + s*[(f-a)/s, 0.6];  y3 = b + s*[ -0.2,-0.2];
 x4 = a + s*[ 0.48, 0.56];   y4 = b + s*[0.15,0.25];
 x5 = a + s*[ 0.48, 0.52, 0.52];   y5 = b + s*[-0.15,-0.2,-0.25];
 x6 = a + s*[ 0.24, 0.32, 0.24, 0.32];  y6 = b + s*[ 0.05, 0.05,-0.05,-0.05];
 x7 = a + s*[ 0.56, 0.48];   y7 = b + s*[0.15,0.25];
 x8 = a + s*[ 0.56, 0.52];   y8 = b + s*[-0.15,-0.2];
 line(x1,y1,'Color',dc);  line(x2,y2,'Color',dc);  line(x3,y3,'Color',dc);
 line(x4,y4,'Color',dc);  line(x5,y5,'Color',dc);
 line(x7,y7,'Color',dc);  line(x8,y8,'Color',dc);
  x7 = a + s*[0.2, (c-a)/s];  y7 = b + s*[0.2,  0.2];
  line(x7,y7,'Color',dc);
  x7 = a + s*[0.2, (c-a)/s];  y7 = b - s*[0.2,  0.2];
  line(x7,y7,'Color',dc);
  x6 = a + s*[0.24, 0.32, 0.24, 0.32];  y6 = b + s*[ 0.25, 0.25,0.15,0.15];
  line(x6,y6,'Color',dc);
  x6 = a + s*[0.24, 0.28, 0.32];  y6 = b - s*[0.15, 0.25,0.15];
  line(x6,y6,'Color',dc);
 text(a+s*0.4,b+s*0.55,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 text(a+s*0.4,b+s*0.35,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
else
 x1 = a + s*[0.2, 0.2, 0.6, 0.6, 0.2, 0.2];
 y1 = b + s*[  0, 0.3, 0.3,-0.3,-0.3,   0];
 x2 = a + s*[(f-a)/s, 0.6];  y2 = b + s*[  0.2, 0.2];
 x3 = a + s*[(f-a)/s, 0.6];  y3 = b + s*[ -0.2,-0.2];
 x6 = a + s*[ 0.24, 0.32, 0.24, 0.32];  y6 = b + s*[ 0.05, 0.05,-0.05,-0.05];
 x4 = a + s*[ 0.48, 0.56];   y4 = b + s*[-0.15,-0.25];
 x5 = a + s*[ 0.48, 0.52, 0.52];   y5 = b + s*[0.25,0.2,0.15];
 x7 = a + s*[ 0.56, 0.48];   y7 = b + s*[-0.15,-0.25];
 x8 = a + s*[ 0.56, 0.52];   y8 = b + s*[0.25,0.2];
line(x1,y1,'Color',dc);  line(x2,y2,'Color',dc);
line(x3,y3,'Color',dc);
line(x4,y4,'Color',dc);  line(x5,y5,'Color',dc);
line(x7,y7,'Color',dc);  line(x8,y8,'Color',dc);
  x7 = a + s*[0.2, (c-a)/s];  y7 = b + s*[0.2,  0.2];
  line(x7,y7,'Color',dc);
  x7 = a + s*[0.2, (c-a)/s];  y7 = b - s*[0.2,  0.2];
  line(x7,y7,'Color',dc);
  x6 = a + s*[0.24, 0.32, 0.24, 0.32];  y6 = b - s*[ 0.15, 0.15,0.25,0.25];
  line(x6,y6,'Color',dc);
  x6 = a + s*[0.24, 0.28, 0.32];  y6 = b + s*[0.25, 0.15,0.25];
  line(x6,y6,'Color',dc);
 text(a+s*0.4,b+s*0.55,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 text(a+s*0.4,b+s*0.35,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
end
