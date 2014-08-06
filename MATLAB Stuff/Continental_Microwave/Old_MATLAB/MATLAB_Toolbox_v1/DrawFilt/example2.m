function dr = example2(x0,y0,dx,ds,F)                  
     
% example2.m   EXAMPLE 2: DRAW CASCADE REALIZATION - DIRECT-FORM II BIQUAD
%   
%  Filter realization generated from the drawing window of the toolbox   
%                                                               
%                 Drawing Filter Realizations                   
%                                                               
%   Authors: Miroslav D. Lutovac, Dejan V. Tosic, 1999/02/21    
%   Email: lutovac@iritel.bg.ac.yu      http://galeb.etf.bg.ac.yu/~lutovac/
%   Email: tosic@galeb.etf.bg.ac.yu     http://www.rcub.bg.ac.yu/~tosicde/
%   Copyright (c) 1999-2000 by Lutovac & Tosic                   
%   $Revision: 1.21 $  $Date: 2000/10/03 13:45$
%                                                                
%   See also:                                                    
%   Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans          
%        Filter Design for Signal Processing                     
%           Using MATLAB and Mathematica                         
%        Prentice Hall - ISBN 0-201-36130-2                      
%         http://www.prenhall.com/lutovac                        
%                                                                
%                                                                
% call   example2(0,0,4,5,10)                           
% creation date: 18-Sep-0  time: 15:31
Nx = 7;
Ny = 5;
whitebg(figure(gcf),[1 1 1]);
dc = 'b';
x = zeros(1,4*Nx);
y = zeros(1,4*Ny);
for indx = 1:4*Nx
 x(indx) = x0 + dx*indx/4;
end
for indy = 1:4*Ny
 y(indy) = y0 + dx*indy/4;
end
drawtext(x(6), y(19),'Cascade Realization', F+1, dc);        
drawtext(x(6), y(18),'Direct-form II biquad', F+1, dc);      
drawadd(x(2),y(16),2,0,1,1,'',1,ds/3,F,dc);                  
drawadd(x(2),y(12),1,2,0,1,'',1,ds/3,F,dc);                  
drawmult(x(4),y(12),x(7),'','a1',6,ds/3,F,dc);               
drawdel(x(7), y(12), y(16), ' ', '-1' ,11, ds/2, F, dc);     
drawdel(x(7),y(8),y(12),'','-1',11,ds/2,F,dc);               
drawmult(x(4),y(8),x(7),'','a2',6,ds/3,F,dc);                
drawlhv(x(4), y(8),  x(3),  y(11), 0, dc);                   
drawline(x(3), y(13), x(3), y(15), dc);                      
drawadd(x(10),y(12),0,2,1,1,'',1,ds/3,F,dc);                 
drawmult(x(7),y(12),x(10),'','b1',0,ds/3,F,dc);              
drawmult(x(7),y(8),x(10),'','b2',0,ds/3,F,dc);               
drawlhv(x(10), y(8),  x(11),  y(11), 0, dc);                 
drawadd(x(10),y(16),2,0,1,1,'',1,ds/3,F,dc);                 
drawline(x(11), y(13), x(11), y(15), dc);                    
drawline(x(4), y(16), x(7), y(16), dc);                      
drawline(x(7), y(16), x(10), y(16), dc);                     
drawin(x(2), y(16), 'In', 2, ds, F, dc);                     
drawnode(x(7), y(8), ' ', 1, 1, F, dc);                      
drawnode(x(7), y(12), ' ', 1, 1, F, dc);                     
drawnode(x(7), y(16), ' ', 1, 1, F, dc);                     
drawadd(x(12),y(16),2,0,1,1,'',1,ds/3,F,dc);                 
drawadd(x(12),y(12),1,2,0,1,'',1,ds/3,F,dc);                 
drawmult(x(14),y(12),x(17),'','c1',6,ds/3,F,dc);             
drawdel(x(17), y(12), y(16), ' ', '-1' ,11, ds/2, F, dc);    
drawdel(x(17),y(8),y(12),'','-1',11,ds/2,F,dc);              
drawmult(x(14),y(8),x(17),'','c2',6,ds/3,F,dc);              
drawlhv(x(14), y(8),  x(13),  y(11), 0, dc);                 
drawline(x(13), y(13), x(13), y(15), dc);                    
drawadd(x(20),y(12),0,2,1,1,'',1,ds/3,F,dc);                 
drawmult(x(17),y(12),x(20),'','d1',0,ds/3,F,dc);             
drawmult(x(17),y(8),x(20),'','d2',0,ds/3,F,dc);              
drawlhv(x(20), y(8),  x(21),  y(11), 0, dc);                 
drawadd(x(20),y(16),2,0,1,1,'',1,ds/3,F,dc);                 
drawline(x(21), y(13), x(21), y(15), dc);                    
drawline(x(14), y(16), x(17), y(16), dc);                    
drawline(x(17), y(16), x(20), y(16), dc);                    
drawout(x(22), y(16), 'Out', 0, ds, F, dc);                  
drawnode(x(17), y(8), ' ', 1, 1, F, dc);                     
drawnode(x(17), y(12), ' ', 1, 1, F, dc);                    
drawnode(x(17), y(16), ' ', 1, 1, F, dc);                    
axis('equal')
axis('off')
