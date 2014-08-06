function [phi,Emulti]=phi_cut(phimin,phistep,phimax,theta)
% Cut in phi for single value of theta 
%
% Usage: [phi,Emulti]=phi_cut(phimin,phistep,phimax,theta)
%
% phimin......Minimum phi value (Deg)
% phistep.....Step size (Deg)
% phimax......Maximum phi value (Deg)
% theta.......Theta value for pattern cut (Deg)
%
% Returned values :
%
% phi.......Column vector of phi values (Deg)
% Emulti....Pattern data E-field in 3 columns [Etot,Evp,Ehp] (volts)
%
% Emulti..[Etot,Evp,Ehp] E-field pattern data in 3 columns :
%         
%         Etot = Total E-field
%         Evp =  Vertical E-field component (Z-axis in global coords)
%         Ehp =  Horizontal E-field component (X-Y plane in global coords)
%         
%         
%         z
%         |-theta   (theta 0-180 measured from z-axis)
%         |/
%         |_____ y
%        /\
%       /-phi       (phi 0-360 measured from x-axis)
%      x    
%

global array_config;
global freq_config;
global range_config;

phimin_rad=phimin*pi/180;
phimax_rad=phimax*pi/180;
phistep_rad=phistep*pi/180;

theta_rad=theta*pi/180;

index=0;
for phi_rad=phimin_rad:phistep_rad:phimax_rad,
 index=index+1;
 Emultiple=fieldsum(range_config,theta_rad,phi_rad);

if Emultiple(1,1)==0
  Emultiple(1,1)=nan;         % Stops plotting of nulls, log 0 error
 end

 if Emultiple(1,2)==0
  Emultiple(1,2)=nan;         % Stops plotting of nulls, log 0 error
 end

 if Emultiple(1,3)==0
  Emultiple(1,3)=nan;         % Stops plotting of nulls, log 0 error
 end

 Etot(index,1)=Emultiple(1,1); % Add values to Etot to make a column vector
 Evp(index,1)=Emultiple(1,2);  % Add values to Evp to make a column vector
 Ehp(index,1)=Emultiple(1,3);  % Add values to Ehp to make a column vector

end

phi=(phimin:phistep:phimax)';
Emulti=[Etot,Evp,Ehp];        % Output as 3 column vectors