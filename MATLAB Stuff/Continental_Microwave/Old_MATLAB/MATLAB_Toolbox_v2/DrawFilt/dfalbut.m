% dfalbut.m   GENERATE BUTTONS: ALBUM OF DIGITAL FILTER REALIZATIONS
%
%            Album of Digital Filter Realizations
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

x0 = 0; y0 = 0; dx = 2; ds = 2.5; F  = 10;
pathnamea = lower(pwd);
pathnameadigital = lower([pathnamea '\album\digital']);
pathnameautility = lower([pathnamea '\album\utility']);

uiDF1 = uicontrol('String', 'DF1', 'Units', 'normalized' ...
     , 'Position', [0.0 0.84 0.08 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''drawdf1(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiTDF1 = uicontrol('String', 'TDF1', 'Units', 'normalized' ...
     , 'Position', [0.0 0.78 0.08 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''drawtdf1(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiDF2b = uicontrol('String', 'DF2', 'Units', 'normalized' ...
     , 'Position', [0.0 0.70 0.08 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''drawdf2b(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiTDF2 = uicontrol('String', 'TDF2', 'Units', 'normalized' ...
     , 'Position', [0.0 0.64 0.08 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''drawtdf2(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiAP1A = uicontrol('String', 'AP1A', 'Units', 'normalized' ...
     , 'Position', [0.0 0.56 0.08 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''drawap1a(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiAP1B = uicontrol('String', 'AP1B', 'Units', 'normalized' ...
     , 'Position', [0.0 0.5 0.08 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''drawap1b(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiAP1C = uicontrol('String', 'AP1C', 'Units', 'normalized' ...
     , 'Position', [0.0 0.44 0.08 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''drawap1c(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiAP2A = uicontrol('String', 'AP2A', 'Units', 'normalized' ...
     , 'Position', [0.0 0.36 0.08 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''drawap2a(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiAP2B = uicontrol('String', 'AP2B', 'Units', 'normalized' ...
     , 'Position', [0.0 0.3 0.08 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''drawap2b(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiAP2C = uicontrol('String', 'AP2C', 'Units', 'normalized' ...
     , 'Position', [0.0 0.24 0.08 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''drawap2c(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

ui3RD = uicontrol('String', '3rd', 'Units', 'normalized' ...
  , 'Position', [0.0 0.16 0.08 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''draw3rd(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiCDF2 = uicontrol('String', 'CDF2', 'Units', 'normalized' ...
     , 'Position', [0.0 0.08 0.09 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''drawcdf2(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

% ------------------------------------------

uiFIR1  = uicontrol('String', 'CDF-FIR', 'Units', 'normalized' ...
     , 'Position', [0.9 0.09 0.10 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''dfircf(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiFIR2  = uicontrol('String', 'TDF-FIR', 'Units', 'normalized' ...
     , 'Position', [0.9 0.15 0.10 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''dfirtdfa(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiFIR3  = uicontrol('String', 'DF-FIR', 'Units', 'normalized' ...
     , 'Position', [0.9 0.21 0.10 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''dfirdfa(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiFIR4  = uicontrol('String', 'LP-FIR1', 'Units', 'normalized' ...
     , 'Position', [0.9 0.27 0.10 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''dfirlp1(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiFIR5  = uicontrol('String', 'LP-FIR2', 'Units', 'normalized' ...
     , 'Position', [0.9 0.33 0.10 0.05], 'CallBack', ...
  'cd(pathnameadigital);clf;eval(''dfirlp2(x0,x0,dx,ds,F)''); cd ..; cd ..; dfalbut');

uiMITRA6p5t  = uicontrol('String', 'draw +', 'Units', 'normalized' ...
     , 'Position', [0.9 0.39 0.10 0.05], 'CallBack', ...
  'cd(pathnameautility);clf;eval(''mit6p5t;''); cd ..; cd ..; dfalbut');

% ------------------------------------------

uiCLOSE = uicontrol('String', 'close', 'Units', 'normalized' ...
     , 'Position', [0.92 0.92 0.07 0.06] ...
     , 'CallBack', 'close(gcf)');

uiINFO = uicontrol('String', 'info', 'Units', 'normalized' ...
     , 'Position', [0.92 0.82 0.07 0.06] ...
     , 'CallBack', 'dfalbum');
