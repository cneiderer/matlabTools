function drotaf = drawotaf(x0,y0,dx,ds,F);
   
% drawotaf.m  DRAW FOUR ELEMENT UNIVERSAL OTA-C BIQUAD
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
% call   drawotaf(0,0,4,5,10)                           
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
drawota(x(3), y(8), x(7), ' ', 'gm1', 1, ds, F, dc);
drawota(x(11), y(7), x(15), ' ', 'gm2', 0, ds, F, dc);
drawin(x(3), y(7), 'Va', 2, ds, F, dc);
drawin(x(9), y(4), 'Vb', 2, ds, F, dc);
drawin(x(15), y(1), 'Vc', 2, ds, F, dc);
drawcap(x(9), y(4), y(8), ' ', 'C1', 1, ds/2, F, dc);
drawcap(x(15), y(1), y(5), ' ','C2', 3, ds/2, F, dc);
drawnode(x(9), y(8), 'V2', 2, 1, F, dc);
drawnode(x(15), y(7), 'V3', 0, 1, F, dc);
drawnode(x(15), y(5), ' ', 3, 1, F, dc);
drawlhv(x(3), y(9), x(15), y(12), 1, dc);
drawlhv(x(15), y(12), x(15), y(7), 1, dc);
drawlhv(x(11), y(6), x(15), y(5), 1, dc);
drawlhv(x(15), y(5), x(15), y(7), 1, dc);
drawlhv(x(7), y(8), x(9), y(8), 1, dc); 
drawlhv(x(11), y(8), x(9), y(8), 1, dc); 
drawtext(x(8), y(16),'Universal OTA-C biquad', F+1, dc); 
axis('equal')
axis('off')
