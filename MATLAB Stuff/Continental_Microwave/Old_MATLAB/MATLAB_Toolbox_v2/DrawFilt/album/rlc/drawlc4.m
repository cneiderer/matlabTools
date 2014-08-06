function drlc4 = drawlc4(x0,y0,dx,ds,F);
   
% drawlc4.m  DRAW LC-LADDER
%   
%            Album of Analog Filter Realizations
%                                                               
%   Authors: Miroslav D. Lutovac, Dejan V. Tosic, 1999/02/21    
%   Email: lutovac@iritel.bg.ac.yu      http://galeb.etf.bg.ac.yu/~lutovac/
%   Email: tosic@galeb.etf.bg.ac.yu     http://www.rcub.bg.ac.yu/~tosicde/
%   Copyright (c) 1999-2000 by Lutovac & Tosic                   
%   $Revision: 1.21 $  $Date: 2000/10/03 13:45$                  
%                                                                
%   References:
%   [1] Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans          
%       Filter Design for Signal Processing                     
%       Using MATLAB and Mathematica                         
%       Prentice Hall - ISBN 0-201-36130-2                      
%       http://www.prenhall.com/lutovac                        
%                                                                
% call   drawlc4(0,0,4,5,10)                           
%   
    
Nx = 7;
Ny = 5;
whitebg(figure(gcf),[1 1 1]);
dc = 'k';
x = zeros(1,4*Nx);
y = zeros(1,4*Ny);
for indx = 1:4*Nx
 x(indx) = x0 + dx*indx/4;
end
for indy = 1:4*Ny
 y(indy) = y0 + dx*indy/4;
end
drawtext(x(8), y(8), 'Ladder Realization',F+2, dc);
drawin(x(3), y(6), 'Vg', 2, ds, F, dc);
drawres(x(3), y(6), x(7), ' ', 'Rg', 0, ds/2, F, dc);
drawimp(x(7), y(2), y(6), ' ', 'Z2', 1, ds/2, F, dc);
drawimp(x(7), y(6), x(11), ' ', 'Z3', 0, ds/2, F, dc);
drawimp(x(11), y(2), y(6), ' ', 'Z4', 1, ds/2, F, dc);
drawimp(x(11), y(6), x(15), ' ', 'Z5', 0, ds/2, F, dc);
drawimp(x(15), y(2), y(6), ' ', 'Z6', 1, ds/2, F, dc);
drawimp(x(15), y(6), x(19), ' ', 'Z7', 0, ds/2, F, dc);
drawres(x(19), y(2), y(6), ' ', 'Ro', 3, ds/2, F, dc);
drawnode(x(7), y(6), 'V2', 2, 1, F, dc);
drawnode(x(11), y(6), 'V3', 2, 1, F, dc);
drawnode(x(15), y(6), 'V4', 2, 1, F, dc);
drawnode(x(19), y(6), 'Vo', 2, 1, F, dc);
drawgrnd(x(7), y(2), 0, ds/2, dc);
drawgrnd(x(11), y(2), 0, ds/2, dc);
drawgrnd(x(15), y(2), 0, ds/2, dc);
drawgrnd(x(19), y(2), 0, ds/2, dc);
drawtext(x(1), y(8), ' ',F, dc);
drawtext(x(21), y(8), ' ',F, dc);
axis('equal')
axis('off')
