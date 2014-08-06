function dr = drawkhn(x0,y0,dx,ds,F);
   
% drawkhn.m  DRAW GENERAL-PURPOSE HIGH-Q-FACTOR OP AMP RC BIQUAD
%                       Kerwin-Huelsman-Newcomb OP AMP RC BIQUAD
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
%   [3] W. J. Kerwin, L. P. Huelsman, and R. W. Newcomb,
%       State-variable synthesis for insensitive
%       integrated circuit transfer functions,
%       IEEE J. Solid-State Circuits,
%       SC-2, pp. 87-92, September, 1967
%                                                                
% call   drawkhn(0,0,4,5,10)                           
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
   
drawtext(x(11), y(15), 'GP - HQ',F+2, dc);
drawtext(x(11),y(14),'Kerwin Huelsman Newcomb (KHN)',F,dc);
drawopam(x(6), y(7), x(9), ' ', 'A1', 1, ds, F, dc);
drawopam(x(12), y(6), x(15), ' ', 'A2', 1, ds, F, dc);
drawopam(x(18), y(5), x(21), ' ','A3', 1, ds, F, dc);
drawin(x(3), y(6), 'V1', 2, ds, F, dc);
drawres(x(6), y(10), x(9), ' ', 'R4', 0, ds/2, F, dc);
drawcap(x(12), y(9), x(15), ' ', 'C6', 0, ds/2, F, dc);
drawres(x(6), y(12), x(21), ' ','R3', 0, ds/2, F, dc);
drawres(x(9), y(7), x(12), ' ', 'R5', 0, ds/2, F, dc);
drawres(x(6), y(3), y(6), ' ', 'R2',  3, ds/2, F, dc);
drawres(x(15), y(6), x(18), ' ', 'R7',  0, ds/2, F, dc);
drawres(x(3), y(6), x(6), ' ', 'R1',  2, ds/2, F, dc);
drawcap(x(18), y(8), x(21), ' ','C8',  0, ds/2, F, dc);
drawnode(x(12), y(7), 'V6', 6, 1, F, dc);
drawnode(x(9), y(7), 'V2', 6, 1, F, dc);
drawnode(x(15), y(6), 'V3', 7, 1, F, dc);
drawnode(x(21),y(5), 'V4', 6, 1, F, dc);
drawnode(x(18), y(6), 'V7', 6, 1, F, dc);
drawnode(x(21),y(8), '', 0, 1, F, dc);
drawnode(x(6),y(6), 'V8', 3, 1, F, dc);
drawnode(x(6), y(10), 'V5', 4, 1, F, dc);
drawgrnd(x(12), y(5), 0, ds/2, dc);
drawgrnd(x(18), y(4), 0, ds/2, dc);
drawlhv(x(6), y(3), x(15), y(6), 0, dc);
drawlhv(x(12), y(7), x(12), y(9), 0, dc);
drawlhv(x(15), y(6), x(15), y(9), 0, dc);
drawlhv(x(18), y(6), x(18), y(8), 0, dc);
drawlhv(x(21),y(5), x(21),y(12), 0, dc);
drawlhv(x(6),y(8), x(6),y(12), 0, dc);
drawlhv(x(9),y(7), x(9),y(10), 0, dc);  
drawtext(x(1), y(10), ' ',F, dc);
drawtext(x(23), y(10), ' ',F, dc);
axis('equal')
axis('off')
