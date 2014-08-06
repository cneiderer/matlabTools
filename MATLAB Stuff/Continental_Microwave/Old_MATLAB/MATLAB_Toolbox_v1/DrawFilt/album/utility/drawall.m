function dr = drawall(x0,y0,dx,ds,F)                  
% drawall.m  Filter realization                        
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
% call   drawall(0,0,4,5,10)                           
% creation date: 17-Sep-0  time: 10:36
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
drawvs(x(2), y(15), y(18), ' ','(V)',1, ds/2, F, dc);        
drawres(x(2), y(18), x(5), ' ','R',0, ds/2, F, dc);          
drawopam(x(5), y(17), x(8), ' ','OpAmp',1, ds, F, dc);       
drawgrnd(x(2), y(15), 0, ds/2, dc);                            
drawgrnd(x(5), y(16), 0, ds/2, dc);                            
drawcap(x(5), y(20), x(8), ' ','C',0, ds/2, F, dc);          
drawline(x(5), y(20), x(5), y(18), dc);                      
drawlhv(x(8), y(20),  x(8),  y(17), 0, dc);                  
drawnode(x(8), y(17),'', 1, 1, F, dc);                       
drawota(x(8), y(16), x(11), ' ','OTA',0, ds, F, dc);         
drawgrnd(x(8), y(15), 0, ds/2, dc);                            
drawcc(x(11), y(15), x(14), ' ','CC',0, ds, F, dc);          
drawgrnd(x(11), y(14), 0, ds/2, dc);                           
drawimp(x(11), y(19), x(14), ' ','Z',0, ds/2, F, dc);        
drawlvh(x(11), y(19),  x(11),  y(16), 0, dc);                
drawlhv(x(14), y(19),  x(14),  y(15), 0, dc);                
drawlnd(x(14), y(15), x(17), ' ','L',0, ds/2, F, dc);        
drawline(x(17), y(15), x(17), y(13), dc);                    
drawgrnd(x(17), y(13), 1, ds/2, dc);                           
drawarrw(x(17), y(14),' I', 3, ds/2, F, dc);                 
drawnode(x(2), y(14),'GRND', 0, 1, F, dc);                   
drawnode(x(17), y(15),'NODE', 1, 1, F, dc);                  
drawnode(x(5), y(18),'', 1, 1, F, dc);                       
drawnode(x(11), y(16),'', 1, 1, F, dc);                      
drawnode(x(14), y(15),'', 1, 1, F, dc);                      
drawccs(x(20), y(13), y(16), ' ','a*I',3, ds/2, F, dc);      
drawcs(x(20), y(16), y(19), ' ','(I)',1, ds/2, F, dc);       
drawline(x(17), y(13), x(20), y(13), dc);                    
drawnode(x(17), y(13),'', 1, 1, F, dc);                      
drawimp(x(20), y(19), x(23), ' ','Z',0, ds/2, F, dc);        
drawcvs(x(23), y(13), y(19), ' ','g*I',3, ds/2, F, dc);      
drawline(x(23), y(13), x(20), y(13), dc);                    
drawnode(x(20), y(13),'', 1, 1, F, dc);                      
drawnode(x(20), y(19),'v', 1, 1, F, dc);                     
drawtext(x(16), y(18),'TEXT', F+1, dc);                      
draw4tbl(x(4), y(8), x(9), ' ','Block 4',0, ds, F, dc);      
drawin(x(4), y(9),'In', 2, ds, F, dc);                       
drawarrw(x(5), y(9),' ', 0, ds/2, F, dc);                    
drawmult(x(9), y(9), x(12), ' ' ,'Mult',0, ds/3, F, dc);     
drawdel(x(9), y(7), x(12), ' ', '-1' ,2, ds/2, F, dc);       
drawupsa(x(12), y(9), x(15), ' ','L',0, ds/2, F-1, dc);      
drawblo(x(15), y(9), x(19), ' ','H',0, ds/2, F, dc);         
drawdown(x(19), y(9), x(22), ' ','M',0, ds/2, F-1, dc);      
drawout(x(4), y(7),'Out', 2, ds, F, dc);                     
drawblo(x(15), y(7), x(22), ' ','Bl',2, ds/2, F, dc);        
drawadd(x(13), y(7), 1, 0, 2, 3, 'S', 3, ds/3, F, dc);       
drawlvh(x(5), y(7),  x(12),  y(5), 0, dc);                   
drawlhv(x(12), y(5),  x(14),  y(6), 0, dc);                  
drawline(x(13), y(7), x(12), y(7), dc);                      
drawnode(x(5), y(7),'', 1, 1, F, dc);                        
drawarrw(x(4), y(7),' ', 2, ds/2, F, dc);                    
drawarrw(x(10), y(5),' ', 0, ds/2, F, dc);                   
drawarrw(x(8), y(7),' ', 2, ds/2, F, dc);                    
drawline(x(22), y(9), x(22), y(7), dc);                      
drawtext(x(18), y(5),'Block', F+1, dc);                      
drawtext(x(20), y(10),'down', F+1, dc);                      
drawtext(x(14), y(10),'UP', F+1, dc);                        
axis('equal')
axis('off')
