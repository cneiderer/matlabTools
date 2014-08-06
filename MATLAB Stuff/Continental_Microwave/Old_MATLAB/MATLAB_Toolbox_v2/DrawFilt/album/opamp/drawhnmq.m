function drhnmq = drawhnmq(x0,y0,dx,ds,F);
   
% drawhnmq.m  DRAW HIGHPASS NOTCH MEDIUM-Q-FACTOR OP AMP RC BIQUAD
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
% call   drawhnmq(0,0,4,5,10)                           
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
    
drawtext(x(4), y(14), 'HPN-MQ',F+2, dc);
drawopam(x(12), y(9), x(16), ' ', 'A', 1, ds, F, dc);
drawin(x(3), y(10), 'V1', 2, ds, F, dc);
drawres(x(3), y(10), x(7), ' ', 'R1', 0, ds/2, F, dc);
drawres(x(8),y(5), x(12), ' ', 'R7', 2, ds/2, F, dc);
drawres(x(12), y(5), x(16), ' ', 'R9', 0, ds/2, F, dc);
drawres(x(12), y(2), y(5), ' ', 'R8', 3, ds/2, F, dc);
drawcap(x(7), y(10), x(11), ' ', 'C4',  0, ds/2, F, dc);
drawres(x(11), y(10), y(14), ' ', 'R5',  3, ds/2, F, dc);
drawres(x(11), y(7), y(10), ' ', 'R6',  1, ds/2, F, dc);
drawres(x(7), y(7), y(10), ' ', 'R2',  1, ds/2, F, dc);
drawcap(x(7), y(14), x(11), ' ', 'C3',  0, ds/2, F, dc);
drawnode(x(7), y(10), 'V2', 3, 1, F, dc);
drawnode(x(11), y(10), 'V3', 1, 1, F, dc);
drawnode(x(16), y(9), 'V4', 0, 1, F, dc);
drawnode(x(12), y(5), 'V5', 1, 1, F, dc);
drawnode(x(8),y(5), '', 0, 1, F, dc);
drawnode(x(11), y(14), '', 0, 1, F, dc);
drawnode(x(4),y(10), '', 0, 1, F, dc);
drawgrnd(x(12), y(2), 0,   ds/2, dc);
drawgrnd(x(7), y(7), 0,   ds/2, dc);
drawlhv(x(8),y(5), x(11), y(7),1, dc);
drawlhv(x(16), y(5), x(16), y(9),1, dc);
drawlhv(x(12), y(5), x(12), y(8),1, dc);
drawlhv(x(4),y(10), x(8),y(5),1, dc);
drawlhv(x(11), y(10), x(12), y(10),0, dc);
drawlhv(x(7), y(10), x(7), y(14),0, dc);
drawlhv(x(11), y(14), x(16), y(9),0, dc);
axis('equal')
axis('off')
