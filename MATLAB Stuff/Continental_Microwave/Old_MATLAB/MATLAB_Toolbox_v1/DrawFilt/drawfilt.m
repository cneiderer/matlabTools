% drawfilt.m   DRAWING DIGITAL & ANALOG FILTER REALIZATIONS (main script)
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

clear all; close all

%fh3 = figure(3); axis off;
fh2 = figure(2); axis off;
fh1 = figure(1); axis off;
%xx=get(fh1,'Position')+[50 50 0 0];
xx=get(fh1,'Position')+[-100 -50 160 100];
set(fh2,'Position',xx);


set(fh1, 'Name', 'Draw Filter Realizations v2.1'...
   , 'NextPlot', 'replace','NumberTitle', 'off')
whitebg(fh1,[1 1 1]);

x0 = 0;
y0 = 0;
F = 10;
dx = 4;
ds = 5;
Nx = 7;
Ny = 5;
[x,y]= drawgrid(x0,y0,dx,ds,F,Nx,Ny);

matrixE = ['                                                             '];
XS = ['                                                             '];

txtst = 1;
bdrwinfo
butdraw;
