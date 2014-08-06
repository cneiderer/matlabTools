function draphq = drawaphq(x0,y0,dx,ds,F);
            
% drawaphq.m  DRAW ALLPASS HIGH-Q-FACTOR OP AMP RC BIQUAD
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
% call   drawaphq(0,0,4,5,10)                           
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
drawopam(x(5), y(6), x(8), ' ', 'A1', 0, ds, F, dc);
drawopam(x(13), y(6), x(16), ' ', 'A2', 0, ds, F, dc);
drawin(x(11), y(2), 'V1', 3, ds, F, dc);
drawres(x(2), y(7), x(5), ' ', 'R1', 0, ds/2, F, dc);
drawcap(x(8), y(7), x(11), ' ', 'C3', 0, ds/2, F, dc);
drawres(x(8), y(5), x(11), ' ', 'R4', 2, ds/2, F, dc);
drawres(x(5), y(2), y(5), ' ', 'R5',  3, ds/2, F, dc);
drawres(x(13), y(2), y(5), ' ', 'R8',  3, ds/2, F, dc);
drawres(x(2), y(5), x(5), ' ', 'R2',  0, ds/2, F, dc);
drawcap(x(11), y(2), y(5), ' ', 'C7',  3, ds/2, F, dc);
drawnode(x(11), y(5), 'V6', 2, 1, F, dc);
drawnode(x(5), y(5), 'V2', 2, 1, F, dc);
drawnode(x(11), y(7), 'V3', 1, 1, F, dc);
drawnode(x(16), y(6), 'V4', 0, 1, F, dc);
drawnode(x(5), y(7), '', 0, 1, F, dc);
drawnode(x(2), y(7), '', 0, 1, F, dc);
drawnode(x(13), y(5), '', 0, 1, F, dc);
drawnode(x(8), y(6), 'V5', 0, 1, F, dc);
drawnode(x(11), y(2), '', 0, 1, F, dc);
drawgrnd(x(13), y(2), 0, ds/2, dc);
drawlhv(x(5), y(2), x(11), y(2), 1, dc);
drawlhv(x(8), y(5), x(8), y(7), 1, dc);
drawlhv(x(11), y(5), x(13), y(5), 0, dc);
drawlhv(x(11), y(7), x(13), y(7), 0, dc);
drawlhv(x(2), y(5), x(16), y(11), 1, dc);
drawlhv(x(16), y(6), x(16), y(11), 0, dc);
drawlhv(x(5), y(7), x(11), y(10), 1, dc);
drawlhv(x(11), y(7), x(11), y(10), 1, dc);  
drawtext(x(5), y(12), 'AP-HQ',F+2, dc);
drawtext(x(1), y(12), ' ',F, dc);
drawtext(x(18), y(12), ' ',F, dc);
axis('equal')
axis('off')
