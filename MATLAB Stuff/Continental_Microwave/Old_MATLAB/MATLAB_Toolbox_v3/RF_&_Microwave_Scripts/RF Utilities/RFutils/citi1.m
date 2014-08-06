function [Z,Freq]=citi1(pathname)
% Load CITI file (1-Port)
%
% Usage: [Z,Freq]=citi1(pathname)
%
% The files need to be for a 1-port measurement saved with 
% 'Data Only', 'ASCII' options set.
%
% e.g. [Z,Freq]=citi1('c:\matlab\toolbox\rfutils\data01.d1')

% N.Tucker www.activefrance.com 2008

fid_in=fopen(pathname,'r');
if fid_in~=(-1)
  fprintf('\nLoading CITI file %s\n\n',pathname);
  L='dummy';
  while ~(strcmp(L,'SEG_LIST_BEGIN'));
     L=fgetl(fid_in);
  end 

  L=fgetl(fid_in);        % Read the line with Start,Stop,Points in it
  [Row,Col]=size(L);
  L1=L(4:Col);            % Get rid of 'SEG' at the beginning of the line
  [SSP]=sscanf(L1,'%f');  % Retrieve the remaining numeric data into vector SSP
  Start=SSP(1,1);
  Stop=SSP(2,1);
  Points=SSP(3,1);

  L='dummy';
  while ~(strcmp(L,'BEGIN'));
     L=fgetl(fid_in);
  end 

  Index=1;
  L='dummy';
  S11=[0,0];
  while ~(strcmp(L,'END'));
     L=fgetl(fid_in);
     if ~(strcmp(L,'END'));
       SS=sscanf(L,'%f,%f');
       S11(Index,1)=SS(1,1);
       S11(Index,2)=SS(2,1);
       Index=Index+1;
     end
  end 
  fclose(fid_in);
  
  startfreq=Start./1e6;   % Start Freq MHz
  stopfreq=Stop./1e6;     % Stop Freq MHz
  npoints=Points;         % Number of Points

  p=S11(:,1)-j.*S11(:,2);
  Z=((1+p)./(1-p)).*50;
  Z=Z';

  step=((stopfreq-startfreq)./(npoints-1));
  Freq=startfreq:step:stopfreq;
else
   fprintf('\nError opening file, file not found.\n');
end   
