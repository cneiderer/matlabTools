function dr = vdivider(x0,y0,dx,ds,F)                  
% vdivider.m  Filter realization                        
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
% call   vdivider(0,0,4,5,10)                           
% creation date: 2-Oct-0  time: 7:2
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
drawvs(x(5), y(5), y(11), ' ','Vg',1, ds/2, F, dc);          
drawres(x(5), y(11), x(11), ' ', 'R1' ,0, ds/2, F, dc);      
drawres(x(11), y(5), y(11), ' ', 'R2' ,3, ds/2, F, dc);      
drawline(x(11), y(5), x(5), y(5), dc);                       
drawgrnd(x(5), y(5), 0, ds/2, dc); 
drawnode(x(5), y(11), '1', 2, 1, F, dc);                     
drawnode(x(11), y(11), '2', 2, 1, F, dc);                    
drawarrw(x(6), y(11),' i', 0, ds/2, F, dc);                  
drawarrw(x(11), y(10),' i', 3, ds/2, F, dc);                 
drawline(x(5), y(13), x(11), y(13), dc);                     
drawline(x(13), y(11), x(13), y(5), dc);                     
drawarrw(x(5), y(13),' +', 2, ds/2, F, dc);                  
drawarrw(x(11), y(13),' ', 0, ds/2, F, dc);                  
drawarrw(x(13), y(11),' +', 1, ds/2, F, dc);                 
drawarrw(x(13), y(5),' ', 3, ds/2, F, dc);                   
drawtext(x(8), y(14),'u1', F+1, dc);                         
drawtext(x(14), y(8),'u2', F+1, dc);                         
drawtext(x(8), y(1),'Voltage Divider', F+1, dc);             
drawnode(x(5), y(5),'0', 4, 1, F, dc);                       
axis('equal')
axis('off')
