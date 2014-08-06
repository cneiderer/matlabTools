%  DEMODRAW  - DEMO DRAWING FILTER REALIZATIONS
%                                                                  
%                 Drawing Filter Realizations                      
%                                                                  
%   Authors: Miroslav D. Lutovac, Dejan V. Tosic, 1999/02/21       
%   lutovac@iritel.bg.ac.yu    http://galeb.etf.bg.ac.yu/~lutovac/ 
%   tosic@galeb.etf.bg.ac.yu   http://www.rcub.bg.ac.yu/~tosicde/  
%   Copyright (c) 1999-2000 by Lutovac & Tosic                     
%   $Revision: 1.21 $  $Date: 2000/10/03 13:45$                    
%                                                                  
%   See also:                                                      
%   Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans            
%        Filter Design for Signal Processing                       
%           Using MATLAB and Mathematica                           
%        Prentice Hall - ISBN 0-201-36130-2                        
%         http://www.prenhall.com/lutovac                          
%                                                                  
% call   demodraw
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
fh2 = figure(2); axis off;
fh1 = figure(1); axis off;
demotime1 = 1;  demotime2 = 1;
demotime3 = 1;  demotime4 = 1;

dc = 'b';
matrixEnew = ['                                                             '];
rdr = 'clf;[x,y]= drawgrid(x0,y0,dx,ds,F,Nx,Ny);bdrwredr(x0,y0,dx,ds,F,Nx,Ny,matrixE,dc);butdraw';
ddfr =  ['''VIEW realization from auxfilt.m''' ',''NumberTitle'', ''off'''];
ddfre=  ['''Make EPS file from auxfilt.m''' ',''NumberTitle'', ''off'''];
ddfr1=  ['''EXAMPLE from example1.m''' ',''NumberTitle'', ''off'''];
ddfr2=  ['''EXAMPLE from example2.m''' ',''NumberTitle'', ''off'''];
ddfr3=  ['''EXAMPLE from example3.m''' ',''NumberTitle'', ''off'''];
ddfr4=  ['''EXAMPLE from example4.m''' ',''NumberTitle'', ''off'''];
trdr = ['if txtst==1;' rdr ';txtst=0; end;'];

xx=get(fh1,'Position')-[50 50 -100 -100];
set(fh2,'Position',xx);
set(fh1, 'Name', 'Drawing Filter Realizations v. 2.1'...
   , 'NextPlot', 'add','NumberTitle', 'off')
whitebg(fh1,[0.95 0.95 1]);
x0 = 0;  y0 = 0; F = 10; dx = 4; ds = 5;
Nx = 7; Ny = 5; dc = 'k'; dc = 'b';

matrixE = ['                                                             '];
XS = ['                                                             '];
txtst = 1;
clf
Nydx = 1;

clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
butdraw
  pause(demotime1)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);title('CLICK a button');
  pause(demotime1);
  uvIN = uicontrol('String', 'In', 'Units', 'normalized' ...
  , 'Position', [0.055 0.555 0.04 0.05], 'CallBack', ' ');
  title('INPUT ');pause(demotime2);
drawin(x(3),y(10),'X',2,ds/2,F, 'r');
  pause(demotime3);
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc);
  title('CLICK a button');pause(demotime1);
  uvADDER = uicontrol('String', 'Adder', 'Units', 'normalized' ...
  , 'Position', [0.01 0.940 0.08 0.05], 'CallBack', ' ');
  pause(demotime2);title('ADDER input');pause(demotime2);title('ADDER output');
drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F,'r');
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  title('CLICK a button');pause(demotime1);
  uvMULT = uicontrol('String', 'Mult', 'Units', 'normalized' ...
  , 'Position', [0.01 0.885 0.08 0.05], 'CallBack',' ');
  pause(demotime2);title('MULTIPLIER input');pause(demotime2); title('MULTIPLIER  output');
drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F,'r');
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  title('CLICK a button');pause(demotime1);
  uvADDER = uicontrol('String', 'Adder', 'Units', 'normalized' ...
  , 'Position', [0.01 0.940 0.08 0.05], 'CallBack', ' ');
  pause(demotime2);title('ADDER input');pause(demotime2);title('ADDER output');
drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F,'r');
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  title('CLICK a button');pause(demotime1);
  uvADDER = uicontrol('String', 'Adder', 'Units', 'normalized' ...
  , 'Position', [0.01 0.940 0.08 0.05], 'CallBack', ' ');
  pause(demotime2);title('ADDER input');pause(demotime2);title('ADDER output');
drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F,'r');
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  title('CLICK a button');pause(demotime1);
  uvDELAY = uicontrol('String', 'Delay', 'Units', 'normalized' ...
  , 'Position', [0.01 0.830 0.08 0.05], 'CallBack', ' ');
  pause(demotime2);title('DELAY input');pause(demotime2);title('DELAY  output');
drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F,'r');
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
  title('CLICK a button');pause(demotime1);
  uvLINE = uicontrol('String', 'LINE', 'Units', 'normalized' ...
  , 'Position', [0.01 0.665 0.08 0.05], 'CallBack',' ');
  pause(demotime2);title('LINE 1st point');pause(demotime2);title('LINE 2nd point');
drawline(x(9),y(8),x(4),y(9),'r')
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
  drawline(x(9),y(8),x(4),y(9), dc)
  title('CLICK a button');pause(demotime1);
  uvLINEHV = uicontrol('String', '__I', 'Units', 'normalized' ...
  , 'Position', [0.01 0.61 0.045 0.05], 'CallBack',' ');
  pause(demotime2);title('2-segment line horizontal+vertical first point');
  pause(demotime2);title('2-segment line horizontal+vertical last point');
drawlhv(x(3),y(10),x(3),y(7), 0,'r')
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
  drawline(x(9),y(8),x(4),y(9), dc)
  drawlhv(x(3),y(10),x(3),y(7), 0, dc)
  title('CLICK a button');pause(demotime1);
  uvLINEHV = uicontrol('String', '__I', 'Units', 'normalized' ...
  , 'Position', [0.01 0.61 0.045 0.05], 'CallBack',' ');
  pause(demotime2);title('2-segment line horizontal+vertical first point');
  pause(demotime2);title('2-segment line horizontal+vertical last point');
drawlhv(x(9),y(7),x(9),y(8), 0,'r')
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
  drawline(x(9),y(8),x(4),y(9), dc)
  drawlhv(x(3),y(10),x(3),y(7), 0, dc)
  drawlhv(x(9),y(7),x(9),y(8), 0, dc)
  title('CLICK a button');pause(demotime1);
  uvLINE = uicontrol('String', 'LINE', 'Units', 'normalized' ...
  , 'Position', [0.01 0.665 0.08 0.05], 'CallBack',' ');
  pause(demotime2);title('LINE 1st point');pause(demotime2);title('LINE 2nd point');
drawline(x(9),y(10),x(4),y(8),'r')
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
  drawline(x(9),y(8),x(4),y(9), dc)
  drawlhv(x(3),y(10),x(3),y(7), 0, dc)
  drawlhv(x(9),y(7),x(9),y(8), 0, dc)
  drawline(x(9),y(10),x(4),y(8), dc)
  title('CLICK a button');pause(demotime1);
  uvADDER = uicontrol('String', 'Adder', 'Units', 'normalized' ...
  , 'Position', [0.01 0.940 0.08 0.05], 'CallBack', ' ');
  pause(demotime2);title('ADDER input');pause(demotime2);title('ADDER output');
drawadd(x(10), y(9), 2, 1, 1, 0,' ',6,ds/3,F,'r');
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
  drawline(x(9),y(8),x(4),y(9), dc)
  drawlhv(x(3),y(10),x(3),y(7), 0, dc)
  drawlhv(x(9),y(7),x(9),y(8), 0, dc)
  drawline(x(9),y(10),x(4),y(8), dc)
  drawadd(x(10), y(9), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  title('CLICK a button');pause(demotime1);
  uvMULT = uicontrol('String', 'Mult', 'Units', 'normalized' ...
  , 'Position', [0.01 0.885 0.08 0.05], 'CallBack',' ');
  pause(demotime2);title('MULTIPLIER input');pause(demotime2); title('MULTIPLIER  output');
drawmult(x(12), y(9),x(15),' ','b', 0,0.9*ds/2,F,'r');
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
  drawline(x(9),y(8),x(4),y(9), dc)
  drawlhv(x(3),y(10),x(3),y(7), 0, dc)
  drawlhv(x(9),y(7),x(9),y(8), 0, dc)
  drawline(x(9),y(10),x(4),y(8), dc)
  drawadd(x(10), y(9), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawmult(x(12), y(9),x(15),' ','b', 0,0.9*ds/2,F, dc);
  title('CLICK a button');pause(demotime1);
  uvOUT = uicontrol('String', 'Out', 'Units', 'normalized' ...
  , 'Position', [0.01 0.50 0.08 0.05], 'CallBack',' ');
  pause(demotime2);title('OUTPUT');
drawout(x(15),y(9),'Y',0,ds/2,F,'r');
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
  drawline(x(9),y(8),x(4),y(9), dc)
  drawlhv(x(3),y(10),x(3),y(7), 0, dc)
  drawlhv(x(9),y(7),x(9),y(8), 0, dc)
  drawline(x(9),y(10),x(4),y(8), dc)
  drawadd(x(10), y(9), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawmult(x(12), y(9),x(15),' ','b', 0,0.9*ds/2,F, dc);
  drawout(x(15),y(9),'Y',0,ds/2,F, dc) 
  title('CLICK a button');pause(demotime1);
  uvDELAY = uicontrol('String', 'Delay', 'Units', 'normalized' ...
  , 'Position', [0.01 0.830 0.08 0.05], 'CallBack', ' ');
  pause(demotime2);title('DELAY input');pause(demotime2);title('DELAY  output');
drawdel(x(3),y(13),x(11),' ','-1',8,ds/2,F,'r');
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
  drawline(x(9),y(8),x(4),y(9), dc)
  drawlhv(x(3),y(10),x(3),y(7), 0, dc)
  drawlhv(x(9),y(7),x(9),y(8), 0, dc)
  drawline(x(9),y(10),x(4),y(8), dc)
  drawadd(x(10), y(9), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawmult(x(12), y(9),x(15),' ','b', 0,0.9*ds/2,F, dc);
  drawout(x(15),y(9),'Y',0,ds/2,F, dc) 
  drawdel(x(3),y(13),x(11),' ','-1',8,ds/2,F, dc);
  title('CLICK a button');pause(demotime1);
  uvNODE = uicontrol('String', 'NODE', 'Units', 'normalized' ...
  , 'Position', [0.01 0.445 0.08 0.05], 'CallBack',' ');
  pause(demotime2);title('NODE ');
drawnode(x(3) ,y(10) ,'1',1,1,F, 'r');
  pause(demotime3)
drawnode(x(3) ,y(10) ,'1',1,1,F, dc);
drawnode(x(5) ,y(10) ,'2',2,1,F, dc);
drawnode(x(9),y(10) ,'3',2,1,F, dc);
drawnode(x(10),y(9) ,'4',2,1,F, dc);
drawnode(x(9),y(8) ,'5',0,1,F, dc);
drawnode(x(5) ,y(7) ,'6',2,1,F, dc);
drawnode(x(11) ,y(10) ,'7',0,1,F, dc);
drawnode(x(12) ,y(9) ,'8',2,1,F, dc);
drawnode(x(15) ,y(9) ,'9',2,1,F, dc);  
  title('CLICK a button');pause(demotime1);
  uvLINEHV = uicontrol('String', '__I', 'Units', 'normalized' ...
  , 'Position', [0.01 0.445 0.08 0.05], 'CallBack',' ');
  pause(demotime2);title('2-segment line horizontal+vertical first point');
  pause(demotime2);title('2-segment line horizontal+vertical last point');
drawlhv(x(11),y(13),x(11),y(10), 0, dc)
drawlhv(x(3),y(10),x(3),y(13), 0, dc)
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
  drawline(x(9),y(8),x(4),y(9), dc)
  drawlhv(x(3),y(10),x(3),y(7), 0, dc)
  drawlhv(x(9),y(7),x(9),y(8), 0, dc)
  drawline(x(9),y(10),x(4),y(8), dc)
  drawadd(x(10), y(9), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawmult(x(12), y(9),x(15),' ','b', 0,0.9*ds/2,F, dc);
  drawout(x(15),y(9),'Y',0,ds/2,F, dc) 
  drawdel(x(3),y(13),x(11),' ','-1',8,ds/2,F, dc);
  drawnode(x(3) ,y(10) ,'1',1,1,F, dc);
  drawnode(x(3) ,y(10) ,'1',1,1,F, dc);
  drawnode(x(5) ,y(10) ,'2',2,1,F, dc);
  drawnode(x(9),y(10) ,'3',2,1,F, dc);
  drawnode(x(10),y(9) ,'4',2,1,F, dc);
  drawnode(x(9),y(8) ,'5',0,1,F, dc);
  drawnode(x(5) ,y(7) ,'6',2,1,F, dc);
  drawnode(x(11) ,y(10) ,'7',0,1,F, dc);
  drawnode(x(12) ,y(9) ,'8',2,1,F, dc);
  drawnode(x(15) ,y(9) ,'9',2,1,F, dc);  
  drawlhv(x(11),y(13),x(11),y(10), 0, dc)
  drawlhv(x(3),y(10),x(3),y(13), 0, dc)
  title('CLICK a button');pause(demotime1);
  uvTEXT = uicontrol('String', 'TEXT', 'Units', 'normalized' ...
  , 'Position', [0.01 0.390 0.08 0.05], 'CallBack',' ');
  pause(demotime2);title('Text');
  set(gcf,'DefaultTextColor','r')
drawtext(x(7), y(15),'TEXT filter', F+1,'r');
  set(gcf,'DefaultTextColor','k')
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
  drawline(x(9),y(8),x(4),y(9), dc)
  drawlhv(x(3),y(10),x(3),y(7), 0, dc)
  drawlhv(x(9),y(7),x(9),y(8), 0, dc)
  drawline(x(9),y(10),x(4),y(8), dc)
  drawadd(x(10), y(9), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawmult(x(12), y(9),x(15),' ','b', 0,0.9*ds/2,F, dc);
  drawout(x(15),y(9),'Y',0,ds/2,F, dc) 
  drawdel(x(3),y(13),x(11),' ','-1',8,ds/2,F, dc);
  drawnode(x(3) ,y(10) ,'1',1,1,F, dc);
  drawnode(x(3) ,y(10) ,'1',1,1,F, dc);
  drawnode(x(5) ,y(10) ,'2',2,1,F, dc);
  drawnode(x(9),y(10) ,'3',2,1,F, dc);
  drawnode(x(10),y(9) ,'4',2,1,F, dc);
  drawnode(x(9),y(8) ,'5',0,1,F, dc);
  drawnode(x(5) ,y(7) ,'6',2,1,F, dc);
  drawnode(x(11) ,y(10) ,'7',0,1,F, dc);
  drawnode(x(12) ,y(9) ,'8',2,1,F, dc);
  drawnode(x(15) ,y(9) ,'9',2,1,F, dc);  
  drawlhv(x(11),y(13),x(11),y(10), 0, dc)
  drawlhv(x(3),y(10),x(3),y(13), 0, dc)
  set(gcf,'DefaultTextColor','y')
  drawtext(x(7), y(15),'TEXT filter', F+1, dc);
  set(gcf,'DefaultTextColor','k')
  title('CLICK a button');pause(demotime1);
  uie = uicontrol('String', 'EDIT', 'Units', 'normalized' ...
     , 'Position', [0.92 0.62 0.08 0.05], 'CallBack',' ');
  pause(demotime2);title('CLICK an object node to EDIT');
  set(gcf,'DefaultTextColor','r')
  drawtext(x(7), y(15),'TEXT filter', F+1, dc);
  set(gcf,'DefaultTextColor','k')
  title('EDIT  Click left mouse button for YES, right for NO')
  pause(demotime2); title('YES'); pause(demotime2);
  set(gcf,'DefaultTextColor','b')
  drawtext(x(7), y(15),'Third-order digital filter', F+1, dc);
  set(gcf,'DefaultTextColor','k')
  pause(demotime3)
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
  drawline(x(9),y(8),x(4),y(9), dc)
  drawlhv(x(3),y(10),x(3),y(7), 0, dc)
  drawlhv(x(9),y(7),x(9),y(8), 0, dc)
  drawline(x(9),y(10),x(4),y(8), dc)
  drawadd(x(10), y(9), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawmult(x(12), y(9),x(15),' ','b', 0,0.9*ds/2,F, dc);
  drawout(x(15),y(9),'Y',0,ds/2,F, dc) 
  drawdel(x(3),y(13),x(11),' ','-1',8,ds/2,F, dc);
  drawnode(x(3) ,y(10) ,'1',1,1,F, dc);
  drawnode(x(3) ,y(10) ,'1',1,1,F, dc);
  drawnode(x(5) ,y(10) ,'2',2,1,F, dc);
  drawnode(x(9),y(10) ,'3',2,1,F, dc);
  drawnode(x(10),y(9) ,'4',2,1,F, dc);
  drawnode(x(9),y(8) ,'5',0,1,F, dc);
  drawnode(x(5) ,y(7) ,'6',2,1,F, dc);
  drawnode(x(11) ,y(10) ,'7',0,1,F, dc);
  drawnode(x(12) ,y(9) ,'8',2,1,F, dc);
  drawnode(x(15) ,y(9) ,'9',2,1,F, dc);  
  drawlhv(x(11),y(13),x(11),y(10), 0, dc)
  drawlhv(x(3),y(10),x(3),y(13), 0, dc)
  drawtext(x(7), y(15),'Third-order digital filter', F+1, dc);
  title('CLICK a button');pause(demotime1);
  uiDELETE = uicontrol('String', 'DELETE', 'Units', 'normalized' ...
  , 'Position', [0.89 0.07 0.11 0.05],'CallBack',' ');
  pause(demotime2);title('CLICK an object node to DELETE');
  drawdel(x(3),y(13),x(11),' ','-1',8,ds/2,F,'r');
  title('DELETE  Click left mouse button for YES, right for NO')
  pause(demotime2); title('YES'); pause(demotime2);
  clf;[x,y]=drawgrid(x0,y0,dx,ds,F,Nx,Ny);
  drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
  drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
  drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
  drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
  drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
  drawline(x(9),y(8),x(4),y(9), dc)
  drawlhv(x(3),y(10),x(3),y(7), 0, dc)
  drawlhv(x(9),y(7),x(9),y(8), 0, dc)
  drawline(x(9),y(10),x(4),y(8), dc)
  drawadd(x(10), y(9), 2, 1, 1, 0,' ',6,ds/3,F, dc);
  drawmult(x(12), y(9),x(15),' ','b', 0,0.9*ds/2,F, dc);
  drawout(x(15),y(9),'Y',0,ds/2,F, dc) 
  drawnode(x(3) ,y(10) ,'1',1,1,F, dc);
  drawnode(x(3) ,y(10) ,'1',1,1,F, dc);
  drawnode(x(5) ,y(10) ,'2',2,1,F, dc);
  drawnode(x(9),y(10) ,'3',2,1,F, dc);
  drawnode(x(10),y(9) ,'4',2,1,F, dc);
  drawnode(x(9),y(8) ,'5',0,1,F, dc);
  drawnode(x(5) ,y(7) ,'6',2,1,F, dc);
  drawnode(x(11) ,y(10) ,'7',0,1,F, dc);
  drawnode(x(12) ,y(9) ,'8',2,1,F, dc);
  drawnode(x(15) ,y(9) ,'9',2,1,F, dc);  
  drawlhv(x(11),y(13),x(11),y(10), 0, dc)
  drawlhv(x(3),y(10),x(3),y(13), 0, dc)
  drawtext(x(7), y(15),'Third-order digital filter', F+1, dc);
  title('CLICK a button');pause(demotime1);
  pause(5);

clear auxfilt;
clf;auxfilt(0,0,4,5,10); pause(demotime3);
whitebg(fh2,[1 1 1]); pause(demotime1)
fh2=figure(2);
set(fh2,'Name','DEMO DrawFilt');
clf;example1(0,0,4,5,10); pause(demotime3)
clf;example2(0,0,4,5,10); pause(demotime3)
clf;example3(0,0,4,5,10); pause(demotime3)
clf;example4(0,0,4,5,10); pause(demotime3)
clf;example5(0,0,4,5,10); pause(demotime3)
clf;example6(0,0,4,5,10); pause(demotime3)

disp(' ')
disp(' ')
disp(' Invoke this toolbox by executing')
disp('                         drawfilt')
disp('---------------------------------')
disp(' ')
disp(' ')
drawfilt
