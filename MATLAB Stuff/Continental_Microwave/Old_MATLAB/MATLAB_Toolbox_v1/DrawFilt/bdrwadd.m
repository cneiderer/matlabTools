function [xs,matrixE] = bdrwadd(matrixE,x,y,ds,F,dc)

% bdrwadd.m  BUTTON: DRAW ADDER
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
  title('ADDER input')
  [xe1,ye1]=ginput(1);   xe1 = round(xe1); ye1 =round(ye1);
  title('ADDER output')
line(xe1+2,ye1,'LineWidth',3, 'Color','m')
line(xe1-2,ye1,'LineWidth',3, 'Color','m')
line(xe1,ye1+2,'LineWidth',3, 'Color','m')
line(xe1,ye1-2,'LineWidth',3, 'Color','m')

  [xe2,ye2]=ginput(1);   
[xe21 ix21] = min(abs([xe2-(xe1-2) xe2-(xe1+2)]));
[ye21 iy21] = min(abs([ye2-(ye1-2) ye2-(ye1+2)]));

if abs(xe2-xe1) >= abs(ye2-ye1)
  if ix21 == 1
    xe2 = xe1-2;
  else
    xe2 = xe1+2;
  end
  ye2 = ye1;
else
  if iy21 == 1
    ye2 = ye1-2;
  else
    ye2 = ye1+2;
  end
  xe2 = xe1;
end

  if abs(xe2-xe1) >= abs(ye2-ye1)
   xy = xe2;
   xys ='x';
   xyor = 1;
   if xy < xe1  
    xtmp = xy;
    xy  = xe1;
    xe1 = xtmp;
   xyor = 3;
   end
  else
   xy = ye2;
   xys ='y';
   xyor = 2;
   if xy < ye1  
    ytmp = xy;
    xy  = ye1;
    ye1 = ytmp;
   xyor = 4;
   end
  end

if xyor == 1
  xs = ['drawadd(x(' num2str(xe1) '), y(' num2str(ye1) ...
     '), 2, 1, 1, 3, '' '', ' num2str(xyor) ', ds/3, F, dc);'];
elseif xyor == 3
  xs = ['drawadd(x(' num2str(xe1) '), y(' num2str(ye1) ...
     '), 1, 1, 2, 3, '' '', ' num2str(xyor) ', ds/3, F, dc);'];
elseif xyor == 2
  xs = ['drawadd(x(' num2str(xe1-1) '), y(' num2str(ye1+1) ...
     '), 1, 2, 3, 1, '' '', ' num2str(xyor-1) ', ds/3, F, dc);'];
elseif xyor == 4
  xs = ['drawadd(x(' num2str(xe1-1) '), y(' num2str(ye1+1) ...
     '), 1, 1, 3, 2, '' '', ' num2str(xyor-1) ', ds/3, F, dc);'];
end
  title(' ')

XS(1:max(size(xs)))=xs;
eval(xs);
matrixE=[matrixE;XS];
