function [xs,matrixE] = bdrwlvh(matrixE,x,y,ds,F,dc)

% bdrwlvh.m  BUTTON: DRAW LINE VERTICAL + HORIZONTAL
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

XS = ['                                                             '];
  title('2-segment line vertical+horizontal first point')
  [xe1,ye1]=ginput(1);   xe1 = round(xe1); ye1 =round(ye1);
  title('2-segment line vertical+horizontal first point')
  [xe2,ye2]=ginput(1);   xe2 = round(xe2); ye2 =round(ye2);
xs = ['drawlvh(x(' num2str(xe1) '), y(' num2str(ye1) '),  x(' num2str(xe2) ...
     '),  y(' num2str(ye2) '), 0, dc);'];
  title(' ')

XS(1:max(size(xs)))=xs;
eval(xs);
matrixE=[matrixE;XS];
