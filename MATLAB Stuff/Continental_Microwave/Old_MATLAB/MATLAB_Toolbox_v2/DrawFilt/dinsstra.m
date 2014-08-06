function t2 = dinsstra(t1,s1new,indsa,indsb)

% dinsstra.m   INTERNAL UTILITY
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

lt1 = length(t1);
ls1 = length(s1new);
t2  = t1(1:indsa); t2  = [t2 '''']; t2  = [t2 s1new]; t2  = [t2 ''''];
lt2 = length(t2);
lt3 = lt1-lt2;

lt1b  = find(t1-' ');        lt1b0  = find(abs(t1)-0);
lt1lb = lt1b(length(lt1b));  lt1lb0 = lt1b0(length(lt1b0));
lt1lb = min([lt1lb lt1lb0]);

maxl1 = lt1lb-indsb+1;

if lt1 >= indsb+lt3-1
  t2 = [t2 t1(indsb:indsb+lt3-1)];
else
  t2 = [t2 t1(indsb:lt1)];
  t2 = [t2 blanks(lt1 - length(t2))];
end

if lt3 < (maxl1)
  t2((lt1-maxl1):lt1) = ['''' t1((lt1lb+1-maxl1):lt1lb)];
end
