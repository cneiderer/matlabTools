function xs = bdrwsave(matrixE)
             
% bdrwsave.m  BUTTON: SAVE SCHEMATIC IN AUXFILT.M
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
                 
delete auxfilt.m
diary  auxfilt.m
disp('function dr = auxfilt(x0,y0,dx,ds,F)                               ')
disp('% auxfilt.m    AUXILIARY DRAWING                                   ')
disp('%  Realization generated from the drawing window of the toolbox    ')
disp('%                                                                  ')
disp('%         DRAWFILT  -  Drawing Filter Realizations                 ')
disp('%                                                                  ')
disp('%   Authors: Miroslav D. Lutovac, Dejan V. Tosic, 1999/02/21       ')
disp('%   lutovac@iritel.bg.ac.yu    http://galeb.etf.bg.ac.yu/~lutovac/ ')
disp('%   tosic@galeb.etf.bg.ac.yu   http://www.rcub.bg.ac.yu/~tosicde/  ')
disp('%   Copyright (c) 1999-2000 by Lutovac & Tosic                     ')
disp('%   $Revision: 1.21 $  $Date: 2000/10/03 13:45$                    ')
disp('%                                                                  ')
disp('%   See also:                                                      ')
disp('%   Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans            ')
disp('%        Filter Design for Signal Processing                       ')
disp('%           Using MATLAB and Mathematica                           ')
disp('%        Prentice Hall - ISBN 0-201-36130-2                        ')
disp('%         http://www.prenhall.com/lutovac                          ')
disp('%                                                                  ')
disp('% call   auxfilt(0,0,4,5,10)                                       ')
timedraw = clock;
tmpstr = ['% creation date: ' date '  time: ' num2str(timedraw(4)) ':' num2str(timedraw(5))];
disp(tmpstr)
disp('Nx = 7;')
disp('Ny = 5;')
disp('whitebg(figure(gcf),[1 1 1]);')
disp('dc = ''k'';')
disp('x = zeros(1,4*Nx);')
disp('y = zeros(1,4*Ny);')
disp('for indx = 1:4*Nx')
disp(' x(indx) = x0 + dx*indx/4;')
disp('end')
disp('for indy = 1:4*Ny')
disp(' y(indy) = y0 + dx*indy/4;')
disp('end')
[imatE1,imatE2] = size(matrixE);
if imatE1 >0
  matrixE(1,:)=[];
end
disp(matrixE)
disp('axis(''equal'')')
disp('axis(''off'')')
xs = matrixE;
diary  off
