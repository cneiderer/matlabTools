function dr = drawap2c(x0,y0,dx,ds,F)                  
% drawap2c.m  ANSARI-LIU DIGITAL FILTER REALIZATION -- BIQUAD TYPE C
% drawap2c.m  Filter realization                        
%            generated from the drawing window of the toolbox   
%                                                               
%                 Drawing Filter Realizations                   
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
% call   drawap2c(0,0,4,5,10)                           
% creation date: 19-Sep-0  time: 13:19
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
drawtext(x(7),y(16),'Ansari-Liu allpass biquad',F,dc);
drawtext(x(7),y(15),'type C',F,dc);
drawin(x(5), y(13),'X',2,ds/2,F, dc);                        
drawout(x(12), y(12),'Y',0,ds/2,F, dc);
drawadd(x(5), y(13), 2, 0, 3, 1,'S1',2,ds/3,F, dc);
drawadd(x(10), y(12), 2, 1, 0, 1,'S2',4,ds/3,F, dc);
drawadd(x(5), y(10), 0, 1, 1, 2,'S3',0,ds/3,F, dc);
drawadd(x(2), y(5), 2, 1, 0, 3,'S4',3,ds/3,F, dc);
drawadd(x(12), y(5), 0, 2, 1, 1,'S5',1,ds/3,F, dc);
drawmult(x(7), y(13), x(11),'-a','A1', 0,0.9*ds/2,F, dc);
drawmult(x(8), y(2), y(5),'b','A2', 3,0.9*ds/2,F, dc);
drawdel(x(4), y(5), x(8),'D1','-1', 8,ds/2,F, dc);
drawdel(x(8), y(5), x(12),'D2','-1', 0,ds/2,F, dc);
drawlhv(x(8), y(2),  x(3),  y(4), 0, dc);                    
drawlhv(x(8), y(2),  x(13),  y(4), 0, dc);                   
drawline(x(5), y(10), x(5), y(13), dc);                      
drawline(x(6), y(11), x(11), y(13), dc);                     
drawline(x(6), y(12), x(11), y(11), dc);                     
drawnode(x(5), y(13) ,'1',2,1,F, dc);
drawnode(x(7), y(13),'2',2,1,F, dc);
drawnode(x(11), y(13),'3',2,1,F, dc);
drawnode(x(12), y(12),'4',2,1,F, dc);
drawnode(x(11), y(11),'5',6,1,F, dc);
drawnode(x(6), y(9),'6',0,1,F, dc);
drawnode(x(4), y(5),'7',2,1,F, dc);
drawnode(x(8), y(5),'8',2,1,F, dc);
drawnode(x(12), y(5),'9',2,1,F, dc);
drawnode(x(8), y(2),'10',3,1,F, dc);  
drawlvh(x(3), y(6),  x(6),  y(9), 0, dc);                    
drawlvh(x(13), y(6),  x(11),  y(11), 0, dc);                 
drawtext(x(24), y(15),' ', F, dc);                      
drawtext(x(1), y(15),' ', F, dc);                      
axis('equal')
axis('off')
