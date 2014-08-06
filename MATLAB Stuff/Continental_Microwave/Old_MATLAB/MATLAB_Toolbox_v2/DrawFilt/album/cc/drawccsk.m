function drccsk = drawccsk(x0,y0,dx,ds,F);
   
% drawccsk.m  DRAW CC SALLEN-KEY BIQUAD
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
% call   drawccsk(0,0,4,5,10)                           
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
   
drawtext(x(6), y(12), 'CC Sallen-Key biquad',F+1, dc);
drawcc(x(11), y(6), x(15), ' ', 'a=1', 3, ds, F, dc)
drawcs(x(17), y(2), y(7), ' ', 'Ig', 1, ds/2, F, dc);
drawres(x(3), y(6), x(7), ' ', 'R1', 0, ds/2, F, dc);
drawres(x(7), y(6), x(11), ' ', 'R3', 0, ds/2, F, dc);
drawcap(x(11), y(2), y(6), ' ', 'C4', 1, ds/2, F, dc);
drawcap(x(7), y(10), x(15), ' ', 'C2', 0, ds/2, F, dc);
drawnode(x(7), y(6), 'V2', 3, 1, F, dc);
drawnode(x(11), y(6), 'V3', 2, 1, F, dc);
drawnode(x(15), y(7), 'Vo', 1, 1, F, dc);
drawgrnd(x(3), y(2), 0, ds/2, dc);
drawgrnd(x(11), y(2), 0, ds/2, dc);
drawgrnd(x(17), y(2), 0, ds/2, dc);
drawgrnd(x(15), y(5), 0, ds/2, dc);
drawlhv(x(3), y(6), x(3), y(2), 1, dc);
drawlhv(x(7), y(6), x(7), y(10), 0, dc);
drawlhv(x(15), y(7), x(15), y(10), 0, dc);
drawlhv(x(15), y(7), x(17), y(7), 0, dc);
drawarrw(x(3), y(4),'Io',3,2,F,dc)
axis('equal')
axis('off')
