function dr = drawsk2b
    
% drawsk2b.m  DRAW TWO CASCADED SALLEN-KEY BIQUADS
%   
%            Album of Analog Filter Realizations
%                                                               
%   Authors: Miroslav D. Lutovac, Dejan V. Tosic, 1999/02/21    
%   Email: lutovac@iritel.bg.ac.yu      http://galeb.etf.bg.ac.yu/~lutovac/
%   Email: tosic@galeb.etf.bg.ac.yu     http://www.rcub.bg.ac.yu/~tosicde/
%   Copyright (c) 1999-2000 by Lutovac & Tosic                   
%   $Revision: 1.21 $  $Date: 2000/10/03 13:45$                  
%                                                                
%   References:
%   [1] Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans          
%       Filter Design for Signal Processing                     
%       Using MATLAB and Mathematica                         
%       Prentice Hall - ISBN 0-201-36130-2                      
%       http://www.prenhall.com/lutovac                        
%   [2] G. S. Moschytz, P. Horn
%       Active Filter Design Handbook
%       John Wiley, New York, 1981
%                                                                
% call   drawsk2b
%   
      
whitebg(figure(gcf),[1 1 1]);
dc = 'b';
ds = 5;
F  = 9;
RaOA = ['1','2','1','2','1','2','3','4']';
RbOA = ['3','4','3','4','2','5','6','7']';
dc = 'b';
drawskoa( 0,  0, 4, ds, F, dc, RaOA);
dc = 'r';
drawskoa(13, -1, 4, ds, F, dc, RbOA);
dc = 'b';
drawin(  2, 6, 'Vin', 2, ds, F+2, dc);
drawout(28, 4, 'Vo',  0, ds, F+2, dc);
drawnode(2, 6, 'V1',  2, ds/4, F, dc);
drawtext(14, 10, 'Cascaded Realization of Sallen-Key Biquads',F+2,dc);
drawtext(31, 10, ' ',F,dc);
drawtext(0, 10, ' ',F,dc);
