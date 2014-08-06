function [S11,S21,S12,S22,Freq]=citi2s(pathname)
% Load CITI file (2-Port)
%
% Usage: [S11,S21,S12,S22,Freq]=citi2s(pathname)
%
% The files need to be for a 2-port measurement saved with 
% 'Data Only', 'ASCII' options set.
%
% e.g. [S11,S21,S12,S22,Freq]=citi2s('c:\matlab\toolbox\rfutils_s\data04.d2')

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
  
  startfreq=Start./1e6;   % Start Freq MHz
  stopfreq=Stop./1e6;     % Stop Freq MHz
  npoints=Points;         % Number of Points

  step=((stopfreq-startfreq)./(npoints-1));
  Freq=startfreq:step:stopfreq;

  
  % Load S11 data
    
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
   S11=S11.';  

  % Load S21 data
    
  L='dummy';
  while ~(strcmp(L,'BEGIN'));
     L=fgetl(fid_in);
  end 
  
  Index=1;
  L='dummy';
  S21=[0,0];
  while ~(strcmp(L,'END'));
     L=fgetl(fid_in);
     if ~(strcmp(L,'END'));
       SS=sscanf(L,'%f,%f');
       S21(Index,1)=SS(1,1);
       S21(Index,2)=SS(2,1);
       Index=Index+1;
     end
  end 
  S21=S21(:,1)+j*S21(:,2);   % Convert S-param to complex form
  S21=S21.';


  % Load S12 data
    
  L='dummy';
  while ~(strcmp(L,'BEGIN'));
     L=fgetl(fid_in);
  end 
  
  Index=1;
  L='dummy';
  S12=[0,0];
  while ~(strcmp(L,'END'));
     L=fgetl(fid_in);
     if ~(strcmp(L,'END'));
       SS=sscanf(L,'%f,%f');
       S12(Index,1)=SS(1,1);
       S12(Index,2)=SS(2,1);
       Index=Index+1;
     end
  end 
  S12=S12(:,1)+j*S12(:,2);   % Convert S-param to complex form
  S12=S12.';  

  % Load S22 data
    
  L='dummy';
  while ~(strcmp(L,'BEGIN'));
     L=fgetl(fid_in);
  end 
  
  Index=1;
  L='dummy';
  S22=[0,0];
  while ~(strcmp(L,'END'));
     L=fgetl(fid_in);
     if ~(strcmp(L,'END'));
       SS=sscanf(L,'%f,%f');
       S22(Index,1)=SS(1,1);
       S22(Index,2)=SS(2,1);
       Index=Index+1;
     end
  end 
  S22=S22(:,1)+j*S22(:,2);   % Convert S-param to complex form
  S22=S22.';

  fclose(fid_in);
else
   fprintf('\nError opening file, file not found.\n');
end   
