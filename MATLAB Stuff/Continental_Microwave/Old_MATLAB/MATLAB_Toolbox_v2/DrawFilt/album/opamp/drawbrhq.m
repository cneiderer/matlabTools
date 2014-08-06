function dr = drawbrhq(x0,y0,dx,ds,F)                  
% drawbrhq.m      DRAW BANDREJECT HIGH-Q-FACTOR OP AMP RC BIQUAD                    
% Filter realization generated from the drawing window of the toolbox   
%                                                               
%                 Drawing Filter Realizations                   
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
% call   drawbrhq(0,0,4,5,10)                           
% creation date: 17-Sep-0  time: 20:23
    
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
drawtext(x(5), y(13), 'BR-HQ',F+2, dc);                      
drawopam(x(5), y(7), x(10), ' ', 'A1', 0, ds, F, dc);
drawopam(x(19), y(7), x(24), ' ', 'A2', 0, ds, F, dc);
drawin(x(14), y(2), 'V1', 3, ds, F, dc);
drawres(x(1), y(8), x(5), ' ', 'R1', 0, ds/2, F, dc);
drawcap(x(10), y(8), x(14), ' ', 'C3', 0, ds/2, F, dc);
drawres(x(10), y(6), x(14), ' ', 'R4', 2, ds/2, F, dc);
drawres(x(5), y(2), y(6), ' ', 'R5',  3, ds/2, F, dc);
drawres(x(19), y(2), y(6), ' ', 'R8',  3, ds/2, F, dc);
drawres(x(17), y(2), y(6), ' ', 'R7',  1, ds/2, F, dc);
drawres(x(1), y(6), x(5), ' ', 'R2',  0, ds/2, F, dc);
drawcap(x(14), y(2), y(6), ' ', 'C7',  1, ds/2, F, dc);
drawnode(x(14), y(2), '', 2, 1, F, dc);
drawnode(x(14), y(6), 'V6', 2, 1, F, dc);
drawnode(x(5), y(6), 'V2', 2, 1, F, dc);
drawnode(x(14), y(8), 'V3', 1, 1, F, dc);
drawnode(x(24), y(7), 'V4', 0, 1, F, dc);
drawnode(x(5), y(8), '', 0, 1, F, dc);
drawnode(x(1), y(8), '', 0, 1, F, dc);
drawnode(x(19), y(6), '', 0, 1, F, dc);
drawnode(x(10), y(7), 'V5', 0, 1, F, dc);
drawgrnd(x(19), y(2), 0, ds/2, dc);
drawlhv(x(5), y(2), x(14), y(2), 1, dc);
drawlhv(x(14), y(2), x(17), y(2), 1, dc);
drawlhv(x(10), y(6), x(10), y(8), 1, dc);
drawlhv(x(14), y(6), x(19), y(6), 0, dc);
drawlhv(x(14), y(8), x(19), y(8), 0, dc);
drawlhv(x(1), y(6), x(24), y(12), 1, dc);
drawlhv(x(24), y(7), x(24), y(12), 0, dc);
drawlhv(x(5), y(8), x(14), y(11), 1, dc);
drawlhv(x(14), y(8), x(14), y(11), 1, dc);  
drawnode(x(17), y(6),'', 1, 1, F, dc);                       
drawtext(x(1)-dx/4, y(13), ' ',F, dc);
drawtext(x(26), y(13), ' ',F, dc);
axis('equal')
axis('off')
