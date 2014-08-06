function [theta,Emulti]=theta_cut(thmin,thstep,thmax,phi)
% Cut in theta for single value of phi 
%
% Usage: [theta,Emulti]=theta_cut(thmin,thstep,thmax,phi)
%
% thmin......Minimum theta value (Deg)
% thstep.....Step size (Deg)
% thmax......Maximum theta value (Deg)
% phi........Phi value for pattern cut (Deg)
%
% Returned values :
%
% theta.....Column vector of theta values (Deg)
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

thmin_rad=thmin*pi/180;
thmax_rad=thmax*pi/180;
thstep_rad=thstep*pi/180;

phi_rad=phi*pi/180;

index=0;
for th_rad=thmin_rad:thstep_rad:thmax_rad,
 index=index+1;
 Emultiple=fieldsum(range_config,th_rad,phi_rad);

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

theta=(thmin:thstep:thmax)';  % Output as a column vector
Emulti=[Etot,Evp,Ehp];        % Output as 3 column vectors