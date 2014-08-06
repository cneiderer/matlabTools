function drlc1 = drawlc1(x0,y0,dx,ds,F);
   
% drawlc1.m  DRAW DOUBLY TERMINATED LC-LADDER WITH COMPLEX ZEROS
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
% call   drawlc1(0,0,4,5,10)                           
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
   
drawtext(x(6), y(15), 'Doubly terminated',F,dc)
drawtext(x(6), y(14), ' LC-ladder',F,dc)
drawin(x(3), y(7), 'Vg', 2, ds, F, dc);
drawres(x(3), y(7), x(7), ' ', 'Rg', 0, ds/2, F, dc);
drawcap(x(7), y(3), y(7), ' ', 'C1', 1, ds/2, F, dc);
drawcap(x(7), y(7), x(11), ' ', 'C2', 0, ds/2, F, dc);
drawcap(x(11), y(3), y(7), ' ', 'C3', 3, ds/2, F, dc);
drawcap(x(11), y(7), x(15), ' ', 'C4', 0, ds/2, F, dc);
drawcap(x(15), y(3), y(7), ' ', 'C5', 3, ds/2, F, dc);
drawlnd(x(7), y(11), x(11), ' ', 'L2', 0, ds/2, F, dc);
drawlnd(x(11), y(11), x(15), ' ', 'L4', 0, ds/2, F, dc);
drawlvh(x(15), y(7), x(19), y(7), 0, dc);
drawres(x(19), y(3), y(7), ' ', 'Ro', 3, ds/2, F, dc);
drawnode(x(7), y(7), 'V2', 1, 1, F, dc);
drawnode(x(11), y(7), ' ', 1, 1, F, dc);
drawnode(x(15), y(7), 'V4', 1, 1, F, dc);
drawgrnd(x(7), y(3), 0, ds/2, dc);
drawgrnd(x(11), y(3), 0, ds/2, dc);
drawgrnd(x(15), y(3), 0, ds/2, dc);
drawgrnd(x(19), y(3), 0, ds/2, dc);
drawlvh(x(7), y(7), x(7), y(11), 0, dc);
drawlvh(x(11), y(7), x(11), y(11), 0, dc);
drawlvh(x(15), y(7), x(15), y(11), 0, dc);
drawnode(x(11), y(11), 'V3', 2, 1, F, dc);
drawtext(x(1), y(15), ' ',F, dc);
drawtext(x(21), y(15), ' ',F, dc);
axis('equal')
axis('off')
