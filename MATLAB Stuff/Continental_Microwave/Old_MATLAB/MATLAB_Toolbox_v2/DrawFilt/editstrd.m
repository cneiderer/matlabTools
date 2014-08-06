% editstr.m   EDIT SCHEMATIC PARAMETERS UTILITY
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


% set figure window ----------------------------------
initsize = [120 120 560 420]+[80 0 0 100];
fig2 = figure(2);
set(fig2, 'Name', 'Edit window' ...
        , 'NumberTitle', 'off' ...
        , 'Position', initsize+[340,-50,-300,-200] ...
        , 'Color',[0.65,0.2,0.85])
delete(gca);
% subplot(2,1,1);
axis off;

% INITIALIZATIONS -------------------------------------------
drawtypecomp1=0; drawtypecomp2=0; drawtypecomp3=0; drawtypecomp4=0; drawtypecomp5=0; drawtypecomp6=0;
typestring = '0|1';
s1 = [];
s2 = '0';
indE = editString(2);
t1   = matrixE(indE,:);
drawtype1 = find(t1-'('==0);

[sizet11,sizet11] = size(drawtype1);

if sizet11 == 0
  drawtype = 'yyyy';
else
  drawtype = t1(5:drawtype1(1)-1);
end
drawtype2 = ['draw' drawtype];
drawtype3 = drawtype;

% [t1,x1,y1,x2,y2,s1,s2,abi] = editstra(editString,matrixE);
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

drawtypecomp1 = sum(abs(drawtype-'resx'))==0|sum(abs(drawtype-'capx'))==0|sum(abs(drawtype-'lndx'))==0|...
                sum(abs(drawtype-'impx'))==0|sum(abs(drawtype-'blox'))==0|sum(abs(drawtype-'4tbl'))==0|...
                sum(abs(drawtype-'opam'))==0|sum(abs(drawtype-'otax'))==0|sum(abs(drawtype-'ccxx'))==0|...
                sum(abs(drawtype-'vsxx'))==0|sum(abs(drawtype-'csxx'))==0|...
                sum(abs(drawtype-'upsa'))==0|sum(abs(drawtype-'down'))==0|...
                sum(abs(drawtype-'mult'))==0|sum(abs(drawtype-'delx'))==0|...
                sum(abs(drawtype-'cvsx'))==0|sum(abs(drawtype-'ccsx'))==0;
drawtypecomp2 = sum(abs(drawtype-'lhvx'))==0|sum(abs(drawtype-'lvhx'))==0|sum(abs(drawtype-'line'))==0;
drawtypecomp3 = sum(abs(drawtype-'grnd'))==0;
drawtypecomp4 = sum(abs(drawtype-'inxx'))==0|sum(abs(drawtype-'outx'))==0|sum(abs(drawtype-'text'))==0|...
                sum(abs(drawtype-'node'))==0|sum(abs(drawtype-'arrw'))==0;
drawtypecomp6 = sum(abs(drawtype-'addx'))==0;

%disp([drawtypecomp1 drawtypecomp2 drawtypecomp3 drawtypecomp4 0 drawtypecomp6])
if drawtypecomp1==1
  % disp('RES CAP LND IMP BLO 4TBL OPAM OTA VS CS OPAM CVS CCS')
  indXY1 = 2;
  indXY2 = 3;
  indLABEL1 = 4;
  indLABEL2 = 5;
  indTYPE1 = 5;
  indTYPE2 = 6;
  % EXTRACT X(2) or Y(2)------------------------------------
  if length(abi)>2
    abj =  []; abj =  t1(abi(indXY1)+1:abi(indXY2)-1);
    abjl = []; abjl = find(abj-'('==0); 
    abjr = []; abjr = find(abj-')'==0); 
    abk =  []; abk = abj((abjl(length(abjl))+1):(abjr(length(abjr))-1));
    abl =  []; abl = eval(abk); xy = abl;
  else
    xy = 0;
  end
  % EXTRACT LABEL -----------------------------------------
  if length(abi)>4
    abj =  []; abj = t1(abi(indLABEL1)+1:abi(indLABEL2)-1);
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
  % EXTRACT TYPE -----------------------------------------
  if length(abi)>5
    abj =  []; abj = t1(abi(indTYPE1)+1:abi(indTYPE2)-1);
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
elseif drawtypecomp2==1
  % disp('LHV LVH LINE')
  indXY1 = 2;
  indXY2 = 3;
  indXY3 = 4;
  indXY4 = 5;
  % EXTRACT X(2) and Y(2)------------------------------------
  if length(abi)>2
    abj =  []; abj =  t1(abi(indXY1)+1:abi(indXY2)-1);
    abjl = []; abjl = find(abj-'('==0); 
    abjr = []; abjr = find(abj-')'==0); 
    abk =  []; abk = abj((abjl(length(abjl))+1):(abjr(length(abjr))-1));
    abl =  []; abl = eval(abk); x2 = abl;
  else
    x2 = 0;
  end
  if length(abi)>3
    abj =  []; abj =  t1(abi(indXY2)+1:abi(indXY3)-1);
    abjl = []; abjl = find(abj-'('==0); 
    abjr = []; abjr = find(abj-')'==0); 
    abk =  []; abk = abj((abjl(length(abjl))+1):(abjr(length(abjr))-1));
    abl =  []; abl = eval(abk); y2 = abl;
  else
    y2 = 0;
  end
  s2 = 0;
  s1 = 'NO LABEL';
elseif drawtypecomp3 == 1
  % disp('GRND')
  s1 = 'NO LABEL';
  if length(abi)>2
    abj =  []; abj = t1(abi(2)+1:abi(3)-1);
    s2 =  []; s2 = eval(abj);
  else
    s2 = 0;
  end
  if length(s2)==0
    s2 = 0;
  end
elseif drawtypecomp4 == 1
  % disp('IN  OUT  TEXT  NODE  ARRW')
  indLABEL1 = 2;
  indLABEL2 = 3;
  indTYPE1 = 3;
  indTYPE2 = 4;
  % EXTRACT TYPE -----------------------------------------
  if length(abi)>3
    abj =  []; abj = t1(abi(indTYPE1)+1:abi(indTYPE2)-1);
    s2 =  []; s2 = eval(abj);
  else
    s2 = 0;
  end
  if length(s2)==0
    s2 = 0;
  end
  if sum(abs(drawtype-'text'))==0
    s2 = 0;
  end
  % EXTRACT LABEL -----------------------------------------
  if length(abi)>2
    abj =  []; abj = t1(abi(indLABEL1)+1:abi(indLABEL2)-1);
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
elseif drawtypecomp6 == 1
  % disp('ADDER')
  indLABEL1 = 6;   indLABEL2 = 7;
  indTYPE1  = 7;   indTYPE2  = 8;
  indTYPER1 = 2;   indTYPER2 = 3;
  indTYPEU1 = 3;   indTYPEU2 = 4;
  indTYPEL1 = 4;   indTYPEL2 = 5;
  indTYPED1 = 5;   indTYPED2 = 6;
  % EXTRACT LABEL -----------------------------------------
  if length(abi)>2
    abj =  []; abj = t1(abi(indLABEL1)+1:abi(indLABEL2)-1);
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
  % EXTRACT TYPE -----------------------------------------
  if length(abi)>7
    abj =  []; abj = t1(abi(indTYPE1)+1:abi(indTYPE2)-1);
    s2 =  []; s2 = eval(abj);
  else
    s2 = 0;
  end
  if length(s2)==0
    s2 = 0;
  end
  % EXTRACT TYPE R -----------------------------------------
  if length(abi)>7
    abj =  []; abj = t1(abi(indTYPER1)+1:abi(indTYPER2)-1);
    s20 =  []; s20 = eval(abj);
  else
    s20 = 0;
  end
  if length(s20)==0
    s20 = 0;
  end
  % EXTRACT TYPE U -----------------------------------------
  if length(abi)>7
    abj =  []; abj = t1(abi(indTYPEU1)+1:abi(indTYPEU2)-1);
    s21 =  []; s21 = eval(abj);
  else
    s21 = 1;
  end
  if length(s21)==0
    s21 = 1;
  end
  % EXTRACT TYPE L -----------------------------------------
  if length(abi)>7
    abj =  []; abj = t1(abi(indTYPEL1)+1:abi(indTYPEL2)-1);
    s22 =  []; s22 = eval(abj);
  else
    s22 = 2;
  end
  if length(s22)==0
    s22 = 2;
  end
  % EXTRACT TYPE D -----------------------------------------
  if length(abi)>7
    abj =  []; abj = t1(abi(indTYPED1)+1:abi(indTYPED2)-1);
    s23 =  []; s23 = eval(abj);
  else
    s23 = 3;
  end
  if length(s23)==0
    s23 = 3;
  end
end

% set callbackStr and edit parameters ----------------
subplot(3,1,3); 
if sum(abs(drawtype-'node'))==0
    typestring = '0|1|2|3|4|5|6|7';
    drawnode(x(5), y(5),' 0', 0, 2, 8, 'w');
    drawnode(x(5), 1.01*y(5),'    1', 1, .1, 8, 'w');
    drawnode(x(5), 1.01*y(5),'2', 2, .1, 8, 'w');
    drawnode(x(5), 1.01*y(5),'3    ', 3, .1, 8, 'w');
    drawnode(x(5), y(5),'4   ', 4, 1, 8, 'w');
    drawnode(x(5), 0.99*y(5),'5    ', 5, .1, 8, 'w');
    drawnode(x(5), 0.99*y(5),'6', 6, .1, 8, 'w');
    drawnode(x(5), 0.99*y(5),'    7', 7, .1, 8, 'w');
    callbackStrf = 's2old = s2; s2new = num2str(get(gco,''value'')-1); s2low1 =abi(3)+1; s2hihg1 =abi(4)-1;';
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'arrw'))==0
    typestring = '0|1|2|3|4|5|6|7';
    drawarrw(1.06*x(5), y(5),'0', 0, 1, 8, 'w');
    drawarrw(x(5), 1.07*y(5),'1', 1, 1, 8, 'w');
    drawarrw(0.90*x(5), y(5),'2', 2, 1, 8, 'w');
    drawarrw(x(5), 0.97*y(5),'3', 3, 1, 8, 'w');
    drawarrw(1.10*x(5), y(5),'4', 4, 1, 8, 'w');
    drawarrw(x(5), 1.04*y(5),'5', 5, 1, 8, 'w');
    drawarrw(0.94*x(5), y(5),'6', 6, 1, 8, 'w');
    drawarrw(x(5), 0.93*y(5),'7', 7, 1, 8, 'w');
    callbackStrf = 's2old = s2; s2new = num2str(get(gco,''value'')-1); s2low1 =abi(3)+1; s2hihg1 =abi(4)-1;';
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'text'))==0
    typestring = '0';
    drawtext(x(5), y(5),s1, 9, 'w');
    callbackStrf = 's2 = []; s2 = 0;';
elseif sum(abs(drawtype-'xxxx'))==0
    typestring = '0';
    drawtext(x(5), y(5),'xxxx', 9, 'w');
    callbackStrf = 's2 = []; s2 = 0;';
elseif sum(abs(drawtype-'outx'))==0
    typestring = '0|1|2|3';
    drawout(1.05*x(5), y(5),'0', 0, 1, 8, 'w');
    drawout(x(5), 1.025*y(5),'1', 1, 1, 8, 'w');
    drawout(0.95*x(5), y(5),'2', 2, 1, 8, 'w');
    drawout(x(5), 0.975*y(5),'3', 3, 1, 8, 'w');
    drawtext(x(5), 0.99*y(5), '(x,y)', 8, 'w');  
    callbackStrf = 's2old = s2; s2new = num2str(get(gco,''value'')-1); s2low1 =abi(3)+1; s2hihg1 =abi(4)-1;';
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'inxx'))==0
    typestring = '0|1|2|3';
    drawin(1.05*x(5), y(5),'0', 0, 1, 8, 'w');
    drawin(x(5), 1.025*y(5),'1', 1, 1, 8, 'w');
    drawin(0.95*x(5), y(5),'2', 2, 1, 8, 'w');
    drawin(x(5), 0.975*y(5),'3', 3, 1, 8, 'w');
    drawtext(x(5), 0.99*y(5), '(x,y)', 8, 'w');  
    callbackStrf = 's2old = s2; s2new = num2str(get(gco,''value'')-1); s2low1 =abi(3)+1; s2hihg1 =abi(4)-1;';
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'resx'))==0
    typestring = '0|1|2|3';
    drawres(x(5), y(10), x(15), ' ', 'R0' ,0, ds/2, 8, 'w');
    drawres(x(5), y(5), y(10), ' ', 'R1' ,1, ds/2, 8, 'w');
    drawres(x(5), y(5), x(15), ' ', 'R2' ,2, ds/2, 8, 'w');
    drawres(x(15), y(5), y(10), ' ', 'R3' ,3, ds/2, 8, 'w');
    drawnode(x(5), y(5),'(x2,y2)', 6, 0.5, 8, 'w');
    drawnode(x(15), y(5),'(x,y)', 6, 0.5, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 2, 0.5, 8, 'w');
    drawnode(x(15), y(10),'(x2,y2)', 2, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2on=abs(s2old-2*fix(s2old/2)-s2newn+2*fix(s2newn/2));'];
    callbackStrf = [callbackStrf ', if s2on==1; s2new=num2str(s2old); s2newn=s2old;s2=s2old; end;'];
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'capx'))==0
    typestring = '0|1|2|3';
    drawcap(x(5), y(10), x(15), ' ', 'C0' ,0, ds/2, 8, 'w');
    drawcap(x(5), y(5), y(10), ' ', 'C1' ,1, ds/2, 8, 'w');
    drawcap(x(5), y(5), x(15), ' ', 'C2' ,2, ds/2, 8, 'w');
    drawcap(x(15), y(5), y(10), ' ', 'C3' ,3, ds/2, 8, 'w');
    drawnode(x(5), y(5),'(x2,y2)', 6, 0.5, 8, 'w');
    drawnode(x(15), y(5),'(x,y)', 6, 0.5, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 2, 0.5, 8, 'w');
    drawnode(x(15), y(10),'(x2,y2)', 2, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2on=abs(s2old-2*fix(s2old/2)-s2newn+2*fix(s2newn/2));'];
    callbackStrf = [callbackStrf ', if s2on==1; s2new=num2str(s2old); s2newn=s2old;s2=s2old; end;'];
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'lndx'))==0
    typestring = '0|1|2|3';
    drawlnd(x(5), y(10), x(15), ' ', 'L0' ,0, ds/2, 8, 'w');
    drawlnd(x(5), y(5), y(10), ' ', 'L1' ,1, ds/2, 8, 'w');
    drawlnd(x(5), y(5), x(15), ' ', 'L2' ,2, ds/2, 8, 'w');
    drawlnd(x(15), y(5), y(10), ' ', 'L3' ,3, ds/2, 8, 'w');
    drawnode(x(5), y(5),'(x2,y2)', 6, 0.5, 8, 'w');
    drawnode(x(15), y(5),'(x,y)', 6, 0.5, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 2, 0.5, 8, 'w');
    drawnode(x(15), y(10),'(x2,y2)', 2, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2on=abs(s2old-2*fix(s2old/2)-s2newn+2*fix(s2newn/2));'];
    callbackStrf = [callbackStrf ', if s2on==1; s2new=num2str(s2old); s2newn=s2old;s2=s2old; end;'];
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'impx'))==0
    typestring = '0|1|2|3';
    drawimp(x(5), y(10), x(15), ' ', 'Z0' ,0, ds/2, 8, 'w');
    drawimp(x(5), y(5), y(10), ' ', 'Z1' ,1, ds/2, 8, 'w');
    drawimp(x(5), y(5), x(15), ' ', 'Z2' ,2, ds/2, 8, 'w');
    drawimp(x(15), y(5), y(10), ' ', 'Z3' ,3, ds/2, 8, 'w');
    drawnode(x(5), y(5),'(x2,y2)', 6, 0.5, 8, 'w');
    drawnode(x(15), y(5),'(x,y)', 6, 0.5, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 2, 0.5, 8, 'w');
    drawnode(x(15), y(10),'(x2,y2)', 2, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2on=abs(s2old-2*fix(s2old/2)-s2newn+2*fix(s2newn/2));'];
    callbackStrf = [callbackStrf ', if s2on==1; s2new=num2str(s2old); s2newn=s2old;s2=s2old; end;'];
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'opam'))==0
    typestring = '0|1|2|3';
    drawopam(x(5), y(10), x(10), ' ', 'A0' ,0, ds, 8, 'w');
    drawopam(x(5), y(5), x(10), ' ', 'A1' ,1, ds, 8, 'w');
    drawopam(x(12), y(10), x(17), ' ', 'A2' ,2, ds, 8, 'w');
    drawopam(x(12), y(5), x(17), ' ', 'A3' ,3, ds, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 4, 0.5, 8, 'w');
    drawnode(x(10), y(10),'(x2,y2)', 6, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'otax'))==0
    typestring = '0|1|2|3';
    drawota(x(5), y(10), x(10), ' ', 'g0' ,0, ds, 8, 'w');
    drawota(x(5), y(5), x(10), ' ', 'g1' ,1, ds, 8, 'w');
    drawota(x(12), y(10), x(17), ' ', 'g2' ,2, ds, 8, 'w');
    drawota(x(12), y(5), x(17), ' ', 'g3' ,3, ds, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 4, 0.5, 8, 'w');
    drawnode(x(10), y(10),'(x2,y2)', 6, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'ccxx'))==0
    typestring = '0|1|2|3';
    drawcc(x(5), y(10), x(10), ' ', 'a0' ,0, ds, 8, 'w');
    drawcc(x(5), y(5), x(10), ' ', 'a1' ,1, ds, 8, 'w');
    drawcc(x(12), y(10), x(17), ' ', 'a2' ,2, ds, 8, 'w');
    drawcc(x(12), y(5), x(17), ' ', 'a3' ,3, ds, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 4, 0.5, 8, 'w');
    drawnode(x(10), y(10),'(x2,y2)', 6, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'4tbl'))==0
    typestring = '0|1|2|3';
    draw4tbl(x(5), y(10), x(10), ' ', 'h0' ,0, ds, 8, 'w');
    draw4tbl(x(5), y(5), x(10), ' ', 'h1' ,1, ds, 8, 'w');
    draw4tbl(x(12), y(10), x(17), ' ', 'h2' ,2, ds, 8, 'w');
    draw4tbl(x(12), y(5), x(17), ' ', 'h3' ,3, ds, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 4, 0.5, 8, 'w');
    drawnode(x(10), y(10),'(x2,y2)', 6, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'blox'))==0
    typestring = '0|1|2|3|4|5|6|7|8|9';
    drawblo(x(5), y(10), x(15), ' ', 'H0' ,0, ds, 7, 'w');
    drawblo(x(5), y(5), y(10), ' ', 'H1' ,1, ds, 7, 'w');
    drawblo(x(5), y(5), x(15), ' ', 'H2' ,2, ds, 7, 'w');
    drawblo(x(15), y(5), y(10), ' ', 'H3' ,3, ds, 7, 'w');
    drawnode(x(5), y(5),'(x2,y2)', 6, 0.5, 8, 'w');
    drawnode(x(15), y(5),'(x,y)', 6, 0.5, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 2, 0.5, 8, 'w');
    drawnode(x(15), y(10),'(x2,y2)', 2, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2on=abs(s2old-2*fix(s2old/2)-s2newn+2*fix(s2newn/2));'];
    callbackStrf = [callbackStrf ', if s2on==1; s2new=num2str(s2old); s2newn=s2old;s2=s2old; end;'];
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'upsa'))==0
    typestring = '0|1|2|3|4|5|6|7';
    drawupsa(x(5), y(10), x(15), ' ', '0' ,0, ds, 7, 'w');
    drawupsa(x(5), y(5), y(10), ' ', '1' ,1, ds, 7, 'w');
    drawupsa(x(5), y(5), x(15), ' ', '2' ,2, ds, 7, 'w');
    drawupsa(x(15), y(5), y(10), ' ', '3' ,3, ds, 7, 'w');
    drawnode(x(5), y(5),'(x2,y2)', 6, 0.5, 8, 'w');
    drawnode(x(15), y(5),'(x,y)', 6, 0.5, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 2, 0.5, 8, 'w');
    drawnode(x(15), y(10),'(x2,y2)', 2, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2on=abs(s2old-2*fix(s2old/2)-s2newn+2*fix(s2newn/2));'];
    callbackStrf = [callbackStrf ', if s2on==1; s2new=num2str(s2old); s2newn=s2old;s2=s2old; end;'];
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'down'))==0
    typestring = '0|1|2|3|4|5|6|7';
    drawdown(x(5), y(10), x(15), ' ', '0' ,0, ds, 7, 'w');
    drawdown(x(5), y(5), y(10), ' ', '1' ,1, ds, 7, 'w');
    drawdown(x(5), y(5), x(15), ' ', '2' ,2, ds, 7, 'w');
    drawdown(x(15), y(5), y(10), ' ', '3' ,3, ds, 7, 'w');
    drawnode(x(5), y(5),'(x2,y2)', 6, 0.5, 8, 'w');
    drawnode(x(15), y(5),'(x,y)', 6, 0.5, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 2, 0.5, 8, 'w');
    drawnode(x(15), y(10),'(x2,y2)', 2, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2on=abs(s2old-2*fix(s2old/2)-s2newn+2*fix(s2newn/2));'];
    callbackStrf = [callbackStrf ', if s2on==1; s2new=num2str(s2old); s2newn=s2old;s2=s2old; end;'];
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'delx'))==0
    typestring = '0|1|2|3|4|5|6|7|8|9';
    drawdel(x(5), y(10), x(15), ' ', '-0' ,0, ds, 7, 'w');
    drawdel(x(5), y(5), y(10), ' ', '-1' ,1, ds, 7, 'w');
    drawdel(x(5), y(5), x(15), ' ', '-2' ,2, ds, 7, 'w');
    drawdel(x(15), y(5), y(10), ' ', '-3' ,3, ds, 7, 'w');
    drawnode(x(5), y(5),'(x2,y2)', 6, 0.5, 8, 'w');
    drawnode(x(15), y(5),'(x,y)', 6, 0.5, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 2, 0.5, 8, 'w');
    drawnode(x(15), y(10),'(x2,y2)', 2, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2on=abs(s2old-2*fix(s2old/2)-s2newn+2*fix(s2newn/2));'];
    callbackStrf = [callbackStrf ', if s2on==1; s2new=num2str(s2old); s2newn=s2old;s2=s2old; end;'];
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'mult'))==0
    typestring = '0|1|2|3|4|5|6|7';
    drawmult(x(5), y(10), x(15), ' ', 'a0' ,0, ds, 7, 'w');
    drawmult(x(5), y(5), y(10), ' ', 'a1' ,1, ds, 7, 'w');
    drawmult(x(5), y(5), x(15), ' ', 'a2' ,2, ds, 7, 'w');
    drawmult(x(15), y(5), y(10), ' ', 'a3' ,3, ds, 7, 'w');
    drawnode(x(5), y(5),'(x2,y2)', 6, 0.5, 8, 'w');
    drawnode(x(15), y(5),'(x,y)', 6, 0.5, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 2, 0.5, 8, 'w');
    drawnode(x(15), y(10),'(x2,y2)', 2, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2on=abs(s2old-2*fix(s2old/2)-s2newn+2*fix(s2newn/2));'];
    callbackStrf = [callbackStrf ', if s2on==1; s2new=num2str(s2old); s2newn=s2old;s2=s2old; end;'];
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'vsxx'))==0
    typestring = '0|1|2|3|4|5|6|7';
    drawvs(x(5), y(10), x(15), ' ', 'V0' ,0, ds, 8, 'w');
    drawvs(x(5), y(5), y(10), ' ', 'V1' ,1, ds, 8, 'w');
    drawvs(x(5), y(5), x(15), ' ', 'V2' ,2, ds, 8, 'w');
    drawvs(x(15), y(5), y(10), ' ', 'V3' ,3, ds, 8, 'w');
    drawnode(x(5), y(5),'(x2,y2)', 6, 0.5, 8, 'w');
    drawnode(x(15), y(5),'(x,y)', 6, 0.5, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 2, 0.5, 8, 'w');
    drawnode(x(15), y(10),'(x2,y2)', 2, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2on=abs(s2old-2*fix(s2old/2)-s2newn+2*fix(s2newn/2));'];
    callbackStrf = [callbackStrf ', if s2on==1; s2new=num2str(s2old); s2newn=s2old;s2=s2old; end;'];
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'csxx'))==0
    typestring = '0|1|2|3|4|5|6|7';
    drawcs(x(5), y(10), x(15), ' ', 'I0' ,0, ds, 8, 'w');
    drawcs(x(5), y(5), y(10), ' ', 'I1' ,1, ds, 8, 'w');
    drawcs(x(5), y(5), x(15), ' ', 'I2' ,2, ds, 8, 'w');
    drawcs(x(15), y(5), y(10), ' ', 'I3' ,3, ds, 8, 'w');
    drawnode(x(5), y(5),'(x2,y2)', 6, 0.5, 8, 'w');
    drawnode(x(15), y(5),'(x,y)', 6, 0.5, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 2, 0.5, 8, 'w');
    drawnode(x(15), y(10),'(x2,y2)', 2, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2on=abs(s2old-2*fix(s2old/2)-s2newn+2*fix(s2newn/2));'];
    callbackStrf = [callbackStrf ', if s2on==1; s2new=num2str(s2old); s2newn=s2old;s2=s2old; end;'];
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'cvsx'))==0
    typestring = '0|1|2|3|4|5|6|7';
    drawcvs(x(5), y(10), x(15), ' ', 'V0' ,0, ds, 8, 'w');
    drawcvs(x(5), y(5), y(10), ' ', 'V1' ,1, ds, 8, 'w');
    drawcvs(x(5), y(5), x(15), ' ', 'V2' ,2, ds, 8, 'w');
    drawcvs(x(15), y(5), y(10), ' ', 'V3' ,3, ds, 8, 'w');
    drawnode(x(5), y(5),'(x2,y2)', 6, 0.5, 8, 'w');
    drawnode(x(15), y(5),'(x,y)', 6, 0.5, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 2, 0.5, 8, 'w');
    drawnode(x(15), y(10),'(x2,y2)', 2, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2on=abs(s2old-2*fix(s2old/2)-s2newn+2*fix(s2newn/2));'];
    callbackStrf = [callbackStrf ', if s2on==1; s2new=num2str(s2old); s2newn=s2old;s2=s2old; end;'];
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'ccsx'))==0
    typestring = '0|1|2|3|4|5|6|7';
    drawccs(x(5), y(10), x(15), ' ', 'I0' ,0, ds, 8, 'w');
    drawccs(x(5), y(5), y(10), ' ', 'I1' ,1, ds, 8, 'w');
    drawccs(x(5), y(5), x(15), ' ', 'I2' ,2, ds, 8, 'w');
    drawccs(x(15), y(5), y(10), ' ', 'I3' ,3, ds, 8, 'w');
    drawnode(x(5), y(5),'(x2,y2)', 6, 0.5, 8, 'w');
    drawnode(x(15), y(5),'(x,y)', 6, 0.5, 8, 'w');
    drawnode(x(5), y(10),'(x,y)', 2, 0.5, 8, 'w');
    drawnode(x(15), y(10),'(x2,y2)', 2, 0.5, 8, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2on=abs(s2old-2*fix(s2old/2)-s2newn+2*fix(s2newn/2));'];
    callbackStrf = [callbackStrf ', if s2on==1; s2new=num2str(s2old); s2newn=s2old;s2=s2old; end;'];
    callbackStrf = [callbackStrf ', s2low1 =abi(5)+1; s2hihg1 =abi(6)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'lhvx'))==0
    typestring = '0';
    drawlhv(x(5), y(5), x(10), y(10), 0, 'w');
    drawnode(x(5), y(5),'(x,y)', 4, 0.5, 7, 'w');
    drawnode(x(10), y(10),'(x2,y2)', 1, 0.5, 7, 'w');
    callbackStrf = 's2 = []; s2 = 0;';
elseif sum(abs(drawtype-'lvhx'))==0
    typestring = '0';
    drawlvh(x(5), y(5), x(10), y(10), 0,'w');
    drawnode(x(5), y(5),'(x,y)', 4, 0.5, 7, 'w');
    drawnode(x(10), y(10),'(x2,y2)', 1, 0.5, 7, 'w');
    callbackStrf = 's2 = []; s2 = 0;';
elseif sum(abs(drawtype-'line'))==0
    typestring = '0';
    drawline(x(5), y(5), x(10), y(10),'w');
    drawnode(x(5), y(5),'(x,y)', 4, 0.5, 7, 'w');
    drawnode(x(10), y(10),'(x2,y2)', 1, 0.5, 7, 'w');
    callbackStrf = 's2 = []; s2 = 0;';
elseif sum(abs(drawtype-'grnd'))==0
    typestring = '0|1|2|3';
    drawgrnd(x(5), y(5), 0, 2,'w');
    drawnode(x(5), y(5),'(x,y)', 4, 0.5, 7, 'w');
    drawnode(x(5), y(5),'0', 2, 0.5, 7, 'w');
    drawgrnd(x(6), y(5), 1, 2,'w');
    drawnode(x(6), y(5),'1', 2, 0.5, 7, 'w');
    drawgrnd(x(7), y(5), 2, 2,'w');
    drawnode(x(7), y(5),'2', 6, 0.5, 7, 'w');
    drawgrnd(x(8), y(5), 3, 2,'w');
    drawnode(x(8), y(5),'3', 6, 0.5, 7, 'w');
    callbackStrf = 's2old = s2; s2newn = get(gco,''value'')-1; s2new = num2str(s2newn);';
    callbackStrf = [callbackStrf ', s2low1 =abi(2)+1; s2hihg1 =abi(3)-1;'];
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf = [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf = [callbackStrf ', t1(s2low1:s2hihg1)=s2tmp2;'];
elseif sum(abs(drawtype-'addx'))==0
    typestring = '0|1|2|3';
    typestring1 = '0|1|2|3';
    typestring2 = '0|1|2|3';
    typestring3 = '0|1|2|3';
    typestring4 = '0|1|2|3';
    drawadd(x(12), y(12), 0, 1, 2, 3, 'S', 1, ds/3, F, 'w');
    drawnode(x(14), y(12),' 0 = No Connection', 0, 0.5, 7, 'w');
    drawnode(x(13), y(13),'1 = + input', 2, 0.5, 7, 'w');
    drawnode(x(12), y(12),'2 = output ', 4, 0.5, 7, 'w');
    drawnode(x(13), y(11),'3 = - input', 6, 0.5, 7, 'w');
    callbackStrf = 's2old = s2; s2new = num2str(get(gco,''value'')-1); s2low1 =abi(indTYPE1)+1; s2hihg1 =abi(indTYPE1)-1;';
    callbackStrf = [callbackStrf ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf= [callbackStrf ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf0 = 's2old = s20; s2new = num2str(get(gco,''value'')-1); s2low1 =abi(indTYPER1)+1; s2hihg1 =abi(indTYPER2)-1;';
    callbackStrf0 = [callbackStrf0 ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf0 = [callbackStrf0 ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf0 = [callbackStrf0 ', t1(s2low1:s2hihg1)=s2tmp2;'];
    callbackStrf1 = 's2old = s21; s2new = num2str(get(gco,''value'')-1); s2low1 =abi(indTYPEU1)+1; s2hihg1 =abi(indTYPEU2)-1;';
    callbackStrf1 = [callbackStrf1 ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf1 = [callbackStrf1 ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf1 = [callbackStrf1 ', t1(s2low1:s2hihg1)=s2tmp2;'];
    callbackStrf2 = 's2old = s22; s2new = num2str(get(gco,''value'')-1); s2low1 =abi(indTYPEL1)+1; s2hihg1 =abi(indTYPEL2)-1;';
    callbackStrf2 = [callbackStrf2 ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf2 = [callbackStrf2 ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf2 = [callbackStrf2 ', t1(s2low1:s2hihg1)=s2tmp2;'];
    callbackStrf3 = 's2old = s23; s2new = num2str(get(gco,''value'')-1); s2low1 =abi(indTYPED1)+1; s2hihg1 =abi(indTYPED2)-1;';
    callbackStrf3 = [callbackStrf3 ', s2tmp2 =[]; s2tmp1 = s2hihg1-s2low1+1; s2tmp2 = blanks(s2tmp1);'];
    callbackStrf3 = [callbackStrf3 ', if s2tmp1>1, s2tmp2(length(s2tmp2))=s2new; else, s2tmp2=s2new; end'];
    callbackStrf3 = [callbackStrf3 ', t1(s2low1:s2hihg1)=s2tmp2;'];
end
axis('equal'); axis('off')

% close, save, x= , y= , ... -------------------------
callbackStr = ['editString=[0 1];close(figure(2));'];
callbackStr = [callbackStr 'clf;[x,y]= drawgrid(x0,y0,dx,ds,F,Nx,Ny);'];
callbackStr = [callbackStr 'bdrwredr(x0,y0,dx,ds,F,Nx,Ny,matrixE,dc);'];
callbackStr = [callbackStr 'butdrawd;'];
ebb0close = uicontrol('String', 'close', 'Units', 'normalized' ...
     , 'Position', [0.81 0.9 0.19 0.06] ...
     , 'CallBack', callbackStr);

callbackStre = ['matrixE(indE,:) = t1;'];
callbackStre = [callbackStre 'figure(1);'];
callbackStre = [callbackStre 'clf;[x,y]= drawgrid(x0,y0,dx,ds,F,Nx,Ny);'];
callbackStre = [callbackStre 'bdrwredr(x0,y0,dx,ds,F,Nx,Ny,matrixE,dc);'];
callbackStre = [callbackStre 'butdrawd;'];
callbackStre = [callbackStre 'figure(2);'];
ebb0savee = uicontrol('String', 'apply', 'Units', 'normalized' ...
     , 'Position', [0.81 0.8 0.19 0.06] ...
     , 'CallBack', callbackStre);

et1a = uicontrol('Style', 'text', 'Units', 'normalized' ...
    , 'HorizontalAlignment', 'left', 'BackgroundColor',[0.5 0.99 0.99] ...
    , 'Position', [0.05 0.9 0.25 0.06] ...
    , 'String',   'edit');
et1b = uicontrol('Style', 'text', 'Units', 'normalized' ...
     , 'HorizontalAlignment', 'left', 'BackgroundColor',[0.5 0.99 0.99] ...
     , 'Position', [0.35 0.9 0.3 0.06] ...
     , 'String',   drawtype2);

et2a = uicontrol('Style', 'text', 'Units', 'normalized' ...
    , 'HorizontalAlignment', 'left', 'BackgroundColor',[0.5 0.99 0.99] ...
    , 'Position', [0.05 0.8 0.14 0.06] ...
    , 'String',   'x = ');
et2b = uicontrol('Style', 'text', 'Units', 'normalized' ...
     , 'HorizontalAlignment', 'left', 'BackgroundColor',[0.5 0.99 0.99] ...
     , 'Position', [0.2 0.8 0.15 0.06] ...
     , 'String',   num2str(x1));

et2a2 = uicontrol('Style', 'text', 'Units', 'normalized' ...
    , 'HorizontalAlignment', 'left', 'BackgroundColor',[0.5 0.99 0.99] ...
    , 'Position', [0.4 0.8 0.14 0.06] ...
    , 'String',   'x2 = ');
et2b2 = uicontrol('Style', 'text', 'Units', 'normalized' ...
     , 'HorizontalAlignment', 'left', 'BackgroundColor',[0.5 0.99 0.99] ...
     , 'Position', [0.55 0.8 0.15 0.06] ...
     , 'String',   num2str(x2));

et3a = uicontrol('Style', 'text', 'Units', 'normalized' ...
    , 'HorizontalAlignment', 'left', 'BackgroundColor',[0.5 0.99 0.99] ...
    , 'Position', [0.05 0.7 0.14 0.06] ...
    , 'String',   'y = ');
et3b = uicontrol('Style', 'text', 'Units', 'normalized' ...
     , 'HorizontalAlignment', 'left', 'BackgroundColor',[0.5 0.99 0.99] ...
     , 'Position', [0.2 0.7 0.15 0.06] ...
     , 'String',   num2str(y1));

et3a2 = uicontrol('Style', 'text', 'Units', 'normalized' ...
    , 'HorizontalAlignment', 'left', 'BackgroundColor',[0.5 0.99 0.99] ...
    , 'Position', [0.4 0.7 0.14 0.06] ...
    , 'String',   'y2 = ');
et3b2 = uicontrol('Style', 'text', 'Units', 'normalized' ...
     , 'HorizontalAlignment', 'left', 'BackgroundColor',[0.5 0.99 0.99] ...
     , 'Position', [0.55 0.7 0.15 0.06] ...
     , 'String',   num2str(y2));

bs1newa = uicontrol('Style', 'text', 'Units', 'normalized' ...
    , 'HorizontalAlignment', 'left', 'BackgroundColor',[0.5 0.99 0.99] ...
    , 'Position', [0.05 0.6 0.25 0.06] ...
    , 'String',   'label = ');

if (drawtypecomp1 == 1)|(drawtypecomp4 == 1)
  bs1newb = uicontrol('Style', 'edit' ...
       , 'String', num2str(s1) ...
       , 'Units',    'normalized', 'BackgroundColor',[1 1 1], 'HorizontalAlignment', 'left' ...
       , 'Position', [0.35 0.6 0.325 0.08] ...
       , 'CallBack', ['s1old = s1;' ...
                      's1new=get(bs1newb,''String'');' ...
                      't1 = dinsstra(t1,s1new,abi(indLABEL1),abi(indLABEL2));' ...
                      'matrixEnew(indE,:) = t1;' ...
                      '[t1,x1,y1,x2,y2,s1,s2,abi] = editstra(editString,matrixEnew);' ...
                      's1 = s1new;']);
elseif (drawtypecomp2 == 1)|(drawtypecomp3 == 1)|(drawtypecomp6 == 1)
  bs1newb = uicontrol('Style', 'text' ...
       , 'String', num2str(s1) ...
       , 'Units',    'normalized', 'BackgroundColor',[0.5 0.99 0.99], 'HorizontalAlignment', 'left' ...
       , 'Position', [0.35 0.6 0.325 0.08]);
end
et5a = uicontrol('Style', 'text', 'Units', 'normalized' ...
    , 'HorizontalAlignment', 'left', 'BackgroundColor',[0.5 0.99 0.99] ...
    , 'Position', [0.05 0.5 0.25 0.06] ...
    , 'String',   'type = ');

if drawtypecomp6 == 1
 et5b0 = uicontrol('Style', 'text', 'Units', 'normalized' ...
     , 'HorizontalAlignment', 'left', 'BackgroundColor',[0.5 0.99 0.99] ...
     , 'Position', [0.35 0.5 0.24 0.06] ...
     , 'String',   num2str(s2));
 et5b1 = uicontrol('Style', 'popupmenu' ...
    , 'Units', 'normalized' ...
    , 'HorizontalAlignment', 'left', 'BackgroundColor',[1 1 1] ...
    , 'Position', [0.75 0.25 0.24 0.06] ...
    , 'String', typestring1 ...
    , 'Value', (s20+1) ...
    , 'Interruptible','yes' ...
    , 'Callback',callbackStrf0);
 et5b2 = uicontrol('Style', 'popupmenu' ...
    , 'Units', 'normalized' ...
    , 'HorizontalAlignment', 'left', 'BackgroundColor',[1 1 1] ...
    , 'Position', [0.35 0.4 0.24 0.06] ...
    , 'String', typestring2 ...
    , 'Value', (s21+1) ...
    , 'Interruptible','yes' ...
    , 'Callback',callbackStrf1);
 et5b3 = uicontrol('Style', 'popupmenu' ...
    , 'Units', 'normalized' ...
    , 'HorizontalAlignment', 'left', 'BackgroundColor',[1 1 1] ...
    , 'Position', [0.05 0.25 0.24 0.06] ...
    , 'String', typestring3 ...
    , 'Value', (s22+1) ...
    , 'Interruptible','yes' ...
    , 'Callback',callbackStrf2);
 et5b4 = uicontrol('Style', 'popupmenu' ...
    , 'Units', 'normalized' ...
    , 'HorizontalAlignment', 'left', 'BackgroundColor',[1 1 1] ...
    , 'Position', [0.35 0.00 0.24 0.06] ...
    , 'String', typestring4 ...
    , 'Value', (s23+1) ...
    , 'Interruptible','yes' ...
    , 'Callback',callbackStrf3);
elseif sizet11 == 0
  %  close(figure(2));
else
 et5b = uicontrol('Style', 'popupmenu' ...
    , 'Units', 'normalized' ...
    , 'HorizontalAlignment', 'left', 'BackgroundColor',[1 1 1] ...
    , 'Position', [0.35 0.5 0.24 0.06] ...
    , 'String', typestring ...
    , 'Value', (s2+1) ...
    , 'Interruptible','yes' ...
    , 'Callback',callbackStrf);
end
