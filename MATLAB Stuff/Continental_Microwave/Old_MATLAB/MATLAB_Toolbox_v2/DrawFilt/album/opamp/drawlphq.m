function drlphq = drawlphq(x0,y0,dx,ds,F);
   
% drawlphq.m  DRAW LOWPASS HIGH-Q-FACTOR OP AMP RC BIQUAD
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
% call   drawlphq(0,0,4,5,10)                           
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
   
drawtext(x(5), y(14), 'LP-HQ',F+2, dc);
drawopam(x(5), y(7), x(10), ' ', 'A1', 0, ds, F, dc);
drawopam(x(16), y(7), x(20), ' ', 'A2', 0, ds, F, dc);
drawin(x(15), y(2), 'V1', 3, ds, F, dc);
drawcap(x(1), y(11), x(5), ' ', 'C1', 0, ds/2, F, dc);
drawres(x(1), y(8), x(5), ' ', 'R1', 0, ds/2, F, dc);
drawres(x(10), y(8), x(15), ' ', 'R3', 0, ds/2, F, dc);
drawcap(x(10), y(6), x(15), ' ', 'C4', 0, ds/2, F, dc);
drawres(x(5), y(2), y(6), ' ', 'R6',  3, ds/2, F, dc);
drawres(x(1), y(6), x(5), ' ', 'R2',  0, ds/2, F, dc);
drawres(x(15), y(2), y(6), ' ', 'R7',  1, ds/2, F, dc);
drawnode(x(15), y(6), 'V6', 2, 1, F, dc);
drawnode(x(5), y(6), 'V2', 2, 1, F, dc);
drawnode(x(15), y(8), 'V3', 1, 1, F, dc);
drawnode(x(20), y(7), 'V4', 0, 1, F, dc);
drawnode(x(5), y(8), '', 0, 1, F, dc);
drawnode(x(1), y(8), '', 0, 1, F, dc);
drawnode(x(5), y(11), '', 0, 1, F, dc);
drawnode(x(1), y(11), '', 0, 1, F, dc);
drawnode(x(10), y(7), 'V5', 0, 1, F, dc);
drawgrnd(x(5), y(2), 0, ds/2, dc);
drawlhv(x(10), y(6), x(10), y(8), 1, dc);
drawlhv(x(15), y(6), x(16), y(6), 0, dc);
drawlhv(x(15), y(8), x(16), y(8), 0, dc);
drawlhv(x(1), y(6), x(20), y(13), 1, dc);
drawlhv(x(20), y(7), x(20), y(13), 0, dc);
drawlhv(x(5), y(8), x(15), y(11), 1, dc);
drawlhv(x(15), y(8), x(15), y(11), 1, dc);  
drawtext(x(22), y(14), ' ',F, dc);
drawtext(x(1)-dx/4, y(14), ' ',F, dc);
axis('equal')
axis('off')
