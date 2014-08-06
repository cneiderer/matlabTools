function [S11,S12,S13,S14,...
          S21,S22,S23,S24,...
          S31,S32,S33,S34,...
          S41,S42,S43,S44,Freq]=loadsonnet4(pathname)
%
% Load Sonnet Lite file (4-Port)
%
% Usage: [S11,S12,S13,S14,...
%         S21,S22,S23,S24,...
%         S31,S32,S33,S34,...
%         S41,S42,S43,S44,Freq]=loadsonnet4(pathname)
%
% The files need to be for a 4-port measurement saved with the following options :-
% 'Spreadsheet','De-Embedded','S-Param','Real-Imag' and Frequency in GHz (default)
%  
% Include Comments....... No
% Include Adaptive Data.. No
% High Precision......... Yes
%
% e.g. [S11,S12,S13,S14,...
%       S21,S22,S23,S24,...
%       S31,S32,S33,S34,...
%       S41,S42,S43,S44,Freq]=loads2p('c:\matlab\toolbox\rfutils_s\data06.son')

% N.Tucker www.activefrance.com 2008

fid_in=fopen(pathname,'r');
if fid_in~=(-1)
  fprintf('\nLoading Sonnet file %s\n\n',pathname);
     L=fgetl(fid_in);
     L=fgetl(fid_in);
  
  Index=1;
  L='dummy';
 
  S11mag=[0];S12mag=[0];S13mag=[0];S14mag=[0];
  S11pha=[0];S12pha=[0];S13pha=[0];S14pha=[0];
 
  S21mag=[0];S22mag=[0];S23mag=[0];S24mag=[0];
  S21pha=[0];S22pha=[0];S23pha=[0];S24pha=[0];
 
  S31mag=[0];S32mag=[0];S33mag=[0];S34mag=[0];
  S31pha=[0];S32pha=[0];S33pha=[0];S34pha=[0];
 
  S41mag=[0];S42mag=[0];S43mag=[0];S44mag=[0];
  S41pha=[0];S42pha=[0];S43pha=[0];S44pha=[0];
  
 
  Sformat1='%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,';
  Sformat2='%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f';
  Sformat=[Sformat1,Sformat2];

  Freq=[0];
  while L~=(-1);
     L=fgetl(fid_in);
     if L~=(-1);

       SS=sscanf(L,Sformat);

       Freq(Index)=SS(1,1)*1000;     % Convert Freq from Ghz to MHz
       
       % Row S1n

       S11(Index)=SS(2,1)+SS(3,1)*j;
       S12(Index)=SS(4,1)+SS(5,1)*j;
       S13(Index)=SS(6,1)+SS(7,1)*j;
       S14(Index)=SS(8,1)+SS(9,1)*j;

       % Row S2n

       S21(Index)=SS(10,1)+SS(11,1)*j;
       S22(Index)=SS(12,1)+SS(13,1)*j;
       S23(Index)=SS(14,1)+SS(15,1)*j;
       S24(Index)=SS(16,1)+SS(17,1)*j;

       % Row S3n

       S31(Index)=SS(18,1)+SS(19,1)*j;
       S32(Index)=SS(20,1)+SS(21,1)*j;
       S33(Index)=SS(22,1)+SS(23,1)*j;
       S34(Index)=SS(24,1)+SS(25,1)*j;

       % Row S4n

       S41(Index)=SS(26,1)+SS(27,1)*j;
       S42(Index)=SS(28,1)+SS(29,1)*j;
       S43(Index)=SS(30,1)+SS(31,1)*j;
       S44(Index)=SS(32,1)+SS(33,1)*j;

       Index=Index+1;
     end
  end 


  fclose(fid_in);
else
   fprintf('\nError opening file, file not found.\n');
end   
