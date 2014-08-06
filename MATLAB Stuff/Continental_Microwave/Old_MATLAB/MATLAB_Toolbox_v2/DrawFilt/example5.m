function dr = example5(x0,y0,dx,ds,F)                  
                                                               
%  example5.m  EXAMPLE 5: DRAW TRANSPOSE-DIRECT-FORM II BIQUAD
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
% call   example5(0,0,4,5,10);                           
% creation date: 20-Sep-0  time: 22:32
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
drawtext(x(8),y(18),'Transpose-Direct-Form II Biquad',F+1,dc);
drawmult(x(3),y(15),x(9),' ', 'b0', 0,ds/2,F,dc)             
drawmult(x(3),y(9), x(7),' ', 'b1', 0,ds/2,F,dc)
drawmult(x(3),y(3), x(7),' ', 'b2', 0,ds/2,F,dc)
drawmult(x(11),y(9), x(15),' ', 'a1', 6,ds/2,F,dc)
drawmult(x(9),y(3), x(15),' ', 'a2', 6,ds/2,F,dc)
drawadd(x(7),y(3), 1, 2, 1, 0,'S4',6,ds/3,F,dc)
drawadd(x(9),y(15), 2, 0, 1, 1,'S1',2,ds/3,F,dc)
drawadd(x(7),y(9), 2, 0, 1, 1,'S2',2,ds/3,F,dc)
drawadd(x(9),y(9), 1, 2, 1, 0,'S3',6,ds/3,F,dc)
drawdel(x(10),y(10),y(14),' ','-1', 1,ds/2,F,dc)
drawdel(x(8),y(4),y(8),' ','-1', 1,ds/2,F,dc)
drawin(x(3),y(15),'X',2,ds/2,F,dc)
drawout(x(15),y(15),'Y',0,ds/2,F,dc) 
drawnode(x(3),y(15),'1' ,2,1,F,dc)
drawnode(x(9),y(15),'2' ,2,1,F,dc)
drawnode(x(15),y(15) ,'3' ,2,1,F,dc)
drawnode(x(10),y(14),'4' ,0,1,F,dc)
drawnode(x(10),y(10),'5' ,0,1,F,dc)
drawnode(x(7),y(9),'6' ,2,1,F,dc)
drawnode(x(9),y(9),'7' ,2,1,F,dc)
drawnode(x(11),y(9),'8' ,1,1,F,dc)
drawnode(x(8),y(8),'9' ,0,1,F,dc)
drawnode(x(8),y(4),'10',0,1,F,dc)
drawnode(x(7),y(3),'11',6,1,F,dc)
drawnode(x(9),y(3),'12',6,1,F,dc)
drawline(x(11), y(15), x(15), y(15), dc);                    
drawline(x(3), y(15), x(3), y(3), dc);                       
drawline(x(3), y(15), x(3), y(9), dc);                       
drawline(x(15), y(15), x(15), y(9), dc);                     
drawline(x(15), y(9), x(15), y(3), dc);                      
drawnode(x(15), y(9),'', 1, 1, F, dc);                       
drawnode(x(3), y(9),'', 1, 1, F, dc);                        
axis('equal')
axis('off')
