function matrixEE = bdrwopen(x0,y0,dx,ds,F,Nx,Ny,matrixE)

% bdrwopen.m  BUTTON: OPEN SCHEMATIC
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

pathnamea = lower(pwd);
lpathnamea = length(pathnamea);
epathnamea = sum(abs(pathnamea(lpathnamea-7:lpathnamea)-'drawfilt'));

if epathnamea == 0
  cd(lower([pathnamea '\album']));
  [filename, pathname] = uigetfile('*.m', 'Open Specification File');
  filespec = [pathname, filename];
else
  [filename, pathname] = uigetfile('*.m', 'Open Specification File');
  filespec = [pathname, filename];
end

if filename==0
  cd(pathnamea);
  return
end

x = zeros(1,4*Nx);
y = zeros(1,4*Ny);
for indx = 1:4*Nx
 x(indx) = x0 + dx*indx/4;
end
for indy = 1:4*Ny
 y(indy) = y0 + dx*indy/4;
end

XS     =['                                                             '];
XS(2,:)=['                                                             '];
indXS = 2;  
fid=fopen(filespec);
  while 1
    xs = fgetl(fid);
    if ~isstr(xs), break, end
    if (xs(1:3)=='dra')
      maxsizeXS = min(max(size(xs)),61);
      XS(indXS,1:maxsizeXS)=xs(1:maxsizeXS);
      indXS = indXS+1;
    end
  end
fclose(fid);

matrixEE = XS;

cd(pathnamea);
