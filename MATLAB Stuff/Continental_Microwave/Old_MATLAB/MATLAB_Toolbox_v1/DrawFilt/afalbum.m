% afalbum.m    ALBUM OF ANALOG FILTER REALIZATIONS (main script)
%           
%   Authors: Miroslav D. Lutovac, Dejan V. Tosic, 1999/02/21
%   lutovac@iritel.bg.ac.yu    http://galeb.etf.bg.ac.yu/~lutovac/
%   tosic@galeb.etf.bg.ac.yu   http://www.rcub.bg.ac.yu/~tosicde/
%   Copyright (c) 1999-2000 by Lutovac & Tosic
%   $Revision: 1.21 $  $Date: 2000/10/03 13:45$
%       
%   References:
%   [1] Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans
%       Filter Design for Signal Processing
%        Using MATLAB and Mathematica
%       Prentice Hall - ISBN 0-201-36130-2 
%        http://www.prenhall.com/lutovac
%   [2] G. S. Moschytz, P. Horn
%       Active Filter Design Handbook
%       John Wiley, New York, 1981
%       
                         
% This file is part of DrawFilt toolbox for MATLAB.
% Refer to the file LICENSE.TXT for full details.
%                        
% DrawFilt version 2.1, Copyright (C) 1999-2000 M. Lutovac and D. Tosic
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

clear all; close all

% ============  Default directory  ========================|
%                                                          |
NEWpathname = lower('c:\afd\DrawFilt'); % Default directory|
%                                                          |
% =========================================================|

NEWpathnames = ['''' NEWpathname ''''];
cdNEWpathname = ['cd ' NEWpathname '; afalbum;'];

MYMpathname = path;
MYMpathnamen1 = findstr(lower(MYMpathname),lower('DrawFilt'));
if length(MYMpathnamen1) > 0
  MYMpathnamesa = find(MYMpathname(1:MYMpathnamen1)==';');
  if length(MYMpathnamesa) > 0
    MYMpathnamen2 = MYMpathnamesa(length(MYMpathnamesa));
    MYpathname = MYMpathname(MYMpathnamen2+1:MYMpathnamen1+7);
  else
    MYpathname = MYMpathname(1:MYMpathnamen1+7);
  end
else
  MYpathname = lower('c:\afd\DrawFilt');
end
MYpathnames = ['''' MYpathname ''''];
cdMYpathname = ['cd ' MYpathname '; afalbum;'];
pathnamea = lower(pwd);
lpathnamea = length(pathnamea);

if lpathnamea > 7
  epathnamea = sum(abs(pathnamea(lpathnamea-7:lpathnamea)-lower('DrawFilt')));
else
  epathnamea = 1;
end

fig1 = figure; axis off;
xx=get(fig1,'Position')-[100 50 -160 -100];

set(fig1, 'Name', 'Album of Analog Filter Realizations v2.1'...
       , 'Position', [50 20 650 500] ...
       , 'NumberTitle', 'off' ...
       , 'NextPlot', 'replace' )
whitebg(fig1,[1 1 0.9]);


text(0,1.05,'Album of Analog Filter Realizations', 'FontWeight', 'bold', 'FontName', 'Helvetica')
text(-0.03,0.99,...
'DrawFilt version 2.1, Copyright (C) 1999-2000 M.Lutovac and D.Tosic', 'FontWeight', 'bold','FontSize',10, 'FontName', 'Helvetica')
text(0,0.94,...
'This is free software; see LICENSE.TXT for details','FontSize',8, 'FontName', 'Helvetica')

if epathnamea == 0

afalbut;

set(gcf,'DefaultTextColor','b')
text(0.0,0.88,'CLICK a button to see a filter realization', 'FontWeight', 'bold', 'FontAngle', 'normal', 'FontName', 'Helvetica')

text(0.0,0.77,'LP  =  LowPass', 'FontName', 'Helvetica')
text(0.0,0.72,'HP  =  HighPass', 'FontName', 'Helvetica')
text(0.0,0.67,'BP  =  BandPass', 'FontName', 'Helvetica')
text(0.0,0.62,'BR  =  Band Reject', 'FontName', 'Helvetica')
text(0.0,0.57,'LPN  =  LowPass Notch', 'FontName', 'Helvetica')
text(0.0,0.52,'HPN  =  HighPass Notch', 'FontName', 'Helvetica')
text(0.0,0.47,'AP  =  AllPass', 'FontName', 'Helvetica')

text(0.50,0.77,'LQ  =  Low Q-factor', 'FontName', 'Helvetica')
text(0.50,0.72,'MQ  =  Medium Q-factor', 'FontName', 'Helvetica')
text(0.50,0.67,'HQ  =  High Q-factor', 'FontName', 'Helvetica')

text(0.0,0.39,'KHN  =  Kerwin Huelsman Newcomb', 'FontName', 'Helvetica')
text(0.0,0.34,'SK2B  =  Sallen Key 2 cascaded Biquads', 'FontName', 'Helvetica')
text(0.0,0.29,'CCSK  =  Current Conveyor Sallen Key', 'FontName', 'Helvetica')
text(0.0,0.24,'OTA  =  Operational Transconductance Amplifier', 'FontName', 'Helvetica')
text(0.0,0.19,'RLC  =  R-terminated LC ladder', 'FontName', 'Helvetica')
set(gcf,'DefaultTextColor','k')

else
  set(gcf,'DefaultTextColor','m')
  text(0.0,0.85,'Your current working directory is', 'FontName', 'Helvetica')
  text(0.0,0.77,pathnamea)
  set(gcf,'DefaultTextColor','r')
  text(0.0,0.66,'Change your working directory', 'FontWeight', 'bold', 'FontName', 'Helvetica')
  text(0.0,0.56,'to the directory where DrawFilt has been installed.', 'FontName', 'Helvetica')
  set(gcf,'DefaultTextColor','b')
  text(0.0,0.44,'For example, switch to the command window', 'FontWeight', 'bold', 'FontName', 'Helvetica')
  text(0.0,0.36,'and issue a command like this cd c:\afd\DrawFilt', 'FontName', 'Helvetica')
  text(0.0,0.28,'or CLICK a button to change or', 'FontName', 'Helvetica')
  text(0.0,0.20,'browse to find directory DrawFilt', 'FontName', 'Helvetica')
  set(gcf,'DefaultTextColor','k')

  uiCLOSE = uicontrol('String', 'CLOSE', 'Units', 'normalized' ...
     , 'Position', [0.88 0.7 0.1 0.1] ...
     , 'CallBack', 'close(gcf)');

 uitextCD = uicontrol('Style', 'text', 'Units', 'normalized' ...
    , 'HorizontalAlignment', 'center', 'BackgroundColor',[0.5 0.99 0.99] ...
    , 'Position', [0.62 0.02 0.38 0.275] ...
    , 'String',   'Change working directory to');

  uiCDMY = uicontrol('String', MYpathname, 'Units', 'normalized' ...
     , 'Position', [0.63 0.175 0.36 0.07] ...
     , 'CallBack', cdMYpathname);

  % Change directory to DrawFilt and select the file afalbum.m
  uiBROWSE = uicontrol('String', 'Browse to find directory DrawFilt', 'Units', 'normalized' ...
     , 'Position', [0.63 0.025 0.36 0.07] ...
     , 'CallBack', ...
   ['[browsefile,browsepath] = uigetfile(''afalbum.m'',' ...
   ' ''Change directory to DrawFilt and select the file afalbum.m'');' ...
   'if browsepath>0;browsepath1=browsepath(1:length(browsepath)-1);' ...
   'eval([''cd '',browsepath1]);afalbum;end']);

  testNEWpathname = [NEWpathname '\afalbum.m'];
  % test the existence of the NEWpathname and the file afalbum.m
  if exist(testNEWpathname) == 2
    % create the button if the file and directory exist
    uiCDNEW = uicontrol('String', NEWpathname, 'Units', 'normalized' ...
     , 'Position', [0.63 0.1 0.36 0.07] ...
     , 'CallBack', cdNEWpathname);
  end

end
