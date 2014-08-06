function drotad = drawotad(x0,y0,dx,ds,F); 
   
% drawotad.m  DRAW FIVE OTA UNIVERSAL BIQUAD
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
% call   drawotad(0,0,4,5,10)                           
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
drawota(x(3), y(12), x(7), ' ', 'gm1', 1, ds, F, dc);
drawota(x(3), y(7), x(7), ' ', 'gm5', 0, ds, F, dc);
drawota(x(12), y(11), x(16), ' ', 'gm2', 0, ds, F, dc);
drawota(x(16), y(10), x(20), ' ','gm3', 1, ds, F, dc);
drawota(x(16), y(5), x(20), ' ','gm4', 0, ds, F, dc);
drawin(x(3), y(8), 'Va', 2, ds, F, dc);
drawin(x(16), y(6), 'Vb', 2, ds, F, dc);
drawin(x(22), y(6), 'Vc', 3, ds, F, dc);
drawcap(x(10), y(6), y(12), ' ', 'C1', 1, ds/2, F, dc);
drawcap(x(22), y(6), y(10), ' ','C2', 3, ds/2, F, dc);
drawnode(x(7), y(12), ' ', 2, 1, F, dc);
drawnode(x(10), y(12), 'V1', 2, 1, F, dc);
drawnode(x(16), y(11), 'V2', 3, 1, F, dc);
drawnode(x(22), y(10), 'V3', 0, 1, F, dc);
drawnode(x(20), y(10), ' ', 0, 1, F, dc);
drawnode(x(16), y(16), ' ', 0, 1, F, dc);
drawgrnd(x(10), y(6), 0, ds/2, dc);
drawgrnd(x(3), y(11), 0, ds/2, dc);
drawgrnd(x(3), y(6), 0, ds/2, dc);
drawgrnd(x(12), y(10), 0, ds/2, dc);
drawgrnd(x(16), y(9), 0, ds/2, dc);
drawgrnd(x(16), y(4), 0, ds/2, dc);
drawlhv(x(7), y(12), x(7), y(7), 1, dc);
drawlhv(x(7), y(12), x(10), y(12), 1, dc);
drawlhv(x(12), y(12), x(10), y(12), 1, dc);
drawlhv(x(20), y(5), x(20), y(10), 1, dc);
drawlhv(x(20), y(10), x(22), y(10), 1, dc);
drawlhv(x(3), y(13), x(16), y(16), 1, dc);
drawlhv(x(16), y(16), x(22), y(10), 0, dc);
drawlhv(x(16), y(16), x(16), y(11), 1, dc);
drawtext(x(10), y(18),'Five-OTA universal biquad', F+1, dc);                      
drawtext(x(24), y(18),' ', F, dc);                      
drawtext(x(1), y(18),' ', F, dc);                      
axis('equal')
axis('off')
