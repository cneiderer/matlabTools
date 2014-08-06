function dr = drawres(c,d,f,n,t,p,s,F,dc)

% drawres.m  DRAW RESISTOR
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
 x = a + s*[(c-a)/s, 0.1, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.7, (f-a)/s];
 y = b + s*[      0,   0, 0.15,-0.15, 0.15,-0.15, 0.15,-0.15,   0, 0];
 line(x,y,'Color',dc)
 text(a+s*0.4,b+s*0.5,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
 text(a+s*0.4,b+s*0.2,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
elseif p == 1
 x = g + s*[      0,   0,-0.15, 0.15,-0.15, 0.15,-0.15, 0.15,   0, 0];
 y = h + s*[(d-h)/s, 0.1, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.7, (f-h)/s];
 line(x,y,'Color',dc)
 text(g-s*0.2,h+s*0.4,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','top')
 text(g-s*0.2,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','bottom')
elseif p == 2
 x = a + s*[(c-a)/s, 0.1, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.7, (f-a)/s];
 y = b + s*[      0,   0, 0.15,-0.15, 0.15,-0.15, 0.15,-0.15,   0, 0];
 line(x,y,'Color',dc)
 text(a+s*0.4,b-s*0.5,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
 text(a+s*0.4,b-s*0.2,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
else
 x = g + s*[      0,   0,-0.15, 0.15,-0.15, 0.15,-0.15, 0.15,   0, 0];
 y = h + s*[(d-h)/s, 0.1, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.7, (f-h)/s];
 line(x,y,'Color',dc)
 text(g+s*0.2,h+s*0.4,n,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','top')
 text(g+s*0.2,h+s*0.4,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
end
