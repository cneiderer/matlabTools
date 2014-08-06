function dr = wien(x0,y0,dx,ds,F)                  
% wien.m  Filter realization                        
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
% call   wien(0,0,4,5,10)                           
% creation date: 2-Oct-0  time: 16:29
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
drawcvs(x(16), y(6), y(12), ' ','a*v1',5, ds/2, F, dc);      
drawline(x(16), y(12), x(19), y(12), dc);                    
drawline(x(16), y(6), x(19), y(6), dc);                      
drawout(x(19), y(12), 'OUT', 0, ds, F, dc);                  
drawgrnd(x(19), y(6), 0, ds/2, dc);                          
drawline(x(19), y(14), x(19), y(12), dc);                    
drawline(x(14), y(12), x(11), y(12), dc);                    
drawline(x(14), y(6), x(11), y(6), dc);                      
drawgrnd(x(11), y(6), 0, ds/2, dc);                          
drawline(x(11), y(14), x(11), y(12), dc);                    
drawres(x(7), y(7), y(11), ' ', 'R1' ,1, ds/2, F, dc);       
drawcap(x(9), y(7), y(11), ' ', 'C1' ,3, ds/2, F, dc);       
drawline(x(7), y(11), x(9), y(11), dc);                      
drawline(x(7), y(7), x(9), y(7), dc);                        
drawlvh(x(8), y(7),  x(11),  y(6), 0, dc);                   
drawlvh(x(8), y(11),  x(11),  y(12), 0, dc);                 
drawres(x(11), y(14), x(15), ' ', 'R2' ,0, ds/2, F, dc);     
drawcap(x(15), y(14), x(19), ' ', 'C2' ,0, ds/2, F, dc);     
drawnode(x(11), y(12), '1', 6, 1, F, dc);                    
drawnode(x(19), y(12), '2', 6, 1, F, dc);                    
drawnode(x(15), y(14), '3', 6, 1, F, dc);                    
drawnode(x(19), y(6),'0', 2, 1, F, dc);                      
drawnode(x(11), y(6),'0', 2, 1, F, dc);                      
drawnode(x(8), y(11),'', 1, 1, F, dc);                       
drawnode(x(8), y(7),'', 1, 1, F, dc);                        
drawtext(x(13), y(3),'Wien Bridge Oscillator', F+1, dc);     
drawtext(x(15), y(5),'VCVS', F+1, dc);                       
drawtext(x(4), y(14),'Initial Condition', F+1, dc);          
drawtext(x(4), y(13),'v1(0-)=Vo', F+1, dc);                  
axis('equal')
axis('off')
