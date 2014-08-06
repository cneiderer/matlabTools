function dr = cdivider(x0,y0,dx,ds,F)                  
% cdivider.m  Filter realization                        
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
% call   cdivider(0,0,4,5,10)                           
% creation date: 17-Sep-0  time: 20:47
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
drawcs(x(5), y(6), y(10), ' ','Ig',1, ds/2, F, dc);          
drawline(x(5), y(10), x(7), y(10), dc);                      
drawline(x(7), y(9), x(7), y(11), dc);                       
drawres(x(7), y(11), x(13), ' ', 'R1' ,0, ds/2, F, dc);      
drawres(x(7), y(9), x(13), ' ', 'R2' ,2, ds/2, F, dc);       
drawline(x(13), y(11), x(13), y(9), dc);                     
drawline(x(13), y(10), x(15), y(10), dc);                    
drawlhv(x(5), y(6),  x(15),  y(10), 0, dc);                  
drawgrnd(x(5), y(6), 0, ds/2, dc); 
drawnode(x(7), y(10), '1', 3, 1, F, dc);                     
drawnode(x(13), y(10), '2', 1, 1, F, dc);                    
drawnode(x(5), y(6),'', 1, 1, F, dc);                        
drawtext(x(10), y(2),'Current Divider', F+1, dc);            
drawarrw(x(8), y(11),' i1', 0, ds/2, F, dc);                 
drawarrw(x(8), y(9),' i2', 4, ds/2, F, dc);                  
axis('equal')
axis('off')
