function [matrixEE,matrixEdel] = bdelete(x0,y0,dx,ds,F,Nx,Ny,matrixE)

% bdelete.m   BUTTON: DELETE OBJECT
%   
%                 Drawing Filter Realizations
%   
%   Authors: Miroslav D. Lutovac, Dejan V. Tosic, 1999/02/21
%   lutovac@iritel.bg.ac.yu    http://galeb.etf.bg.ac.yu/~lutovac/
%   tosic@galeb.etf.bg.ac.yu   http://www.rcub.bg.ac.yu/~tosicde/
%   Copyright (c) 1999-2000 by Lutovac & Tosic
%   $Revision: 1.21 $  $Date: 2000/10/03 13:45$
%   
%   References:
%   Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans
%        Filter Design for Signal Processing
%           Using MATLAB and Mathematica
%        Prentice Hall - ISBN 0-201-36130-2 
%         http://www.prenhall.com/lutovac
%
                         
% This file is part of DrawFilt toolbox for MATLAB.
% Refer to the file LICENSE.TXT for full details.
%                        
% DrawFilt version 2.1, Copyright (c) 1999-2000 M. Lutovac and D. Tosic
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; see LICENSE.TXT for details.
%                       
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%                       
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc.,  59 Temple Place,  Suite 330,  Boston,
% MA  02111-1307  USA,  http://www.fsf.org/

inddelete1 = 0;
x = zeros(1,4*Nx);
y = zeros(1,4*Ny);
for indx = 1:4*Nx
 x(indx) = x0 + dx*indx/4;
end
for indy = 1:4*Ny
 y(indy) = y0 + dx*indy/4;
end

title('CLICK an object node to DELETE')

[xe1,ye1]=ginput(1);
xe2 = round(xe1); 
ye2 =round(ye1);
%disp([xe2 ye2])

but = 0;
but2 = 0;
tmp1 = 0;
t1 = [];
x1 = [];
[nE,ns] = size(matrixE);
Nchanged = 0;
xyerr = 100;

if nE > 1
  for indE = nE:-1:2
    set(gcf,'DefaultTextColor','k')
    dc = 'k';
    t1 = matrixE(indE,:);
    abi = []; abi = find(t1-','==0); 
    if length(abi)>0
      abj =  []; abj = t1(1:abi(1)-1);
      abjl = []; abjl = find(abj-'('==0); 
      abjr = []; abjr = find(abj-')'==0); 
      abk =  []; abk = abj((abjl(length(abjl))+1):(abjr(length(abjr))-1));
      abl =  []; abl = eval(abk); x1(indE) = abl;
    else
      x1(indE) = 0;
    end
    if length(abi)>1
      abj =  []; abj = t1(abi(1)+1:abi(2)-1);
      abjl = []; abjl = find(abj-'('==0); 
      abjr = []; abjr = find(abj-')'==0); 
      abk =  []; abk = abj((abjl(length(abjl))+1):(abjr(length(abjr))-1));
      abl =  []; abl = eval(abk); y1(indE) = abl;
    else
      y1(indE) = 0;
    end
    x2(indE) = x1(indE);  y2(indE) = y1(indE);
  if (sum(abs(t1(5:7)-'in('))==0)|(sum(abs(t1(5:7)-'out'))==0)
% ------- (x1,y1) - (x1,y1) ----------------------------------------
    tmp1 = tmp1+1;
  elseif (sum(abs(t1(5:8)-'node'))==0)|(sum(abs(t1(5:8)-'text'))==0)|(sum(abs(t1(5:8)-'grnd'))==0)
    tmp1 = tmp1+1;
  elseif (sum(abs(t1(5:8)-'add('))==0)|(sum(abs(t1(5:8)-'mult'))==0)|(sum(abs(t1(5:8)-'del('))==0)
    tmp1 = tmp1+1;
  elseif sum(abs(t1(5:8)-'arrw')) == 0
    tmp1 = tmp1+1;
  elseif ( sum(abs(t1(5:8)-'lhv('))==0  )|(sum(abs(t1(5:8)-'lvh('))==0)|(sum(abs(t1(5:8)-'line'))==0)
% ------- (x1,y1) - (x2,y2) ----------------------------------------
    if length(abi)>2
      abj =  []; abj = t1(abi(2)+1:abi(3)-1);
      abjl = []; abjl = find(abj-'('==0); 
      abjr = []; abjr = find(abj-')'==0); 
      abk =  []; abk = abj((abjl(length(abjl))+1):(abjr(length(abjr))-1));
      abl =  []; abl = eval(abk); x2(indE) = abl;
    else
      x2(indE) = 0;
    end
    if length(abi)>3
      abj =  []; abj = t1(abi(3)+1:abi(4)-1);
      abjl = []; abjl = find(abj-'('==0); 
      abjr = []; abjr = find(abj-')'==0); 
      abk =  []; abk = abj((abjl(length(abjl))+1):(abjr(length(abjr))-1));
      abl =  []; abl = eval(abk); y2(indE) = abl;
    else
      y2(indE) = 0;
    end

  else
% ------- (x1,y1) - (xy2)  0,1,... ---------------------------------
    if length(abi)>2
      abj =  []; abj = t1(abi(2)+1:abi(3)-1);
      abjl = []; abjl = find(abj-'('==0);
      abjr = []; abjr = find(abj-')'==0);
      abk =  []; abk = abj((abjl(length(abjl))+1):(abjr(length(abjr))-1));
      abl =  []; abl = eval(abk); xy2(indE) = abl;
    else
      xy2(indE) = 0;
    end

    xy3(indE) = -2;
    if length(abi)>5
      abj = []; abj = t1(abi(5)+1:abi(6)-1);
      abl = []; abl = eval(abj); xy3(indE) = abl;
    else
      xy3(indE) = -2;
    end
    xy4 = xy3-2*fix(xy3/2);

    if xy4(indE)==0
      x2(indE) = xy2(indE);
    end
    if xy4(indE)==1
      y2(indE) = xy2(indE);
    end
   end
    
    xyerr(indE) = abs(xe1-(x1(indE)+x2(indE))/2) + ...
                  abs(ye1-(y1(indE)+y2(indE))/2);

    if     (abs(xe1-x1(indE))+abs(ye1-y1(indE))) < 2
      but2 = 2;
      Nchanged = Nchanged + 1;
    elseif (abs(xe1-x2(indE))+abs(ye1-y2(indE))) < 2
      but2 = 2;
      Nchanged = Nchanged + 1;
    else
      but2 = 0;
    end

% -------- DELETE -----------------
   set(gcf,'DefaultTextColor','k')
   dc = 'k';
   if but2 == 2
    set(gcf,'DefaultTextColor','g')
    dc = 'g';
    eval(matrixE(indE,:))
    title('DELETE  Click left mouse button for YES, right for NO')
    [xxe,yye,but]=ginput(1);
    if ((but == 1)|(but == 13))
      set(gcf,'DefaultTextColor','r')
      dc = 'r';
      [indE1,indE2] = size(matrixE);
      inddelete1 = inddelete1 + 1;
      matrixEdel(inddelete1,1:indE2) = matrixE(indE,:);
      eval(matrixE(indE,:))
      matrixE(indE,:)=[];
    else
      set(gcf,'DefaultTextColor','b')
      dc = 'b';
      eval(matrixE(indE,:))
    end
   end
  end
  if Nchanged == 0
    [xyerr1,xyerr2] = min(xyerr);
    indE = xyerr2;
    set(gcf,'DefaultTextColor','g')
    dc = 'g';
    eval(matrixE(indE,:))
    title('DELETE  Click left mouse button for YES, right for NO')
    [xxe,yye,but]=ginput(1);
    if ((but == 1)|(but == 13))
      set(gcf,'DefaultTextColor','r')
      dc = 'r';
      eval(matrixE(indE,:));
      [indE1,indE2] = size(matrixE);
      inddelete1 = inddelete1 + 1;
      matrixEdel(inddelete1,1:indE2) = matrixE(indE,:);
      matrixE(indE,:)=[];
    else
      set(gcf,'DefaultTextColor','b')
      dc = 'b';
      eval(matrixE(indE,:))
    end
  end
end
matrixEE = matrixE;
    title('                              ')

set(gcf,'DefaultTextColor','k')
