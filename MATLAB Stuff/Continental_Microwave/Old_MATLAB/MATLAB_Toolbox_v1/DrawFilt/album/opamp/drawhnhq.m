function drhnhq = drawhnhq(x0,y0,dx,ds,F);
   
% drawhnhq.m  DRAW HIGHPASS NOTCH HIGH-Q-FACTOR OP AMP RC BIQUAD
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
%   [2] G. S. Moschytz, P. Horn
%       Active Filter Design Handbook
%       John Wiley, New York, 1981
%                                                                
% call   drawhnhq(0,0,4,5,10)                           
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
drawtext(x(6), y(12), 'HPN-HQ',F+2, dc);
drawopam(x(6), y(7), x(9), ' ', 'A1', 0, ds, F, dc);
drawopam(x(14), y(7), x(17), ' ', 'A2', 0, ds, F, dc);
drawin(x(6), y(3), 'V1', 2, ds, F, dc);
drawres(x(3), y(8), x(6), ' ', 'R1', 0, ds/2, F, dc);
drawres(x(9), y(8), x(12), ' ', 'R3', 0, ds/2, F, dc);
drawres(x(9), y(6), x(12), ' ', 'R4', 0, ds/2, F, dc);
drawres(x(6), y(3), y(6), ' ', 'R5',  3, ds/2, F, dc);
drawcap(x(3), y(6), x(6), ' ', 'C2',  0, ds/2, F, dc);
drawres(x(14), y(3), y(6), ' ', 'R8',  3, ds/2, F, dc);
drawcap(x(12), y(3), y(6), ' ', 'C7',  1, ds/2, F, dc);
drawnode(x(12), y(6), 'V6', 2, 1, F, dc);
drawnode(x(6), y(6), 'V2', 2, 1, F, dc);
drawnode(x(12), y(8), 'V3', 1, 1, F, dc);
drawnode(x(17), y(7), 'V4', 0, 1, F, dc);
drawnode(x(14), y(6), '', 0, 1, F, dc);
drawnode(x(6), y(8), '', 0, 1, F, dc);
drawnode(x(3), y(8), '', 0, 1, F, dc);
drawnode(x(6), y(3), '', 0, 1, F, dc);
drawnode(x(9), y(7), 'V5', 0, 1, F, dc);
drawgrnd(x(14), y(3), 0, ds/2, dc);
drawlhv(x(9), y(6), x(9), y(8), 1, dc);
drawlhv(x(12), y(6), x(14), y(6), 0, dc);
drawlhv(x(12), y(8), x(14), y(8), 0, dc);
drawlhv(x(3), y(6), x(17), y(11), 1, dc);
drawlhv(x(6), y(3), x(12), y(3), 0, dc);
drawlhv(x(17), y(7), x(17), y(11), 0, dc);
drawlhv(x(6), y(8), x(12), y(10), 1, dc);
drawlhv(x(12), y(8), x(12), y(10), 1, dc);  
drawtext(x(1), y(12), ' ',F, dc);
drawtext(x(19), y(12), ' ',F, dc);
axis('equal')
axis('off')
