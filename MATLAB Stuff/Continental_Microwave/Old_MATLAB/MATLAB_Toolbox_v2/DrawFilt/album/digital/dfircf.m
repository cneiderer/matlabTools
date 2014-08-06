function dr = dfircf(x0,y0,dx,ds,F)                  
% dfircf.m  Filter realization                        
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
%     p. 91, McGraw-Hill, 1999
%                                                                
% call   dfircf(0,0,4,5,10)                           
% creation date: 24-Sep-0  time: 21:2
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
drawmult(x(7), y(3), x(10), ' ' , 'a1',0, ds/3, F, dc);      
drawdel(x(7), y(3), y(7), ' ', '-1' ,3, ds/2, F, dc);        
drawmult(x(7), y(7), x(10), ' ' , 'a2',0, ds/3, F, dc);      
drawadd(x(10), y(7), 0, 2, 1, 1, ' ', 1, ds/3, F, dc);       
drawdel(x(7), y(7), y(11), ' ', '-1' ,3, ds/2, F, dc);       
drawadd(x(10), y(11), 2, 0, 1, 1, ' ', 1, ds/3, F, dc);      
drawmult(x(4), y(11), x(7), ' ' ,'h[0]',0, ds/3, F, dc);     
drawin(x(4), y(11),'x[n]', 2, ds, F, dc);                    
drawline(x(7), y(11), x(10), y(11), dc);                     
drawlhv(x(10), y(3),  x(11),  y(6), 0, dc);                  
drawline(x(11), y(8), x(11), y(10), dc);                     
drawdel(x(14), y(7), y(11), ' ', '-1' ,3, ds/2, F, dc);      
drawdel(x(14), y(3), y(7), ' ', '-1' ,3, ds/2, F, dc);       
drawmult(x(14), y(7), x(17), ' ' , 'a4',0, ds/3, F, dc);     
drawmult(x(14), y(3), x(17), ' ' , 'a5',0, ds/3, F, dc);     
drawadd(x(17), y(7), 0, 2, 1, 1, ' ', 1, ds/3, F, dc);       
drawadd(x(17), y(11), 2, 0, 1, 1, ' ', 1, ds/3, F, dc);      
drawline(x(12), y(11), x(14), y(11), dc);                    
drawline(x(14), y(11), x(17), y(11), dc);                    
drawline(x(18), y(8), x(18), y(10), dc);                     
drawlhv(x(17), y(3),  x(18),  y(6), 0, dc);                  
drawdel(x(21), y(7), y(11), ' ', '-1' ,3, ds/2, F, dc);      
drawdel(x(21), y(3), y(7), ' ', '-1' ,3, ds/2, F, dc);       
drawmult(x(21), y(3), x(24), ' ' , 'a6',0, ds/3, F, dc);     
drawmult(x(21), y(7), x(24), ' ' , 'a7',0, ds/3, F, dc);     
drawadd(x(24), y(7), 0, 2, 1, 1, ' ', 1, ds/3, F, dc);       
drawlhv(x(24), y(3),  x(25),  y(6), 0, dc);                  
drawadd(x(24), y(11), 2, 0, 1, 1, ' ', 1, ds/3, F, dc);      
drawout(x(26), y(11),'y[n]', 0, ds, F, dc);                  
drawline(x(19), y(11), x(21), y(11), dc);                    
drawline(x(21), y(11), x(24), y(11), dc);                    
drawline(x(25), y(8), x(25), y(10), dc);                     
drawnode(x(4), y(11), '1', 2, 1, F, dc);                     
drawnode(x(7), y(11), '2', 7, 1, F, dc);                     
drawnode(x(14), y(11), '3', 2, 1, F, dc);                    
drawnode(x(21), y(11), '4', 2, 1, F, dc);                    
drawnode(x(26), y(11), '5', 2, 1, F, dc);                    
drawnode(x(7), y(7), '6', 4, 1, F, dc);                      
drawnode(x(10), y(7), '7', 6, 1, F, dc);                     
drawnode(x(14), y(7), '8', 4, 1, F, dc);                     
drawnode(x(17), y(7), '9', 6, 1, F, dc);                     
drawnode(x(21), y(7), '10', 4, 1, F, dc);                    
drawnode(x(24), y(7), '11', 6, 1, F, dc);                    
drawnode(x(7), y(3), '12', 4, 1, F, dc);                     
drawnode(x(10), y(3), '13', 6, 1, F, dc);                    
drawnode(x(14), y(3), '14', 4, 1, F, dc);                    
drawnode(x(17), y(3), '15', 6, 1, F, dc);                    
drawnode(x(21), y(3), '16', 4, 1, F, dc);                    
drawnode(x(24), y(3), '17', 6, 1, F, dc);                    
drawtext(x(15), y(14),'Cascade FIR realization', F+1, dc);   
drawnode(x(11), y(10), '18', 0, 1, F, dc);                   
drawnode(x(18), y(10), '19', 0, 1, F, dc);                   
drawnode(x(25), y(10), '20', 0, 1, F, dc);                   
drawtext(1.1*x(27), y(15),' ', F, dc);                      
drawtext(x(1), y(15),' ', F, dc);                      
axis('equal')
axis('off')
