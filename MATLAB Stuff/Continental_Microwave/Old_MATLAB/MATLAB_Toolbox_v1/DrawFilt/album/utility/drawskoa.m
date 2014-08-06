function dr = drawskoa(x0 ,y0 ,dx ,ds ,F , dc, R)
   
% drawskoa.m  DRAW BIQUAD SALLEN-KEY (for drawsk2b.m)
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
% call    drawskoa( 0,0,4,5,8,'b',['1','2','1','2','1','2','3','4']');
%                                                                
      
Nx = 7;
Ny = 5;
whitebg(figure(gcf),[1 1 1]);
if exist('dc') == 0
  dc = 'k';
end
if exist('dc') == 0
  R = ['1','2','1','2','1','2','3','4']';
end
x = zeros(1,4*Nx);
y = zeros(1,4*Ny);
for indx = 1:4*Nx
 x(indx) = x0 + dx*indx/4;
end
for indy = 1:4*Ny
 y(indy) = y0 + dx*indy/4;
end
   
% drawtext(x(6), y(9), 'Sallen-Key biquad',F+1,dc)
drawopam(x(11), y(5), x(15), ' ', ['A' R(5)], 0, ds, F, dc);
drawres(x(2), y(6), x(6), ' ', ['R' R(1)], 0, ds/2, F, dc);
drawres(x(6), y(6), x(10), ' ', ['R' R(2)],  0, ds/2, F, dc);
drawcap(x(10), y(2), y(6), ' ', ['C' R(4)],  1, ds/2, F, dc);
drawcap(x(6), y(8), x(15), ' ', ['C' R(3)],  0, ds/2, F, dc);
drawnode(x(6), y(6), ['V' R(6)], 6, 1, F, dc);
drawnode(x(10), y(6), ['V' R(7)], 2, 1, F, dc);
drawnode(x(15), y(5), ['V' R(8)], 7, 1, F, dc);
drawgrnd(x(10), y(2), 0, ds/2, dc);
drawlhv(x(11), y(4), x(15), y(2), 1, dc);
drawlhv(x(10), y(6), x(11), y(6), 0, dc);
drawlhv(x(6), y(6), x(6), y(8), 0, dc);
drawlhv(x(15), y(5), x(15), y(8), 0, dc);
drawlhv(x(15), y(5), x(15), y(2), 0, dc);
axis('equal')
axis('off')
