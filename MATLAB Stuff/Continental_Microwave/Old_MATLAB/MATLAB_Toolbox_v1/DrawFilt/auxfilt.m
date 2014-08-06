function dr = auxfilt(x0,y0,dx,ds,F)                               
% auxfilt.m    AUXILIARY DRAWING                                   
%  Realization generated from the drawing window of the toolbox    
%                                                                  
%         DRAWFILT  -  Drawing Filter Realizations                 
%                                                                  
%   Authors: Miroslav D. Lutovac, Dejan V. Tosic, 1999/02/21       
%   lutovac@iritel.bg.ac.yu    http://galeb.etf.bg.ac.yu/~lutovac/ 
%   tosic@galeb.etf.bg.ac.yu   http://www.rcub.bg.ac.yu/~tosicde/  
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
% call   auxfilt(0,0,4,5,10)                                       
% creation date: 29-Sep-2000  time: 13:40
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
drawdel(x(5), y(15), x(10), ' ', '-1' ,0, ds/2, F, dc);      
drawdel(x(10), y(15), x(15), ' ', '-1' ,0, ds/2, F, dc);     
drawdel(x(15), y(15), x(20), ' ', '-1' ,0, ds/2, F, dc);     
drawadd(x(9), y(13), 0, 1, 2, 1, ' ', 3, ds/3, F, dc);       
drawadd(x(14), y(13), 0, 1, 2, 1, ' ', 3, ds/3, F, dc);      
drawadd(x(4), y(13), 0, 1, 2, 1, ' ', 3, ds/3, F, dc);       
drawdel(x(15), y(11), x(20), ' ', '-1' ,2, ds/2, F, dc);     
drawdel(x(10), y(11), x(15), ' ', '-1' ,2, ds/2, F, dc);     
drawdel(x(5), y(11), x(10), ' ', '-1' ,2, ds/2, F, dc);      
drawmult(x(9), y(7), y(10), ' ' ,'h[1]',3, ds/3, F, dc);     
drawmult(x(14), y(7), y(10), ' ' ,'h[2]',3, ds/3, F, dc);    
drawmult(x(4), y(7), y(10), ' ' ,'h[0]',3, ds/3, F, dc);     
drawin(x(4), y(15),'x[n]', 2, ds, F, dc);                    
drawline(x(5), y(15), x(5), y(14), dc);                      
drawline(x(10), y(15), x(10), y(14), dc);                    
drawline(x(15), y(15), x(15), y(14), dc);                    
drawline(x(10), y(11), x(10), y(12), dc);                    
drawline(x(15), y(11), x(15), y(12), dc);                    
drawline(x(5), y(11), x(5), y(12), dc);                      
drawline(x(4), y(13), x(4), y(10), dc);                      
drawnode(x(5), y(15), '1', 2, 1, F, dc);                     
drawnode(x(10), y(15), '2', 2, 1, F, dc);                    
drawnode(x(15), y(15), '3', 2, 1, F, dc);                    
drawnode(x(20), y(11),'14', 1, 1, F, dc);                    
drawnode(x(15), y(11), '5', 1, 1, F, dc);                    
drawnode(x(10), y(11), '6', 1, 1, F, dc);                    
drawnode(x(5), y(11), '7', 1, 1, F, dc);                     
drawnode(x(4), y(10), '8', 4, 1, F, dc);                     
drawnode(x(9), y(10), '9', 0, 1, F, dc);                     
drawnode(x(14), y(10), '10', 0, 1, F, dc);                   
drawline(x(9), y(13), x(9), y(10), dc);                      
drawline(x(14), y(13), x(14), y(10), dc);                    
drawadd(x(8), y(6), 2, 1, 1, 0, ' ', 1, ds/3, F, dc);        
drawadd(x(13), y(6), 2, 1, 1, 0, ' ', 1, ds/3, F, dc);       
drawline(x(10), y(6), x(13), y(6), dc);                      
drawout(x(21), y(6),'y[n]', 0, ds, F, dc);                   
drawlvh(x(4), y(7),  x(8),  y(6), 0, dc);                    
drawnode(x(4), y(7), '11', 4, 1, F, dc);                     
drawnode(x(9), y(7), '12', 4, 1, F, dc);                     
drawnode(x(14), y(7), '13', 4, 1, F, dc);                    
drawline(x(4), y(15), x(5), y(15), dc);                      
drawnode(x(10), y(6), '16', 1, 1, F, dc);                    
drawnode(x(15), y(6), '17', 1, 1, F, dc);                    
drawtext(x(10), y(18),'Linear-phase', F+1, dc);              
drawtext(x(10), y(17),'FIR realization type 2', F+1, dc);    
drawtext(x(27), y(15),' ', F, dc);                           
drawtext(x(1), y(15),' ', F, dc);                            
drawadd(x(19), y(13), 0, 1, 2, 1, ' ', 3, ds/3, F, dc);      
drawline(x(20), y(11), x(20), y(12), dc);                    
drawline(x(20), y(14), x(20), y(15), dc);                    
drawmult(x(19), y(7), y(10), ' ' ,'h[3]',3, ds/3, F, dc);    
drawadd(x(18), y(6), 2, 1, 1, 0, ' ', 1, ds/3, F, dc);       
drawline(x(15), y(6), x(18), y(6), dc);                      
drawline(x(20), y(6), x(21), y(6), dc);                      
drawline(x(19), y(13), x(19), y(10), dc);                    
drawdel(x(23), y(11), y(15), ' ', '-1' ,3, ds/2, F, dc);     
drawline(x(20), y(15), x(23), y(15), dc);                    
drawline(x(20), y(11), x(23), y(11), dc);                    
drawnode(x(20), y(15),'4', 2, 1, F, dc);                     
drawnode(x(19), y(10),'15', 0, 1, F, dc);                    
drawnode(x(19), y(7), '18', 4, 1, F, dc);                    
drawnode(x(21), y(6), '19', 1, 1, F, dc);                    
drawtext(x(27), y(15),' ', F, dc);                           
drawtext(x(1), y(15),' ', F, dc);                            
axis('equal')
axis('off')
