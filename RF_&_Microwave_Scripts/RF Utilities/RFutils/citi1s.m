function [S11,Freq]=citi1s(pathname)
% Load CITI file (1-Port)
%
% Usage: [S11,Flist]=citi1s(pathname)
%
% The files need to be for a 1-port measurement saved with 
% 'Data Only', 'ASCII' options set.
%
% e.g. [S11,Flist]=citi1s('c:\matlab\toolbox\rfutils\data01.d1')

fid_in=fopen(pathname,'r');
if fid_in~=(-1)
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

  startfreq=Start./1e6;   % Start Freq MHz
  stopfreq=Stop./1e6;     % Stop Freq MHz
  npoints=Points;         % Number of Points

  step=((stopfreq-startfreq)./(npoints-1));
  Freq=startfreq:step:stopfreq;

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
  S11=S11(:,1)+j*S11(:,2);   % Convert S-param to complex form
  fclose(fid_in);

else
   fprintf('\nError opening file, file not found.\n');
end   
