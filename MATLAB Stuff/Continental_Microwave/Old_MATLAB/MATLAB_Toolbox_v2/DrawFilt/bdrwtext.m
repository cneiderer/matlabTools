function [xs,matrixE] = bdrwtext(matrixE,x,y,ds,F,dc)

% bdrwtext.m  BUTTON: DRAW TEXT
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
title('Text')
  [xe1,ye1]=ginput(1);   xe1 = round(xe1); ye1 =round(ye1);

indH = 1;
[ind1,ind2] = size(matrixE); 
for indi = 1 : ind1
  if sum(abs(matrixE(indi,1:8) - 'drawtext')) == 0
    indH = indH + 1;
  end
end

Htext = ['''F' int2str(indH) ''''];

xs = ['drawtext(x(' num2str(xe1) '), y(' num2str(ye1) '), ' Htext ', F+1, dc);'];
  title(' ')

XS(1:max(size(xs)))=xs;
eval(xs);
matrixE=[matrixE;XS];

