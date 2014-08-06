function dr = drawap2b(x0,y0,dx,ds,F)                  
% drawap2b.m  ANSARI-LIU DIGITAL FILTER REALIZATION -- BIQUAD TYPE B
% drawap2b.m  Filter realization                        
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
% call   drawap2b(0,0,4,5,10)                           
% creation date: 19-Sep-0  time: 12:48
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
drawtext(x(7),y(15),'type B',F,dc);
drawin(x(3), y(13),'X',2,ds/2,F, dc);                        
drawout(x(10), y(12),'Y',0,ds/2,F, dc);
drawadd(x(3), y(13), 2, 0, 3, 1,'S1',2,ds/3,F, dc);
drawadd(x(8), y(12), 2, 1, 0, 1,'S2',4,ds/3,F, dc);
drawadd(x(3), y(10), 0, 1, 1, 2,'S3',0,ds/3,F, dc);
drawadd(x(3), y(5), 2, 0, 1, 1,'S4',5,ds/3,F, dc);
drawadd(x(8), y(4), 2, 3, 0, 1,'S5',4,ds/3,F, dc);
drawadd(x(3), y(2), 2, 1, 1, 0,'S6',5,ds/3,F, dc);
drawmult(x(5), y(13), x(9),'-a','A1', 0,0.9*ds/2,F, dc);
drawmult(x(5), y(5), x(9),'-b','A2', 0,0.9*ds/2,F, dc);
drawdel(x(3), y(5), y(9),'D1','-1', 5,ds/2,F, dc);
drawdel(x(5), y(2), x(9),'D2','-1', 14,ds/2,F, dc);
drawline(x(4), y(3), x(9), y(5), dc);                        
drawline(x(4), y(4), x(9), y(3), dc);                        
drawline(x(9), y(2), x(9), y(3), dc);                        
drawline(x(3), y(2), x(3), y(5), dc);                        
drawline(x(3), y(9), x(4), y(9), dc);                        
drawline(x(3), y(10), x(3), y(13), dc);                      
drawline(x(4), y(11), x(9), y(13), dc);                      
drawline(x(4), y(12), x(9), y(11), dc);                      
drawlvh(x(10), y(4),  x(9),  y(11), 0, dc);                  
drawnode(x(3), y(13),'1',2,1,F, dc);
drawnode(x(5), y(13),'2',2,1,F, dc);
drawnode(x(9), y(13),'3',2,1,F, dc);
drawnode(x(10), y(12),'4',2,1,F, dc);
drawnode(x(9), y(11),'5',6,1,F, dc);
drawnode(x(4), y(9),'6',0,1,F, dc);
drawnode(x(3), y(5),'7',4,1,F, dc);
drawnode(x(5), y(5),'8',2,1,F, dc);
drawnode(x(9), y(5),'9',2,1,F, dc);
drawnode(x(9), y(3),'10',0,1,F, dc);
drawnode(x(5), y(2),'11',2,1,F, dc);  
drawtext(x(24), y(15),' ', F, dc);                      
drawtext(x(1), y(15),' ', F, dc);                      
axis('equal')
axis('off')
