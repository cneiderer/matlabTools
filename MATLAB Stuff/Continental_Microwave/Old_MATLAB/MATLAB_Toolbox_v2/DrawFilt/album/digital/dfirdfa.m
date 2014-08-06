function dr = dfirdfa(x0,y0,dx,ds,F)                  
% dfirdfa.m  Filter realization                        
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
% call   dfirdfa(0,0,4,5,10)                           
% creation date: 24-Sep-0  time: 9:27
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
drawin(x(3), y(7),'x[n]', 2, ds, F, dc);                     
drawnode(x(3), y(7), '1', 2, 1, F, dc);                      
drawdel(x(3), y(7), x(7), ' ', '-1' ,0, ds/2, F, dc);        
drawmult(x(7), y(4), y(7), ' ' ,'h[1]',7, ds/3, F, dc);      
drawadd(x(6), y(3), 2, 1, 1, 0, ' ', 1, ds/3, F, dc);        
drawnode(x(7), y(7), '2', 2, 1, F, dc);                      
drawdel(x(7), y(7), x(11), ' ', '-1' ,0, ds/2, F, dc);       
drawnode(x(11), y(7), '3', 2, 1, F, dc);                     
drawdel(x(11), y(7), x(15), ' ', '-1' ,0, ds/2, F, dc);      
drawnode(x(15), y(7), '4', 2, 1, F, dc);                     
drawdel(x(15), y(7), x(19), ' ', '-1' ,0, ds/2, F, dc);      
drawnode(x(19), y(7), '5', 1, 1, F, dc);                     
drawmult(x(11), y(4), y(7), ' ' ,'h[2]',7, ds/3, F, dc);     
drawmult(x(15), y(4), y(7), ' ' ,'h[3]',7, ds/3, F, dc);     
drawmult(x(19), y(4), y(7), ' ' ,'h[4]',7, ds/3, F, dc);     
drawadd(x(10), y(3), 2, 1, 1, 0, ' ', 1, ds/3, F, dc);       
drawadd(x(14), y(3), 2, 1, 1, 0, ' ', 1, ds/3, F, dc);       
drawadd(x(18), y(3), 2, 1, 1, 0, ' ', 1, ds/3, F, dc);       
drawout(x(20), y(3),'y[n]', 0, ds, F, dc);                   
drawline(x(8), y(3), x(10), y(3), dc);                       
drawline(x(12), y(3), x(14), y(3), dc);                      
drawline(x(16), y(3), x(18), y(3), dc);                      
drawmult(x(3), y(4), y(7), ' ' ,'h[0]',7, ds/3, F, dc);      
drawlvh(x(3), y(4),  x(6),  y(3), 0, dc);                    
drawnode(x(3), y(4), '6', 0, 1, F, dc);                      
drawnode(x(7), y(4), '7', 0, 1, F, dc);                      
drawnode(x(11), y(4), '8', 0, 1, F, dc);                     
drawnode(x(15), y(4), '9', 0, 1, F, dc);                     
drawnode(x(19), y(4), '10', 0, 1, F, dc);                    
drawnode(x(10), y(3), '11', 3, 1, F, dc);                    
drawnode(x(14), y(3), '12', 3, 1, F, dc);                    
drawnode(x(18), y(3), '13', 3, 1, F, dc);                    
drawnode(x(20), y(3),'14', 1, 1, F, dc);                     
drawtext(x(10), y(9),'Direct form FIR realization', F+1, dc);
drawtext(x(25), y(15),' ', F, dc);                      
drawtext(x(1), y(15),' ', F, dc);                      
axis('equal')
axis('off')
