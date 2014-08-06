function dr = fbvamp(x0,y0,dx,ds,F)                  
% fbvamp.m  Filter realization                        
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
% call   fbvamp(0,0,4,5,10)                           
% creation date: 2-Oct-0  time: 6:55
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
drawvs(x(4), y(4), y(10), ' ','Vg',1, ds/2, F, dc);          
drawres(x(4), y(10), x(8), ' ','Rg',0, ds/2, F, dc);         
drawline(x(8), y(10), x(10), y(10), dc);                     
drawres(x(10), y(4), y(10), ' ','Rin',1, ds/2, F, dc);       
drawcvs(x(13), y(4), y(10), ' ','A*V2',5, ds/2, F, dc);      
drawres(x(13), y(10), x(17), ' ','Rout',0, ds/2, F, dc);     
drawline(x(17), y(10), x(19), y(10), dc);                    
drawres(x(19), y(4), y(10), ' ','Rload',3, ds/2, F, dc);     
drawres(x(8), y(13), x(17), ' ','Rfeedback',0, ds/2, F, dc); 
drawline(x(8), y(13), x(8), y(10), dc);                      
drawline(x(17), y(13), x(17), y(10), dc);                    
drawline(x(4), y(4), x(19), y(4), dc);                       
drawgrnd(x(4), y(4), 0, ds/2, dc);                           
drawnode(x(4), y(10), '1', 2, 1, F, dc);                     
drawnode(x(8), y(10), '2', 3, 1, F, dc);                     
drawnode(x(13), y(10), '3', 2, 1, F, dc);                    
drawnode(x(17), y(10), '4', 1, 1, F, dc);                    
drawnode(x(4), y(4),'0', 4, 1, F, dc);                       
drawline(x(8), y(9), x(8), y(5), dc);                        
drawarrw(x(8), y(9),' +', 5, ds/2, F, dc);                   
drawarrw(x(8), y(5),' -', 7, ds/2, F, dc);                   
drawtext(x(7), y(7),'V2', F+1, dc);                          
drawtext(x(12), y(1),'Feedback voltage amplifier', F+1, dc); 
drawnode(x(10), y(4),'', 1, 1, F, dc);                       
drawnode(x(13), y(4),'', 1, 1, F, dc);                       
axis('equal')
axis('off')
