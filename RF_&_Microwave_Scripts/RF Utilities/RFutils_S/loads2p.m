function [S11,S21,S12,S22,Freq]=loads2p(pathname)
% Load S2P file (2-Port)
%
% Usage: [S11,S21,S12,S22,Freq]=loads2p(pathname)
%
% The files need to be for a 2-port measurement saved with 
% 'Data Only', 'ASCII' options set.
%
% e.g. [S11,S21,S12,S22,Freq]=loads2p('c:\matlab\toolbox\rfutils_s\data05.s2p')

% N.Tucker www.activefrance.com 2008

fid_in=fopen(pathname,'r');
if fid_in~=(-1)
  fprintf('\nLoading S2P file %s\n\n',pathname);
     L=fgetl(fid_in);
     L=fgetl(fid_in);
  
  Index=1;
  L='dummy';
 
  S11mag=[0];
  S11pha=[0];
 
  S21mag=[0];
  S21pha=[0];
 
  S12mag=[0];
  S12pha=[0];
 
  S22mag=[0];
  S22pha=[0];
 
  Freq=[0];
  while L~=(-1);
     L=fgetl(fid_in);
     if L~=(-1);
       SS=sscanf(L,'%f');
       
       Freq(Index)=SS(1,1);
       
       S11mag(Index)=SS(2,1);
       S11pha(Index)=SS(3,1)*pi/180;
  
       S21mag(Index)=SS(4,1);
       S21pha(Index)=SS(5,1)*pi/180;

       S12mag(Index)=SS(6,1);
       S12pha(Index)=SS(7,1)*pi/180;

       S22mag(Index)=SS(8,1);
       S22pha(Index)=SS(9,1)*pi/180;
   
       Index=Index+1;
     end
  end 
   S11=S11mag.*(cos(S11pha)+j*sin(S11pha));   % Convert S-param to complex form
    

   S21=S21mag.*(cos(S21pha)+j*sin(S21pha));   % Convert S-param to complex form

  
   S12=S12mag.*(cos(S12pha)+j*sin(S12pha));   % Convert S-param to complex form
 
 
   S22=S22mag.*(cos(S22pha)+j*sin(S22pha));   % Convert S-param to complex form
  
    

  fclose(fid_in);
else
   fprintf('\nError opening file, file not found.\n');
end   
