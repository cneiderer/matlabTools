function dr = drawadd(a,b,c0,c1,c2,c3,t,p,s,F,dc)

% drawadd.m  DRAW ADDER
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

xy = 0:0.02:1;
x1 = a+s*0.6 + s*0.3*sin(2*pi*xy);
y1 = b       + s*0.3*cos(2*pi*xy);
line(x1,y1,'Color',dc)
x2 = [a+s*0.45, a+s*0.75, a+s*0.6, a+s*0.6,  a+s*0.6];
y2 = [       b,        b,       b, b+s*0.15, b-s*0.15];
line(x2,y2,'Color',dc)

if p == 0
 text(a+s,b,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','middle')
elseif p == 1
 text(a+s*0.8,b+s*0.3,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 2
 text(a+s*0.6,b+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
elseif p == 3
 text(a+s*0.4,b+s*0.3,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','bottom')
elseif p == 4
 text(a+s*0.2,b,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
elseif p == 5
 text(a+s*0.4,b-s*0.3,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','top')
elseif p == 6
 text(a+s*0.6,b-s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
else
 text(a+s*0.8,b-s*0.3,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','top')
end

if c0 == 1
 x3 = [a+s*1.1, a+s, a+s*1.1];  y3 = [b+s*0.05, b, b-s*0.05];  line(x3,y3,'Color',dc)
 x4 = [a+s*0.9,a+s*1.2];        y4 = [b, b];                   line(x4,y4,'Color',dc)
elseif c0 == 2
 x3 = [a+s,a+s*1.1,a+s];  y3 = [b+s*0.05,b,b-s*0.05];  line(x3,y3,'Color',dc)
 x4 = [a+s*0.9,a+s*1.2];  y4 = [b, b];                 line(x4,y4,'Color',dc)
elseif c0 == 3
 x3 = [a+s*1.1, a+s, a+s*1.1]; y3 = [b+s*0.05, b, b-s*0.05];  line(x3,y3,'Color',dc)
 x4 = [a+s*0.9, a+s*1.2];      y4 = [b, b];                   line(x4,y4,'Color',dc)
 x5 = [a+s, a+s*1.1];          y5 = [b+s*0.1,b+s*0.1];        line(x5,y5,'Color',dc)
end
if c1 == 1
 x3 = [a+s*0.55,a+s*0.6,a+s*0.65];  y3 = [b+s*0.5,b+s*0.4,b+s*0.5]; line(x3,y3,'Color',dc)
 x4 = [a+s*0.6, a+s*0.6];        y4 = [b+s*0.6, b+s*0.3];         line(x4,y4,'Color',dc)
elseif c1 == 2
 x3 = [a+s*0.55,a+s*0.6,a+s*0.65]; y3 = [b+s*0.4,b+s*0.5,b+s*0.4]; line(x3,y3,'Color',dc)
 x4 = [a+s*0.6,a+s*0.6];  y4 = [b+s*0.6,b+s*0.3];                line(x4,y4,'Color',dc)
elseif c1 == 3
 x3 = [a+s*0.55,a+s*0.6,a+s*0.65]; y3 = [b+s*0.5,b+s*0.4,b+s*0.5]; line(x3,y3,'Color',dc)
 x4 = [a+s*0.6,a+s*0.6];      y4 = [b+s*0.6,b+s*0.3];          line(x4,y4,'Color',dc)
 x5 = [a+s*0.7,a+s*0.8];      y5 = [b+s*0.45,b+s*0.45];        line(x5,y5,'Color',dc)
end
if c2 == 1
 x3 = [a+s*0.1,a+s*0.2,a+s*0.1]; y3 = [b+s*0.05,b,b-s*0.05];  line(x3,y3,'Color',dc)
 x4 = [a,a+s*0.3];        y4 = [b,b];                   line(x4,y4,'Color',dc)
elseif c2 == 2
 x3 = [a+s*0.2,a+s*0.1,a+s*0.2]; y3 = [b+s*0.05,b,b-s*0.05];  line(x3,y3,'Color',dc)
 x4 = [a,a+s*0.3];  y4 = [b,b];                 line(x4,y4,'Color',dc)
elseif c2 == 3
 x3 = [a+s*0.1,a+s*0.2,a+s*0.1]; y3 = [b+s*0.05,b,b-s*0.05]; line(x3,y3,'Color',dc)
 x4 = [a,a+s*0.3];         y4 = [b, b];                   line(x4,y4,'Color',dc)
 x5 = [a+s*0.2,a+s*0.1];   y5 = [b+s*0.1,b+s*0.1];        line(x5,y5,'Color',dc)
end

if c3 == 1
 x3 = [a+s*0.55,a+s*0.6,a+s*0.65]; y3 = [b-s*0.5,b-s*0.4,b-s*0.5]; line(x3,y3,'Color',dc)
 x4 = [a+s*0.6,a+s*0.6];        y4 = [b-s*0.6,b-s*0.3];            line(x4,y4,'Color',dc)
elseif c3 == 2
 x3 = [a+s*0.55,a+s*0.6,a+s*0.65]; y3 = [b-s*0.4,b-s*0.5,b-s*0.4]; line(x3,y3,'Color',dc)
 x4 = [a+s*0.6,a+s*0.6];  y4 = [b-s*0.6,b-s*0.3];                  line(x4,y4,'Color',dc)
elseif c3 == 3
 x3 = [a+s*0.55,a+s*0.6,a+s*0.65]; y3 = [b-s*0.5,b-s*0.4,b-s*0.5];  line(x3,y3,'Color',dc)
 x4 = [a+s*0.6,a+s*0.6];   y4 = [b-s*0.6,b-s*0.3];          line(x4,y4,'Color',dc)
 x5 = [a+s*0.7,a+s*0.8];   y5 = [b-s*0.45,b-s*0.45];        line(x5,y5,'Color',dc)
end
