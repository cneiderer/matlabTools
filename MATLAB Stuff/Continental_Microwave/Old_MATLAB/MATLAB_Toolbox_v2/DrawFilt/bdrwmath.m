function matrixEn = bdrwmath(matrixE)

% bdrwmath.m    BUTTON: EXPORT TO MATHEMATICA
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

clc
[s1,s2] = size(matrixE);

if s1 > 1

title('MATLAB -> Mathematica')

disp(' ')

a3 = ' ';  a5 = ' ';

for indEp = 1:s1-1

indE = indEp+1;

if (indE>1)&(indE<s1+1)

t1 = matrixE(indE,:);
i1 = find(t1-','==0);

msi1 =  max(size(i1));
msi2 =  max(size(t1));

if     msi1 > 0
  a01 = t1(1:i1(1)-1);
  msi3 =  max(size(a01));
  ii1 = find(a01-'('==0);
  msi4 =  max(size(ii1));
  if     msi4 > 0
    a0 = t1(1 : ii1(1)-1);
    a1 = t1(ii1(1)+1 : msi3);
    a1(length(a1))=[]; a1(1:2)=[]; a1=['x[[' a1 ']]'];
  end
  newa = ' ';
  newa = [];
  if     msi4 > 0
% ###################################### change name
    a0M = a0;
    if length(a0)==6
      a0(7)= ' ';
    end
    if sum(abs(a0(1:7) - 'drawin ')) == 0
      a0M(1:6) = 'DrawIn';
      a0M(7) = ' ';
      a0M(7) = [];
    end
    if sum(abs(a0(1:7) - 'drawadd')) == 0
      a0M(1:7) = 'DrawAdd';
    end
    if sum(abs(a0(1:7) - 'drawblo')) == 0
      a0M(1:7) = 'DrawBlo';
    end
    if sum(abs(a0(1:7) - 'drawcap')) == 0
      a0M(1:7) = 'DrawCap';
    end
    if sum(abs(a0(1:7) - 'drawcc ')) == 0
      a0M(1:6) = 'DrawCC';
    end
    if sum(abs(a0(1:7) - 'drawccs')) == 0
      a0M(1:7) = 'DrawCCS';
    end
    if sum(abs(a0(1:7) - 'drawcs ')) == 0
      a0M(1:6) = 'DrawCS';
    end
    if sum(abs(a0(1:7) - 'drawcvs')) == 0
      a0M(1:7) = 'DrawCVS';
    end
    if sum(abs(a0(1:7) - 'drawdel')) == 0
      a0M(1:7) = 'DrawDel';
    end
    if sum(abs(a0(1:7) - 'drawimp')) == 0
      a0M(1:7) = 'DrawImp';
    end
    if sum(abs(a0(1:7) - 'drawlhv')) == 0
      a0M(1:7) = 'DrawLHV';
    end
    if sum(abs(a0(1:7) - 'drawlnd')) == 0
      a0M(1:7) = 'DrawLnd';
    end
    if sum(abs(a0(1:7) - 'drawlvh')) == 0
      a0M(1:7) = 'DrawLVH';
    end
    if sum(abs(a0(1:7) - 'drawota')) == 0
      a0M(1:7) = 'DrawOTA';
    end
    if sum(abs(a0(1:7) - 'drawout')) == 0
      a0M(1:7) = 'DrawOut';
    end
    if sum(abs(a0(1:7) - 'drawres')) == 0
      a0M(1:7) = 'DrawRes';
    end
    if sum(abs(a0(1:7) - 'drawvs ')) == 0
      a0M(1:6) = 'DrawVS';
    end

    if length(a0)==8
      if sum(abs(a0(1:8) - 'drawarrw')) == 0
        a0M(1:8) = 'DrawArrw';
      end
      if sum(abs(a0(1:8) - 'drawline')) == 0
        a0M(1:8) = 'DrawLine';
      end
      if sum(abs(a0(1:8) - 'drawgrnd')) == 0
        a0M(1:8) = 'DrawGrnd';
      end
      if sum(abs(a0(1:8) - 'drawmult')) == 0
        a0M(1:8) = 'DrawMult';
      end
      if sum(abs(a0(1:8) - 'drawnode')) == 0
        a0M(1:8) = 'DrawNode';
      end
      if sum(abs(a0(1:8) - 'drawopam')) == 0
        a0M(1:8) = 'DrawOpAm';
      end
      if sum(abs(a0(1:8) - 'draw4tbl')) == 0
        a0M(1:8) = 'Draw4TBL';
      end
      if sum(abs(a0(1:8) - 'drawtext')) == 0
        a0M(1:8) = 'DrawText';
      end
      if sum(abs(a0(1:8) - 'drawupsa')) == 0
        a0M(1:8) = 'DrawUpSa';
      end
      if sum(abs(a0(1:8) - 'drawdown')) == 0
        a0M(1:8) = 'DrawDown';
      end
    end

    newa = [a0M '[' a1];
  end
  if msi1 > 1
    a2 = t1(i1(1)+1:i1(2)-1);
    abi=0;abi=[];abi = find(a2-' '==0); 
    if isempty(abi) == 0
      for ind = length(abi):-1:1
        a2(abi(ind)) =[];
      end
    end
    a2(length(a2))=[]; a2(1:2)=[]; a2=['y[[' a2 ']]'];
    if msi1 > 2
      a3 = t1(i1(2)+1:i1(3)-1);
      abi=0;abi=[];abi = find(a3-' '==0); 
      if isempty(abi) == 0
        for ind = length(abi):-1:1
          a3(abi(ind)) =[];
        end
      end

if a3(1)=='y'
    a3(length(a3))=[]; a3(1:2)=[]; a3=['y[[' a3 ']]'];
elseif a3(1)=='x'
    a3(length(a3))=[]; a3(1:2)=[]; a3=['x[[' a3 ']]'];
elseif (sum(abs(a0(1:7)-'drawnod'))==0)|...
  (sum(abs(a0(1:7)-'drawin '))==0)|...
  (sum(abs(a0(1:7)-'drawarr'))==0)|...
  (sum(abs(a0(1:7)-'drawout'))==0|sum(abs(a0(1:7)-'drawtex'))== 0)
  a3(1) = []; a3(length(a3)) = [];
  a3 = ['"' a3 ' "'];
end

      if msi1 > 3
        a4 = t1(i1(3)+1:i1(4)-1);
        abi=0;abi=[];abi = find(a4-' '==0); 
        if isempty(abi) == 0
          for ind = length(abi):-1:1
            a4(abi(ind)) =[];
          end
        end
  if (sum(abs(a0(1:7)-'drawgrn'))==0)
    a4 = a4;
  elseif sum(abs(a0(1:7) - 'drawadd')) > 0
    if a4(1)=='y'
        a4(length(a4))=[]; a4(1:2)=[]; a4=['y[[' a4 ']]'];
    elseif a4(1)=='x'
        a4(length(a4))=[]; a4(1:2)=[]; a4=['x[[' a4 ']]'];
    elseif (sum(abs(a0(1:7)-'drawnod'))>0)&...
      (sum(abs(a0(1:7)-'drawin ')) >0)&... 
      (sum(abs(a0(1:7)-'drawarr')) >0)&...
      (sum(abs(a0(1:7)-'drawout')) > 0)&...
      (sum(abs(a0(1:7)-'drawtex')) > 0)
       a4(1)='"'; a4(length(a4))=' ';  a4(length(a4)+1)='"'; 
  end
end
        if msi1 > 4
          a5 = t1(i1(4)+1:i1(5)-1);
          abi=0;abi=[];abi = find(a5-' '==0); 
          if isempty(abi) == 0
            for ind = length(abi):-1:1
              a5(abi(ind)) =[];
            end
          end
        end
a5lold = a5;
if sum(abs(a0(1:7) - 'drawadd')) > 0
  if a5(1)=='y'
      a5(length(a5))=[]; a5(1:2)=[]; a5=['y[[' a5 ']]'];
  elseif a5(1)=='x'
      a5(length(a5))=[]; a5(1:2)=[]; a5=['x[[' a5 ']]'];
  elseif (sum(abs(a0(1:7)-'drawnod'))>0)&(sum(abs(a0(1:7)-'drawin '))>0)&...
   (sum(abs(a0(1:7)-'drawarr'))>0)&...
   (sum(abs(a0(1:7) - 'drawout')) > 0)
      a5(1)='"'; a5(length(a5))=' ';  a5(length(a5)+1)='"'; 
  elseif (sum(abs(a0(1:7) - 'drawnod')) == 0)
      a5 = '1'; 
  end
end
      end
    end
  end
end

if     msi1 > 5
  a6 = t1(i1(5)+1:i1(6)-1);
          abi=0;abi=[];abi = find(a6-' '==0); 
          if isempty(abi) == 0
            for ind = length(abi):-1:1
              a6(abi(ind)) =[];
            end
          end
  if msi1 > 6
    a7 = t1(i1(6)+1:i1(7)-1);
          abi=0;abi=[];abi = find(a7-' '==0); 
          if isempty(abi) == 0
            for ind = length(abi):-1:1
              a7(abi(ind)) =[];
            end
          end
    if msi1 > 7
      a8 = t1(i1(7)+1:i1(8)-1);
          abi=0;abi=[];abi = find(a8-' '==0); 
          if isempty(abi) == 0
            for ind = length(abi):-1:1
              a8(abi(ind)) =[];
            end
          end
      if msi1 > 8
        a9 = t1(i1(8)+1:i1(9)-1);
          abi=0;abi=[];abi = find(a9-' '==0); 
          if isempty(abi) == 0
            for ind = length(abi):-1:1
              a9(abi(ind)) =[];
            end
          end
        if msi1 > 9
          a10 = t1(i1(9)+1:i1(10)-1);
          abi=0;abi=[];abi = find(a10-' '==0); 
          if isempty(abi) == 0
            for ind = length(abi):-1:1
              a10(abi(ind)) =[];
            end
          end
        end
      end
    end
  end
end

aend =  t1(i1(msi1)+1:msi2);
          abi=0;abi=[];abi = find(aend-' '==0); 
          if isempty(abi) == 0
            for ind = length(abi):-1:1
              aend(abi(ind)) =[];
            end
          end

  if sum(abs(a0(1:7) - 'drawadd')) == 0
    a7(1)='"'; a7(length(a7))=' ';  a7(length(a7)+1)='"'; 
  end
end

if sum(abs(a0(1:7) - 'drawlhv')) == 0
  a5=a5lold;
end
if sum(abs(a0(1:7) - 'drawlvh')) == 0
  a5=a5lold;
end



if     msi1 > 0
  if msi1 > 1
    newa = [newa ',' a2];
    if msi1 > 2
      newa = [newa ',' a3];
      if msi1 > 3
        newa = [newa ',' a4];
        if msi1 > 4
          newa = [newa ',' a5];
        end
      end
    end
  end
end
if     msi1 > 5
  newa = [newa ',' a6];
  if msi1 > 6
    newa = [newa ',' a7];
    if msi1 > 7
      newa = [newa ',' a8];
      if msi1 > 8
        newa = [newa ',' a9];
        if msi1 > 9
          newa = [newa ',' a10];
        end
      end
    end
  end
end

      newa = [newa '],'];

matrixE(indE,1:61) ='                                                             ';
matrixE(indE,1:length(newa))=newa;

end

matrixEn = matrixE;

delete drawmath.m
diary  drawmath.m
timedraw = clock;
tmpstr = ['(* creation date: ' date '  time: ' num2str(timedraw(4)) ':' num2str(timedraw(5)) '*)'];

disp(' ')
disp('(*  DrawMath                                                      ')
disp('     Filter realization generated from DrawFilt  v2.1             ')
disp('                                                                  ')
disp('                 Draw Filter Realizations                         ')
disp('                                                                  ')
disp('   Authors: Miroslav D. Lutovac, Dejan V. Tosic, 1999/02/21       ')
disp('   lutovac@iritel.bg.ac.yu    http://galeb.etf.bg.ac.yu/~lutovac/ ')
disp('   tosic@galeb.etf.bg.ac.yu   http://www.rcub.bg.ac.yu/~tosicde/  ')
disp('   Copyright (c) 1999-2000 by Lutovac & Tosic                     ')
disp('   $Revision: 1.21 $  $Date: 2000/10/03 13:45$                    ')
disp('                                                                  ')
disp('   See also:                                                      ')
disp('   Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans            ')
disp('        Filter Design for Signal Processing                       ')
disp('           Using MATLAB and Mathematica                           ')
disp('        Prentice Hall - ISBN 0-201-36130-2                        ')
disp('         http://www.prenhall.com/lutovac                          ')
disp('                                                                  ')
disp('   call:                                                          ')
disp('   SetDirectory["C:\\AFD\\DRAWFILT"];                             ')
disp('   SetDirectory[HomeDirectory[]];                                 ')
disp('   <<AFD\DrawFilt\drawflib.m                                      ')
disp('   <<AFD\DrawFilt\drawmath.m                                      ')
disp('   DrawMath[0,0,1,5,10];                                       *) ')
    
disp(tmpstr)
disp('Nx = 7;')
disp('Ny = 5;')
disp('x0 = 0;')
disp('y0 = 0;')
disp('dx = 4;')
disp('x = x0+Table[i*dx/4,{i,4*Nx}];')
disp('y = y0+Table[i*dx/4,{i,4*Ny}];')
disp('DrawMath[x0_,y0_,dx_,ds_,F_:8] := Module[{')
disp('x = x0+Table[i*dx,{i,50}],  y = y0+Table[i*dx,{i,50}]},')
disp('Show[{')
disp(matrixE)
disp('{}')
disp('}')
disp(',AspectRatio -> Automatic,Axes -> False, PlotRange -> All]];')
disp(' (* DrawMath[0,0,1,4*1/0.8,10]; *) ')
end
diary  off
end
