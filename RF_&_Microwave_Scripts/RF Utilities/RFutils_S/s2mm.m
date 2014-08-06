function [Sd1d1,Sd1d2,Sd2d1,Sd2d2,...
          Sd1c1,Sd1c2,Sd2c1,Sd2c2,...
          Sc1d1,Sc1d2,Sc2d1,Sc2d2,...
          Sc1c1,Sc1c2,Sc2c1,Sc2c2] = s2mm(S11,S12,S13,S14,...
                                           S21,S22,S23,S24,...
                                           S31,S32,S33,S34,...
                                           S41,S42,S43,S44)
% Convert 4-port S-parameter to mixed mode S-param 
%
%  Usage :
%
%  function [Sd1d1,Sd1d2,Sd2d1,Sd2d2...
%            Sd1c1,Sd1c2,Sd2c1,Sd2c2...
%            Sc1d1,Sc1d2,Sc2d1,Sc2d2...
%            Sc1c1,Sc1c2,Sc2c1,Sc2c2] = s2mm([S11,S12,S13,S14,...
%                                             S21,S22,S23,S24,...
%                                             S31,S32,S33,S34,...
%                                             S41,S42,S43,S44])
% 
% 
%
%




% N.Tucker www.activefrance.com 2008


% Differential excitation, differential response
Sd1d1=0.5*(S11-S13-S31+S33);
Sd1d2=0.5*(S12-S14-S32+S34);
Sd2d1=0.5*(S21-S23-S41+S43);
Sd2d2=0.5*(S22-S24-S42+S44);

% Common mode excitation, differential response
% (Cross mode coupling)
Sd1c1=0.5*(S11+S13-S31-S33);
Sd1c2=0.5*(S11+S14-S32-S34);
Sd2c1=0.5*(S21+S23-S41-S43);
Sd2c2=0.5*(S22+S24-S42-S44);

% Differential excitation, common mode response
% (Cross mode coupling)
Sc1d1=0.5*(S11-S13+S31-S33);
Sc1d2=0.5*(S12-S14+S32-S34);
Sc2d1=0.5*(S21-S23+S41-S43);
Sc2d2=0.5*(S22-S24+S42-S44);

% Common mode excitation, common mode response
Sc1c1=0.5*(S11+S13+S31+S33);
Sc1c2=0.5*(S11+S14+S32+S34);
Sc2c1=0.5*(S21+S23+S41+S43);
Sc2c2=0.5*(S22+S24+S42+S44);