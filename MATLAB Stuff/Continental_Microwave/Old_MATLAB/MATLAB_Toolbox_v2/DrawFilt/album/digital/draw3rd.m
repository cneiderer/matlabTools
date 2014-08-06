function dr = draw3rd(x0,y0,dx,ds,F)                  
% draw3rd.m  Filter realization                        
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
% call   draw3rd(0,0,4,5,10)                           
% creation date: 18-Sep-0  time: 15:29
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
drawin(x(3),y(10),'X',2,ds/2,F, dc)                          
drawout(x(15),y(9),'Y',0,ds/2,F, dc) 
drawadd(x(3) , y(10), 2, 0, 1, 3,' ',2,ds/3,F, dc);
drawadd(x(8), y(9), 2, 1, 0, 1,' ',4,ds/3,F, dc);
drawadd(x(3) , y(7), 2, 1, 1, 0,' ',6,ds/3,F, dc);
drawadd(x(10), y(9), 2, 1, 1, 0,' ',6,ds/3,F, dc);
drawmult(x(5) , y(10),x(9),' ','a', 0,0.9*ds/2,F, dc);
drawmult(x(12), y(9),x(15),' ','b', 0,0.9*ds/2,F, dc);
drawdel(x(3),y(13),x(11),' ','-1',8,ds/2,F, dc);
drawdel(x(5),y(7),x(9),' ','-2', 14,ds/2,F, dc);
drawline(x(9),y(8),x(4),y(9), dc)
drawline(x(9),y(10),x(4),y(8), dc)
drawlhv(x(3),y(10),x(3),y(7), 0, dc)
drawlhv(x(9),y(7),x(9),y(8), 0, dc)
drawlhv(x(11),y(13),x(11),y(10), 0, dc)
drawlhv(x(3),y(10),x(3),y(13), 0, dc)
drawnode(x(3) ,y(10) ,'1',1,1,F, dc);
drawnode(x(5) ,y(10) ,'2',2,1,F, dc);
drawnode(x(9),y(10) ,'3',2,1,F, dc);
drawnode(x(10),y(9) ,'4',2,1,F, dc);
drawnode(x(9),y(8) ,'5',0,1,F, dc);
drawnode(x(5) ,y(7) ,'6',2,1,F, dc);
drawnode(x(11) ,y(10) ,'7',0,1,F, dc);
drawnode(x(12) ,y(9) ,'8',2,1,F, dc);
drawnode(x(15) ,y(9) ,'9',2,1,F, dc);  
drawtext(x(7), y(15),'Third-order digital filter', F+1, dc); 
drawtext(x(24), y(15),' ', F, dc);                      
drawtext(x(1), y(15),' ', F, dc);                      
axis('equal')
axis('off')
