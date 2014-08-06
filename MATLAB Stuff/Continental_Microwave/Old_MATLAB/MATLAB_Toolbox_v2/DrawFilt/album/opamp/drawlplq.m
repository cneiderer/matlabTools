function drlplq = drawlplq(x0,y0,dx,ds,F);
   
% drawlplq.m  DRAW LOWPASS LOW-Q-FACTOR OP AMP RC BIQUAD
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
% call   drawlplq(0,0,4,5,10)                           
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
   
drawres(x(3), y(7), x(7), ' ', 'R11', 0, ds/2, F, dc);
drawres(x(7), y(3), y(7), ' ', 'R12', 1, ds/2, F, dc);
drawres(x(7), y(7), x(11), ' ', 'R3',  0, ds/2, F, dc);
drawcap(x(11), y(3), y(7), ' ', 'C4',  1, ds/2, F, dc);
drawcap(x(7), y(9), x(16), ' ', 'C2',  0, ds/2, F, dc);
drawlhv(x(12), y(5), x(16), y(3), 1, dc);
drawlhv(x(11), y(7), x(12), y(7), 0, dc);
drawlhv(x(7), y(7), x(7), y(9), 0, dc);
drawlhv(x(16), y(6), x(16), y(9), 0, dc);
drawlhv(x(16), y(6), x(16), y(3), 0, dc);
drawgrnd(x(7), y(3), 0, ds/2, dc);
drawgrnd(x(11), y(3), 0, ds/2, dc);
drawnode(x(16), y(6), 'V4', 0, 1, F, dc);
drawnode(x(7), y(7), 'V2', 3, 1, F, dc);
drawnode(x(11), y(7), 'V3', 2, 1, F, dc);
drawopam(x(12), y(6), x(16), ' ', 'A', 0, ds, F, dc);
drawtext(x(3), y(9), 'LP-LQ',F+2, dc);
drawin(x(3), y(7), 'V1', 2, ds, F, dc);
drawtext(x(1), y(9), ' ',F, dc);
drawtext(x(18), y(9), ' ',F, dc);
axis('equal')
axis('off')
