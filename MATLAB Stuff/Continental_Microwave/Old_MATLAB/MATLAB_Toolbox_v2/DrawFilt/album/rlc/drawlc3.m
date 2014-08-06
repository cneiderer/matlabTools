function drlc3 = drawlc3(x0,y0,dx,ds,F);
   
% drawlc3.m  DRAW SINGLY TERMINATED LC-LADDER WITH ZEROS AT ORIGIN
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
% call   drawlc3(0,0,4,5,10)                           
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
drawtext(x(8), y(8), 'Singly terminated LC-ladder',F+1, dc);
drawin(x(3), y(6), 'Vg', 2, ds, F, dc);
drawcap(x(3), y(6), x(7), ' ', 'C2', 0, ds/2, F, dc);
drawlnd(x(7), y(6), x(11), ' ', 'L2', 0, ds/2, F, dc);
drawcap(x(11), y(2), y(6), ' ', 'C1', 1, ds/2, F, dc);
drawlnd(x(11), y(6), x(15), ' ', 'L1', 0, ds/2, F, dc);
drawres(x(15), y(2), y(6), ' ', 'Ro', 1, ds/2, F, dc);
drawnode(x(11), y(6), 'V2', 2, 1, F, dc);
drawnode(x(15), y(6), 'Vo', 2, 1, F, dc);
drawgrnd(x(11), y(2), 0, ds/2, dc);
drawgrnd(x(15), y(2), 0, ds/2, dc);
drawtext(x(1), y(8), ' ',F, dc);
drawtext(x(17), y(8), ' ',F, dc);
axis('equal')
axis('off')
