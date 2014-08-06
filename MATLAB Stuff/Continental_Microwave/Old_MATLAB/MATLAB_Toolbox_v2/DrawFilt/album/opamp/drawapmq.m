function drapmq = drawapmq(x0,y0,dx,ds,F, dc);
   
% drawapmq.m  DRAW ALLPASS MEDIUM-Q-FACTOR OP AMP RC BIQUAD
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
% call   drawapmq(0,0,4,5,10)                           
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
drawtext(x(3), y(14), 'AP-MQ',F+2, dc);
drawopam(x(11), y(11), x(15), ' ', 'A', 1, ds, F, dc);
drawin(x(3), y(12), 'V1', 2, ds, F, dc);
drawres(x(3), y(12), x(11), ' ', 'R6', 0, ds/2, F, dc);
drawres(x(3), y(10), x(11), ' ', 'R1', 0, ds/2, F, dc);
drawcap(x(3), y(8), x(7), ' ', 'C2',  2, ds/2, F, dc);
drawcap(x(7), y(8), x(11), ' ', 'C3',  2, ds/2, F, dc);
drawres(x(11), y(14), x(15), ' ', 'R7',  0, ds/2, F, dc);
drawres(x(15), y(6), y(11), ' ', 'R5',  1, ds/2, F, dc);
drawres(x(7), y(2), y(6), ' ', 'R4',  1, ds/2, F, dc);
drawnode(x(11), y(12), 'V3', 6, 1, F, dc);
drawnode(x(15), y(11), 'V4', 0, 1, F, dc);
drawnode(x(7), y(6), 'V2', 4, 1, F, dc);
drawnode(x(11), y(10), 'V5', 2, 1, F, dc);
drawnode(x(7), y(8), '', 2, 1, F, dc);
drawnode(x(3), y(10), '', 2, 1, F, dc);
drawnode(x(3), y(12), '', 2, 1, F, dc);
drawgrnd(x(7), y(2), 0, ds/2, dc);
drawlhv(x(11), y(12), x(11), y(12),0, dc);
drawlhv(x(7), y(8), x(15), y(6),1, dc);
drawlhv(x(11), y(12), x(11), y(14),0, dc);
drawlhv(x(15), y(14), x(15), y(11),0, dc);
drawlhv(x(3), y(8), x(3), y(12),0, dc);
drawlhv(x(11), y(8), x(11), y(10),0, dc);
axis('equal')
axis('off')
