function drhpmq = drawhpmq(x0,y0,dx,ds,F);
   
% drawhpmq.m  DRAW HIGHPASS MEDIUM-Q-FACTOR OP AMP RC BIQUAD
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
% call   drawhpmq(0,0,4,5,10)                           
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
   
drawtext(x(3), y(11), 'HP-MQ',F+2, dc);
drawopam(x(12), y(8), x(16), ' ', 'A', 0, ds, F, dc);
drawin(x(3), y(9), 'V1', 2, ds, F, dc);
drawcap(x(3), y(9), x(7), ' ', 'C11', 0, ds/2, F, dc);
drawcap(x(7), y(4), y(9), ' ', 'C12', 1, ds/2, F, dc);
drawcap(x(7), y(9), x(11), ' ', 'C3',  0, ds/2, F, dc);
drawres(x(11), y(4), y(9), ' ', 'R4',  1, ds/2, F, dc);
drawres(x(7), y(11), x(16), ' ', 'R2',  0, ds/2, F, dc);
drawres(x(16), y(5), y(8), ' ', 'R6',  1, ds/2, F, dc);
drawres(x(16), y(3), y(5), ' ', 'R5',  1, ds/2, F, dc);
drawnode(x(7), y(9), 'V2', 3, 1, F, dc);
drawnode(x(11), y(9), 'V3', 2, 1, F, dc);
drawnode(x(16), y(8), 'V4', 0, 1, F, dc);
drawnode(x(16), y(5), 'V5', 0, 1, F, dc);
drawgrnd(x(7), y(4), 0, ds/2, dc);
drawgrnd(x(11), y(4), 0, ds/2, dc);
drawgrnd(x(16), y(3), 0, ds/2, dc);
drawlhv(x(12), y(7), x(16), y(5),1, dc)
drawlhv(x(11), y(9), x(12), y(9), 0, dc);
drawlhv(x(7), y(9), x(7), y(11), 0, dc);
drawlhv(x(16), y(8), x(16), y(11), 0, dc);
drawtext(x(1), y(11), ' ',F, dc);
drawtext(x(18), y(11), ' ',F, dc);
axis('equal')
axis('off')
