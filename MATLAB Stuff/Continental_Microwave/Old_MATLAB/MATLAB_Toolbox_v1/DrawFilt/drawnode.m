function dr = drawnode(a,b,t,p,s,f,dc)

% drawnode.m  DRAW NODE
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
x1 = a + s*0.02*sin(2*pi*xy);
y1 = b + s*0.02*cos(2*pi*xy);
line(x1,y1,'LineWidth',2*s,'Color',dc)
%line(a,b,'LineWidth',4*s,'Color',dc)

if p == 0
 text(a+s*0.075,b,t,'FontName','Times','FontSize',f,...
   'HorizontalAlignment','left','VerticalAlignment','middle')
elseif p == 1
 text(a+s*0.05,b+s*0.05,t,'FontName','Times','FontSize',f,...
   'HorizontalAlignment','left','VerticalAlignment','bottom')
elseif p == 2
 text(a,b+s*0.05,t,'FontName','Times','FontSize',f,...
   'HorizontalAlignment','center','VerticalAlignment','bottom')
elseif p == 3
 text(a-s*0.05,b+s*0.05,t,'FontName','Times','FontSize',f,...
   'HorizontalAlignment','right','VerticalAlignment','bottom')
elseif p == 4
 text(a-s*0.075,b,t,'FontName','Times','FontSize',f,...
   'HorizontalAlignment','right','VerticalAlignment','middle')
elseif p == 5
 text(a-s*0.05,b-s*0.05,t,'FontName','Times','FontSize',f,...
   'HorizontalAlignment','right','VerticalAlignment','top')
elseif p == 6
 text(a,b-s*0.05,t,'FontName','Times','FontSize',f,...
   'HorizontalAlignment','center','VerticalAlignment','top')
else
 text(a+s*0.05,b-s*0.05,t,'FontName','Times','FontSize',f,...
   'HorizontalAlignment','left','VerticalAlignment','top')
end
