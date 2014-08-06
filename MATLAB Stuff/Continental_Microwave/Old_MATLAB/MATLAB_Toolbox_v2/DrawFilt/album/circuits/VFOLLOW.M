function dr = vfollow(x0,y0,dx,ds,F)                  
% vfollow.m  Filter realization                        
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
% call   vfollow(0,0,4,5,10)                           
% creation date: 2-Oct-0  time: 0:57
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
drawline(x(9), y(8), x(11), y(8), dc);                       
drawnode(x(3), y(8), '1', 2, 1, F, dc);                      
drawnode(x(9), y(8), '2', 2, 1, F, dc);                      
drawcvs(x(13), y(8), y(14), ' ','A*(V3-V2)',1, ds/2, F, dc); 
drawline(x(9), y(14), x(11), y(14), dc);                     
drawline(x(13), y(14), x(19), y(14), dc);                    
drawline(x(13), y(8), x(19), y(8), dc);                      
drawres(x(19), y(8), y(14), ' ', 'R2' ,3, ds/2, F, dc);      
drawgrnd(x(19), y(8), 0, ds/2, dc);                          
drawnode(x(19), y(14), '3', 0, 1, F, dc);                    
drawline(x(11), y(16), x(17), y(16), dc);                    
drawline(x(11), y(16), x(9), y(14), dc);                     
drawline(x(17), y(16), x(19), y(14), dc);                    
drawnode(x(19), y(8),'0', 0, 1, F, dc);                      
drawnode(x(3), y(2),'0', 0, 1, F, dc);                       
drawnode(x(9), y(14),'3', 6, 1, F, dc);                      
drawtext(x(13), y(3),'Voltage Follower', F+1, dc);           
drawtext(x(12), y(7),'VCVS', F+1, dc);                       
axis('equal')
axis('off')
