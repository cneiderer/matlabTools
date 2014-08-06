function dr = drawap1b(x0,y0,dx,ds,F)
   
% drawap1b.m  ANSARI-LIU DIGITAL FILTER FIRST-ORDER REALIZATION TYPE B
%   
%            Album of Digital Filter Realizations
%   
%   Authors: Miroslav D. Lutovac, Dejan V. Tosic, 1999/02/21    
%   Email: lutovac@iritel.bg.ac.yu      http://galeb.etf.bg.ac.yu/~lutovac/
%   Email: tosic@galeb.etf.bg.ac.yu     http://www.rcub.bg.ac.yu/~tosicde/
%   Copyright (c) 1999-2000 by Lutovac & Tosic                   
%   $Revision: 1.21 $  $Date: 2000/10/03 13:45$                  
%   
% References:
% [1] Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans
%     Filter Design for Signal Processing Using MATLAB and Mathematica
%     Prentice Hall - ISBN 0-201-36130-2
%     http://www.prenhall.com/lutovac
% [2] Ansari R., Liu B.,
%     A class of low-noise computationally efficient recursive
%     digital filters with applications to sampling rate alterations,
%     IEEE Trans. Acoust., Speech, Signal Process., ASSP-33, 1985
%   
% call   drawap1b(0,0,4,5,10)                           
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
   
drawtext(x(7),y(9),'Ansari-Liu allpass realization',F+1,dc);
drawtext(x(7),y(8),'first-order type B',F+1,dc);
drawin(x(3),y(6),'X',2,ds/2,F, dc) 
drawout(x(10),y(5),'Y',0,ds/2,F, dc) 
drawadd(x(3), y(6), 2, 0, 1, 1,'S1',2,ds/3,F, dc);
drawadd(x(8), y(5), 2, 3, 0, 1,'S2',4,ds/3,F, dc);
drawadd(x(3), y(3), 2, 1, 1, 0,'S3',6,ds/3,F, dc);
drawmult(x(5),y(6),x(9),'-a','A1', 0,0.9*ds/2,F, dc);
drawdel(x(5),y(3),x(9),'D1','-1', 14,ds/2,F, dc);
drawline(x(4),y(4),x(9),y(6),dc)
drawline(x(4),y(5),x(9),y(4),dc)
drawlhv(x(3),y(6),x(3),y(3), 0, dc)
drawlhv(x(9),y(3),x(9),y(4), 0, dc)
drawnode(x(3),y(6),'1',2,1,F, dc);
drawnode(x(5),y(6),'2',2,1,F, dc);
drawnode(x(9),y(6),'3',2,1,F, dc);
drawnode(x(10),y(5),'4',2,1,F, dc);
drawnode(x(9), y(4),'5',0,1,F, dc);
drawnode(x(5), y(3),'6',2,1,F, dc);     
drawtext(x(24), y(15),' ', F, dc);                      
drawtext(x(1), y(15),' ', F, dc);                      
axis('equal')
axis('off')
