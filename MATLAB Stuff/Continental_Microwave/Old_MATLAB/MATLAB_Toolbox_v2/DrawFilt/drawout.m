function dr = drawout(a,b,t,p,s,F,dc)

% drawout.m  DRAW OUTPUT
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

xy = 0:0.05:1;

if p == 0
% {a,b},{a+s*0.1,b}
 x = [a,a+s*0.1];   y = [b,b];
 line(x,y,'Color',dc)
 x1 = a+s*0.15 + s*0.05*sin(2*pi*xy);
 y1 = b + s*0.05*cos(2*pi*xy);
 line(x1,y1,'Color',dc)
 text(a+s*0.275,b,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','left','VerticalAlignment','middle')
elseif p == 1
 x = [a,a];   y = [b,b+s*0.1];
 line(x,y,'Color',dc)
 x1 = a + s*0.05*sin(2*pi*xy);
 y1 = b+s*0.15 + s*0.05*cos(2*pi*xy);
 line(x1,y1,'Color',dc)
 text(a,b+s*0.275,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
elseif p == 2
 x = [a,a-s*0.1];   y = [b,b];
 line(x,y,'Color',dc)
 x1 = a-s*0.15 + s*0.05*sin(2*pi*xy);
 y1 = b + s*0.05*cos(2*pi*xy);
 line(x1,y1,'Color',dc)
 text(a-s*0.275,b,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
else
 x = [a,a];   y = [b,b-s*0.1];
 line(x,y,'Color',dc)
 x1 = a + s*0.05*sin(2*pi*xy);
 y1 = b-s*0.15 + s*0.05*cos(2*pi*xy);
 line(x1,y1,'Color',dc)
 text(a,b-s*0.275,t,'FontName','Times','FontSize',F,...
   'HorizontalAlignment','center','VerticalAlignment','top')
end
