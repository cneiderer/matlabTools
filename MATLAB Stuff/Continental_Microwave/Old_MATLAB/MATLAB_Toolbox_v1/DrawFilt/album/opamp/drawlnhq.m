function drlnhq = drawlnhq(x0,y0,dx,ds,F);
    
% drawlnhq.m  DRAW LOWPASS NOTCH HIGH-Q-FACTOR OP AMP RC BIQUAD
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
% call   drawlnhq(0,0,4,5,10)                           
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
   
drawtext(x(7), y(11), 'LPN-HQ',F+2, dc);
drawopam(x(7), y(6), x(10), '', 'A1', 0, ds, F, dc);
drawopam(x(16), y(6), x(20), '', 'A2', 0, ds, F, dc);
drawin(x(7), y(2), 'V1', 2, ds, F, dc);
drawres(x(4), y(7), x(7), '', 'R1', 0, ds/2, F, dc);
drawres(x(10), y(7), x(13), '', 'R3', 0, ds/2, F, dc);
drawres(x(10), y(5), x(13), '', 'R4', 2, ds/2, F, dc);
drawres(x(7), y(2), y(5), '', 'R5',  3, ds/2, F, dc);
drawcap(x(4), y(5), x(7), '', 'C2',  0, ds/2, F, dc);
drawres(x(16), y(2), y(5), '', 'R8',  3, ds/2, F, dc);
drawcap(x(13), y(2), y(5), '', 'C7',  3, ds/2, F, dc);
drawnode(x(13), y(5), 'V6', 2, 1, F, dc);
drawnode(x(7), y(5), 'V2', 2, 1, F, dc);
drawnode(x(13), y(7), 'V3', 1, 1, F, dc);
drawnode(x(20), y(6), 'V4', 0, 1, F, dc);
drawnode(x(16), y(5), '', 0, 1, F, dc);
drawnode(x(7), y(7), '', 0, 1, F, dc);
drawnode(x(4), y(7), '', 0, 1, F, dc);
drawnode(x(7), y(2), '', 0, 1, F, dc);
drawnode(x(10), y(6), 'V5', 0, 1, F, dc);
drawgrnd(x(16), y(2), 0, ds/2, dc);
drawlhv(x(10), y(5), x(10), y(7), 1, dc);
drawlhv(x(13), y(5), x(16), y(5), 0, dc);
drawlhv(x(13), y(7), x(16), y(7), 0, dc);
drawlhv(x(4), y(5), x(20), y(10), 1, dc);
drawlhv(x(7), y(2), x(13), y(2), 0, dc);
drawlhv(x(20), y(6), x(20), y(10), 0, dc);
drawlhv(x(7), y(7), x(13), y(9), 1, dc);
drawlhv(x(13), y(7), x(13), y(9), 1, dc);  
drawtext(x(2), y(11), ' ',F, dc);
drawtext(x(22), y(11), ' ',F, dc);
axis('equal')
axis('off')
