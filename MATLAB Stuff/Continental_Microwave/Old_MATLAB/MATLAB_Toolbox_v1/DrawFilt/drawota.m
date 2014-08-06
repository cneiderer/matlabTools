function dr = drawota(c,d,f,n,t,p,s,F,dc)

% drawota.m  DRAW OTA
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

if (p == 0)|(p == 1)
  a=(f+c)/2-0.4*s;
  b=d;
  g=c;
else
  a=(f+c)/2+0.4*s;
  b=d;
  g=c;
end

if p == 0
 x1 = a + s*[0.55, 0.55, 0.25, 0.25, 0.55, 0.55, (f-a)/s];
 y1 = b + s*[   0, 0.15, 0.30, -0.3,-0.15,    0,  0];
 x2 = a + s*[(c-a)/s, 0.25];  y2 = b + s*[  0.2, 0.2];
 x3 = a + s*[(c-a)/s, 0.25];  y3 = b + s*[ -0.2,-0.2];
 x4 = a + s*[ 0.28, 0.38];   y4 = b + s*[-0.15,-0.15];
 x5 = a + s*[ 0.28, 0.38];   y5 = b + s*[ 0.15, 0.15];
 x6 = a + s*[ 0.33, 0.33];   y6 = b + s*[ 0.20, 0.1];
 line(x1,y1,'Color',dc);  line(x2,y2,'Color',dc);  line(x3,y3,'Color',dc);
 line(x4,y4,'Color',dc);  line(x5,y5,'Color',dc);  line(x6,y6,'Color',dc);
 text(a+s*0.4,b+s*0.45,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
 text(a+s*0.4,b+s*0.25,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 1
 x1 = a + s*[0.55, 0.55, 0.25, 0.25, 0.55, 0.55, (f-a)/s];
 y1 = b + s*[   0, 0.15, 0.30, -0.3,-0.15,    0,  0];
 x2 = a + s*[(c-a)/s, 0.25];  y2 = b + s*[  0.2, 0.2];
 x3 = a + s*[(c-a)/s, 0.25];  y3 = b + s*[ -0.2,-0.2];
 x4 = a + s*[ 0.28, 0.38];   y4 = b + s*[-0.15,-0.15];
 x5 = a + s*[ 0.28, 0.38];   y5 = b + s*[ 0.15, 0.15];
 x6 = a + s*[ 0.33, 0.33];   y6 = b + s*[-0.20,-0.1];
 line(x1,y1,'Color',dc);  line(x2,y2,'Color',dc);  line(x3,y3,'Color',dc);
 line(x4,y4,'Color',dc);  line(x5,y5,'Color',dc);  line(x6,y6,'Color',dc);
 text(a+s*0.4,b+s*0.45,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
 text(a+s*0.4,b+s*0.25,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 2
 x1 = a - s*[0.55, 0.55, 0.25, 0.25, 0.55, 0.55, -(c-a)/s];
 y1 = b + s*[   0, 0.15, 0.30,-0.30,-0.15,    0, 0];
 x2 = a + s*[(f-a)/s, -0.25];  y2 = b + s*[  0.2, 0.2];
 x3 = a + s*[(f-a)/s, -0.25];  y3 = b + s*[ -0.2,-0.2];
 x4 = a - s*[ 0.28, 0.38];   y4 = b + s*[-0.15,-0.15];
 x5 = a - s*[ 0.28, 0.38];   y5 = b + s*[ 0.15, 0.15];
 x6 = a - s*[ 0.33, 0.33];   y6 = b + s*[ 0.20, 0.1];
 line(x1,y1,'Color',dc);  line(x2,y2,'Color',dc);  line(x3,y3,'Color',dc);
 line(x4,y4,'Color',dc);  line(x5,y5,'Color',dc);  line(x6,y6,'Color',dc);
 text(a-s*0.4,b+s*0.45,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','bottom')
 text(a-s*0.4,b+s*0.25,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','bottom')
else
 x1 = a - s*[0.55, 0.55, 0.25, 0.25, 0.55, 0.55, -(c-a)/s];
 y1 = b + s*[   0, 0.15, 0.30,-0.30,-0.15,    0, 0];
 x2 = a + s*[(f-a)/s, -0.25];  y2 = b + s*[  0.2, 0.2];
 x3 = a + s*[(f-a)/s, -0.25];  y3 = b + s*[ -0.2,-0.2];
 x4 = a - s*[ 0.28, 0.38];   y4 = b + s*[-0.15,-0.15];
 x5 = a - s*[ 0.28, 0.38];   y5 = b + s*[ 0.15, 0.15];
 x6 = a - s*[ 0.33, 0.33];   y6 = b + s*[-0.20,-0.1];
 line(x1,y1,'Color',dc);  line(x2,y2,'Color',dc);  line(x3,y3,'Color',dc);
 line(x4,y4,'Color',dc);  line(x5,y5,'Color',dc);  line(x6,y6,'Color',dc);
 text(a-s*0.4,b+s*0.45,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','bottom')
 text(a-s*0.4,b+s*0.25,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','bottom')
end
