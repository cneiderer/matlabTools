function dr = invamp(x0,y0,dx,ds,F)                  
% invamp.m  Filter realization                        
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
% call   invamp(0,0,4,5,10)                           
% creation date: 2-Oct-0  time: 7:1
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
drawgrnd(x(3), y(2), 0, ds/2, dc);                           
drawvs(x(3), y(2), y(8), ' ','Vg',1, ds/2, F, dc);           
drawres(x(3), y(8), x(9), ' ', 'R1' ,0, ds/2, F, dc);        
drawopam(x(9), y(7), x(13), ' ','opamp',1, ds, F, dc);       
drawgrnd(x(9), y(6), 0, ds/2, dc);                           
drawres(x(9), y(10), x(14), ' ', 'R2' ,0, ds/2, F, dc);      
drawline(x(9), y(10), x(9), y(8), dc);                       
drawline(x(14), y(10), x(14), y(7), dc);                     
drawline(x(13), y(7), x(14), y(7), dc);                      
drawout(x(14), y(7), 'OUT', 0, ds, F, dc);                   
drawres(x(14), y(2), y(7), ' ', 'R3' ,3, ds/2, F, dc);       
drawgrnd(x(14), y(2), 0, ds/2, dc);                          
drawnode(x(3), y(8), '1', 2, 1, F, dc);                      
drawnode(x(9), y(8), '2', 3, 1, F, dc);                      
drawnode(x(14), y(7), '3', 3, 1, F, dc);                     
drawnode(x(14), y(2),'', 0, 1, F, dc);                       
drawnode(x(9), y(6),'', 4, 1, F, dc);                        
drawnode(x(3), y(2),'0', 0, 1, F, dc);                       
drawtext(x(8), y(2),'Inverting Amplifier', F+1, dc);         
axis('equal')
axis('off')
