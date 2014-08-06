function dr = dfirtdfa(x0,y0,dx,ds,F)                  
% dfirtdfa.m  Filter realization                        
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
% [2] Sanjit K. Mitra,
%     Digital Signal Processing Laboratory using MATLAB
%     p. 90, McGraw-Hill, 1999
%                                                                
% call   dfirtdfa(0,0,4,5,10)                           
% creation date: 24-Sep-0  time: 15:2
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
drawin(x(3), y(3),'x[n]', 2, ds, F, dc);                     
drawmult(x(3), y(3), y(6), ' ' ,'h[4]',1, ds/3, F, dc);      
drawdel(x(3), y(7), x(6), ' ', '-1' ,0, ds/2, F, dc);        
drawadd(x(6), y(7), 2, 0, 1, 1, ' ', 1, ds/3, F, dc);        
drawdel(x(8), y(7), x(11), ' ', '-1' ,0, ds/2, F, dc);       
drawadd(x(11), y(7), 2, 0, 1, 1, ' ', 1, ds/3, F, dc);       
drawdel(x(13), y(7), x(16), ' ', '-1' ,0, ds/2, F, dc);      
drawadd(x(16), y(7), 2, 0, 1, 1, ' ', 1, ds/3, F, dc);       
drawdel(x(18), y(7), x(21), ' ', '-1' ,0, ds/2, F, dc);      
drawadd(x(21), y(7), 2, 0, 1, 1, ' ', 1, ds/3, F, dc);       
drawout(x(23), y(7),'y[n]', 0, ds, F, dc);                   
drawmult(x(7), y(3), y(6), ' ' ,'h[3]',1, ds/3, F, dc);      
drawmult(x(12), y(3), y(6), ' ' ,'h[2]',1, ds/3, F, dc);     
drawmult(x(17), y(3), y(6), ' ' ,'h[1]',1, ds/3, F, dc);     
drawmult(x(22), y(3), y(6), ' ' ,'h[0]',1, ds/3, F, dc);     
drawline(x(3), y(3), x(7), y(3), dc);                        
drawline(x(7), y(3), x(12), y(3), dc);                       
drawline(x(12), y(3), x(17), y(3), dc);                      
drawline(x(17), y(3), x(22), y(3), dc);                      
drawline(x(3), y(6), x(3), y(7), dc);                        
drawnode(x(3), y(3), '1', 1, 1, F, dc);                      
drawnode(x(3), y(6), '2', 4, 1, F, dc);                      
drawnode(x(7), y(6), '3', 7, 1, F, dc);                      
drawnode(x(12), y(6), '4', 7, 1, F, dc);                     
drawnode(x(17), y(6), '5', 7, 1, F, dc);                     
drawnode(x(22), y(6), '6', 7, 1, F, dc);                     
drawnode(x(6), y(7), '7', 2, 1, F, dc);                      
drawnode(x(8), y(7), '8', 2, 1, F, dc);                      
drawnode(x(11), y(7), '9', 2, 1, F, dc);                     
drawnode(x(13), y(7), '10', 2, 1, F, dc);                    
drawnode(x(16), y(7), '11', 2, 1, F, dc);                    
drawnode(x(18), y(7), '12', 2, 1, F, dc);                    
drawnode(x(21), y(7), '13', 2, 1, F, dc);                    
drawnode(x(23), y(7), '14', 1, 1, F, dc);                    
drawnode(x(7), y(3),'', 1, 1, F, dc);                        
drawnode(x(12), y(3),'', 1, 1, F, dc);                       
drawnode(x(17), y(3),'', 1, 1, F, dc);                       
drawtext(x(11), y(10),'Transpose direct form', F+1, dc);     
drawtext(x(11), y(9),'FIR realization', F+1, dc);            
axis('equal')
axis('off')
