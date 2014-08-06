function [t1,x1,y1,x2,y2,s1,s2,abi] = editstra(editString,matrixE)

% editstra.m   EDIT SCHEMATIC PARAMETERS UTILITY
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

indE = editString(2);
t1   = matrixE(indE,:);
drawtype1 = find(t1-'('==0);
drawtype = t1(5:drawtype1(1)-1);
drawtype2 = ['draw' drawtype];
drawtype3 = drawtype;

    abi = []; abi = find(t1-','==0); 
    if length(abi)>0
      abj =  []; abj = t1(1:abi(1)-1);
      abjl = []; abjl = find(abj-'('==0); 
      abjr = []; abjr = find(abj-')'==0); 
      abk =  []; abk = abj((abjl(length(abjl))+1):(abjr(length(abjr))-1));
      abl =  []; abl = eval(abk); x1 = abl;
    else
      x1 = 0;
    end
    if length(abi)>1
      abj =  []; abj = t1(abi(1)+1:abi(2)-1);
      abjl = []; abjl = find(abj-'('==0); 
      abjr = []; abjr = find(abj-')'==0); 
      abk =  []; abk = abj((abjl(length(abjl))+1):(abjr(length(abjr))-1));
      abl =  []; abl = eval(abk); y1 = abl;
    else
      y1 = 0;
    end
    x2 = x1;  y2 = y1;

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

dt = []; dt = drawtype;
drawtypecomp1 = sum(abs(drawtype-'resx'))==0|sum(abs(drawtype-'capx'))==0|sum(abs(drawtype-'lndx'))==0|...
                sum(abs(drawtype-'impx'))==0|sum(abs(drawtype-'blox'))==0|sum(abs(drawtype-'4tbl'))==0|...
                sum(abs(drawtype-'opam'))==0|sum(abs(drawtype-'otax'))==0|sum(abs(drawtype-'ccxx'))==0|...
                sum(abs(drawtype-'vsxx'))==0|sum(abs(drawtype-'csxx'))==0|sum(abs(drawtype-'opam'))==0|...
                sum(abs(drawtype-'mult'))==0|sum(abs(drawtype-'delx'))==0|...
                sum(abs(drawtype-'cvsx'))==0|sum(abs(drawtype-'ccsx'))==0;
drawtypecomp2 = sum(abs(drawtype-'lhvx'))==0|sum(abs(drawtype-'lvhx'))==0|sum(abs(drawtype-'line'))==0;
drawtypecomp3 = sum(abs(drawtype-'grnd'))==0;
drawtypecomp4 = sum(abs(drawtype-'inxx'))==0|sum(abs(drawtype-'outx'))==0|sum(abs(drawtype-'text'))==0|...
                sum(abs(drawtype-'node'))==0|sum(abs(drawtype-'arrw'))==0;
drawtypecomp6 = sum(abs(drawtype-'addx'))==0;

if drawtypecomp1==1
% RES CAP LND IMP BLO 4TBL OPAM OTA VS CS OPAM CVS CCS
% X2, Y2  ---------------------------------------
  s1ind2 = 4;
  s1ind3 = 5;
    if length(abi)>2
      abj =  []; abj =  t1(abi(2)+1:abi(3)-1);
      abjl = []; abjl = find(abj-'('==0); 
      abjr = []; abjr = find(abj-')'==0); 
      abk =  []; abk = abj((abjl(length(abjl))+1):(abjr(length(abjr))-1));
      abl =  []; abl = eval(abk); xy = abl;
    else
      xy = 0;
    end
    if length(abi)>5
      abj =  []; abj = t1(abi(5)+1:abi(6)-1);
      yx =  []; yx = eval(abj);
    else
      yx = 0;
    end
    if length(yx)==0
      yx = 0;
    end
    if (yx-2*fix(yx/2)) == 0
      x2 = xy;
      y2 = y1;
    else
      x2 = x1;
      y2 = xy;
    end
    s2 = yx;
% LABEL -----------------------------------------
  if length(abi)>4
    abj =  []; abj = t1(abi(4)+1:abi(5)-1);
    abjl = []; abjl = find(abj-''''==0);
      if length(abjl) > 1
        abi2jl1 = abjl(1);
        abi2jl2 = abjl(2);
      end      
    abk =  []; abk = abj((abi2jl1+1):(abi2jl2-1));
    s1 =  []; s1 = abk;
  else
    s1 = ' ';
  end
  if length(s1)==0
    s1 = ' ';
  end
else
% NOT 'RES', 'CAP' -------------
  s1ind2 = 2;
  s1ind3 = 3;
  if length(abi)>2
    abj =  []; abj = t1(abi(2)+1:abi(3)-1);
    abjl = []; abjl = find(abj-''''==0);
      if length(abjl) > 1
        abi2jl1 = abjl(1);
        abi2jl2 = abjl(2);
      end      
    abk =  []; abk = abj((abi2jl1+1):(abi2jl2-1));
    s1 =  []; s1 = abk;
  else
    s1 = ' ';
  end
  if length(s1)==0
    s1 = ' ';
  end

  if (sum(abs(drawtype-'node'))==0)|(sum(abs(drawtype-'arrw'))==0  )
    if length(abi)>3
      abj =  []; abj = t1(abi(3)+1:abi(4)-1);
      s2 =  []; s2 = eval(abj);
    else
      s2 = 0;
    end
    if length(s2)==0
      s2 = 0;
    end
  elseif sum(abs(drawtype-'text'))==0
    s2 = 0;
  elseif sum(abs(drawtype-'outx'))==0
    if length(abi)>3
      abj =  []; abj = t1(abi(3)+1:abi(4)-1);
      s2 =  []; s2 = eval(abj);
    else
      s2 = 0;
    end
    if length(s2)==0
      s2 = 0;
    end
  elseif sum(abs(drawtype-'inxx'))==0
    if length(abi)>3
      abj =  []; abj = t1(abi(3)+1:abi(4)-1);
      s2 =  []; s2 = eval(abj);
    else
      s2 = 0;
    end
    if length(s2)==0
      s2 = 0;
    end
  end
end

