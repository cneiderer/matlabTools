function drotac = drawotac(x0,y0,dx,ds,F); 
   
% drawotac.m  DRAW FOUR OTA NOTCH BIQUAD
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
% call   drawotac(0,0,4,5,10)                           
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
drawota(x(3), y(7), x(7), ' ', 'gm1', 1, ds, F, dc);
drawota(x(7), y(8), x(11), ' ', 'gm2', 0, ds, F, dc);
drawota(x(12), y(7), x(16), ' ', 'gm3', 1, ds, F, dc);
drawota(x(18), y(6), x(22), ' ','gm4', 1, ds, F, dc);
drawin(x(3), y(6), 'V1', 2, ds, F, dc);
drawcap(x(16), y(3), y(7), ' ', 'C1', 3, ds/2, F, dc);
drawcap(x(22), y(2), y(6), ' ','C2', 3, ds/2, F, dc);
drawnode(x(7), y(7), ' ', 2, 1, F, dc);
drawnode(x(11), y(8), 'V2', 1, 1, F, dc);
drawnode(x(16), y(7), 'V3', 1, 1, F, dc);
drawnode(x(22), y(6), 'V4', 0, 1, F, dc);
drawnode(x(3), y(6), ' ', 0, 1, F, dc);
drawnode(x(12), y(1), ' ', 0, 1, F, dc);
drawgrnd(x(16), y(3), 0, ds/2, dc);
drawgrnd(x(22), y(2), 0, ds/2, dc);
drawlhv(x(3), y(8), x(22), y(13), 1, dc);
drawlhv(x(22), y(13), x(22), y(6), 1, dc);
drawlhv(x(7), y(9), x(16), y(12), 1, dc);
drawlhv(x(16), y(12), x(16), y(7), 0, dc);
drawlhv(x(7), y(7), x(11), y(6), 1, dc);
drawlhv(x(11), y(6), x(11), y(8), 0, dc);
drawlhv(x(11), y(8), x(12), y(8), 1, dc);
drawlhv(x(12), y(6), x(12), y(1), 1, dc);
drawlhv(x(3), y(6), x(12), y(1), 1, dc);
drawlhv(x(12), y(1), x(18), y(5), 0, dc);
drawlhv(x(16), y(7), x(18), y(7), 1, dc); 
drawtext(x(10), y(15),'Four-OTA notch biquad', F+1, dc);                      
drawtext(x(24), y(15),' ', F, dc);                      
drawtext(x(1), y(15),' ', F, dc);                      
axis('equal')
axis('off')
