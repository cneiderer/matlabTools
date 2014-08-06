function [matrixEE,editString1] = bdrwedit(x0,y0,dx,ds,F,Nx,Ny,matrixE,editString)

% bdrwedit.m    BUTTON: EDIT OBJECT 
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

if (editString(1) == 0)

strindE = [];
x = zeros(1,4*Nx);
y = zeros(1,4*Ny);
for indx = 1:4*Nx
 x(indx) = x0 + dx*indx/4;
end
for indy = 1:4*Ny
 y(indy) = y0 + dx*indy/4;
end

title('CLICK an object node to EDIT')

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
    drawtype1 = find(t1-'('==0);
    drawtype = t1(5:drawtype1(1)-1);
    drawtype2 = ['draw' drawtype];
    drawtype3 = drawtype;
% set length(drawtype3) = 4 --------------------------
  if length(drawtype3) == 4
    drawtype = drawtype3;
  elseif length(drawtype3) == 3
    drawtype = [drawtype3 'x'];
  elseif length(drawtype3) == 2
    drawtype = [drawtype3 'xx'];
  elseif length(drawtype3) == 1
    drawtype = [drawtype3 'xxx'];
  elseif length(drawtype3) > 4
    drawtype = drawtype3(1:4);
  else
    drawtype = 'xxxx';
  end
  drawtypecomp1 = sum(abs(drawtype-'resx'))==0|sum(abs(drawtype-'capx'))==0|sum(abs(drawtype-'lndx'))==0|...
                  sum(abs(drawtype-'impx'))==0|sum(abs(drawtype-'blox'))==0|sum(abs(drawtype-'4tbl'))==0|...
                  sum(abs(drawtype-'opam'))==0|sum(abs(drawtype-'otax'))==0|sum(abs(drawtype-'ccxx'))==0|...
                  sum(abs(drawtype-'vsxx'))==0|sum(abs(drawtype-'csxx'))==0|sum(abs(drawtype-'opam'))==0|...
                  sum(abs(drawtype-'mult'))==0|sum(abs(drawtype-'delx'))==0|...
                  sum(abs(drawtype-'cvsx'))==0|sum(abs(drawtype-'ccsx'))==0;
  drawtypecomp2 = sum(abs(drawtype-'lhvx'))==0|sum(abs(drawtype-'lvhx'))==0|sum(abs(drawtype-'line'))==0;
  drawtypecomp3 = sum(abs(drawtype-'grnd'))==0;
  drawtypecomp4 = sum(abs(drawtype-'inxx'))==0|sum(abs(drawtype-'outx'))==0|sum(abs(drawtype-'text'))==0|...
                  sum(abs(drawtype-'arrw'))==0;
  drawtypecomp5 = sum(abs(drawtype-'node'))==0|sum(abs(drawtype-'arrw'))==0;
  drawtypecomp6 = sum(abs(drawtype-'addx'))==0;

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
  if ( (t1(5:7)=='in(')|(t1(5:7)=='out') )
% ------- (x1,y1) - (x1,y1) ----------------------------------------
    tmp1 = tmp1+1;
  elseif ( (t1(5:8)=='node')|(t1(5:8)=='text')|(t1(5:8)=='grnd') )
    tmp1 = tmp1+1;
  elseif ( (t1(5:8)=='arrw') )
    tmp1 = tmp1+1;
  elseif ( (t1(5:8)=='lhv(')|(t1(5:8)=='lvh(')|(t1(5:8)=='line') )
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

    if drawtypecomp6 == 1
      xy2(indE) = 0;
    elseif length(abi)>2
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

% -------- EDIT -----------------
   set(gcf,'DefaultTextColor','k')
   dc = 'k';
   if (editString(1) == 0)
    if but2 == 2
     set(gcf,'DefaultTextColor','g')
     dc = 'g';
     eval(matrixE(indE,:))
     title('EDIT  Click left mouse button for YES, right for NO')
     [xxe,yye,but]=ginput(1);
     if (((but == 1)|(but == 13))&(editString(1) == 0))
       set(gcf,'DefaultTextColor','r')
       dc = 'r';
       eval(matrixE(indE,:))
       strindE = matrixE(indE,:);
       editString(1) = 1;
       editString(2) = indE;
     else
       set(gcf,'DefaultTextColor','b')
       dc = 'b';
       eval(matrixE(indE,:))
     end
    end
   end
  end
  if Nchanged == 0
    [xyerr1,xyerr2] = min(xyerr);
    indE = xyerr2;
    set(gcf,'DefaultTextColor','g')
    dc = 'g';
    eval(matrixE(indE,:))
    title('EDIT  Click left mouse button for YES, right for NO')
    [xxe,yye,but]=ginput(1);

    if (((but == 1)|(but == 13))&(editString(1) == 0))
      set(gcf,'DefaultTextColor','r')
      dc = 'r';
      eval(matrixE(indE,:))
      strindE = matrixE(indE,:);
      editString(1) = 1;
      editString(2) = indE;
    else
      set(gcf,'DefaultTextColor','b')
      dc = 'b';
      eval(matrixE(indE,:))
    end
  end
end
set(gcf,'DefaultTextColor','k')
title('                              ')

end

editString1 = editString;
matrixEE = matrixE;
