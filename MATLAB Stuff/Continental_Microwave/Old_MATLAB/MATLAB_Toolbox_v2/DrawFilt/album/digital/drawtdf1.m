function dr = drawtdf1(x0,y0,dx,ds,F)                  
% drawtdf1.m  Filter realization                        
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
%   See also:                                                    
%   Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans          
%        Filter Design for Signal Processing                     
%           Using MATLAB and Mathematica                         
%        Prentice Hall - ISBN 0-201-36130-2                      
%         http://www.prenhall.com/lutovac                        
%                                                                
%                                                                
% call   drawtdf1(0,0,4,5,10)                           
% creation date: 20-Sep-0  time: 23:30
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
drawtext(x(8),y(11),'First-order',F+1,dc);
drawtext(x(8),y(10),'Transpose-Direct-form II',F+1,dc);
drawin(x(3),y(8),'X',2,ds/2,F,dc);
drawout(x(13),y(8),'Y',0,ds/2,F,dc);
drawmult(x(3),y(8),x(7), ' ','b0', 0,ds/2/2,F,dc);
drawmult(x(3),y(2),x(7), ' ','b1', 0,ds/2,F,dc);
drawmult(x(9),y(2),x(13), ' ','a1', 6,ds/2,F,dc);
drawadd(x(7),y(8), 2, 0, 1, 1,'S1',2,ds/3,F,dc);
drawadd(x(7),y(2), 1, 2, 1, 0,'S2',6,ds/3,F,dc);
drawdel(x(8),y(3),y(7),' ','-1', 1,ds/2,F,dc);
drawnode(x(3),y(8),'1' ,2,1,F,dc);
drawnode(x(7),y(8), '2' ,2,1,F,dc);
drawnode(x(13),y(8), '3' ,2,1,F,dc);
drawnode(x(8),y(7), '4' ,0,1,F,dc);
drawnode(x(8),y(3), '5' ,0,1,F,dc);
drawnode(x(7),y(2), '6' ,2,1,F,dc);
drawnode(x(9),y(2), '7' ,2,1,F,dc);
drawline(x(3), y(8), x(3), y(2), dc);                        
drawline(x(13), y(8), x(13), y(2), dc);                      
drawline(x(13), y(8), x(9), y(8), dc);                       
drawtext(x(24), y(15),' ', F, dc);                      
drawtext(x(1), y(15),' ', F, dc);                      
axis('equal')
axis('off')
