function directivity_dBi=calc_directivity(deltheta,delphi)
% Calculate peak directivity in dBi value using 
% numerical integration. 
% 
% Usage: directivity=calc_directivity(deltheta,delphi)
%
% deltheta.....Step value of theta (Deg) Such that 180/deltheta is an integer
% delphi.......Step value for phi (Deg)  Such that 360/delphi is an integer
%
% e.g. directivity=calc_directivity(10,10) :
%
% Integration is of the form :
%
%       360   180
%     Int{  Int{  (E(theta,phi)*conj(E(theta,phi))*sin(theta) d(theta) d(phi)
%        0     0
%
%         z
%         |-theta   (theta 0-180 measured from z-axis)
%         |/
%         |_____ y
%        /\
%       /-phi       (phi 0-360 measured from x-axis)
%      x    
%

global direct_config
global normd_config
global range_config


dth=deltheta*pi/180;
dph=delphi*pi/180;

Nphi=(2*pi)/dph;


fprintf('\nCalculating Directivity : d(Th)=%3.2f   d(Phi)=%3.2f\n',deltheta,delphi);

BarLen=40;                 % Progress bar length (space characters)
BarStep=(2*pi)/(BarLen);   % Bar step length as a proportion of phi(max)=2*pi
BarProg=0;
fprintf('|');
for n=1:1:(BarLen)
 fprintf(' ');
end
fprintf('|\n..');

Psum=0;
Pmax=0;
Thmax=0;
Phmax=0;
n=0;

% Phi Integration Loop
for phi=(dph/2):dph:(2*pi-(dph/2))          
 n=n+1;
  while (phi>BarProg) & ((BarProg+BarStep)<=2*pi)
  fprintf('.');                                % Progress Bar     
  BarProg=BarProg+BarStep;
 end
 % Theta Integration Loop                      
 for theta=(dth/2):dth:(pi-(dth/2))            
  Emultiple=fieldsum(range_config,theta,phi);  % E(theta,phi)
  Ethph=Emultiple(1,1);                        % Select Etotal
  Pthph=Ethph*conj(Ethph);                     % Convert to power
                                               % {The conjugate is used for completness here
                                               %  since fieldsum already returns E as a magnitude}
  if Pthph>Pmax                                
   Pmax=Pthph;    % Store peak value
   Thmax=theta;   % Store theta value for the maximum
   Phmax=phi;     % Store phi value for the maximum
  end

  Psum=Psum+Pthph*sin(theta)*dth*dph;          % Summation

 end
end

pmax=Pmax;       % Max power
psum=Psum;       % Total radiated power

normd_config=10*log10(Pmax);                   % Maximum pattern value

directivity_lin=Pmax/(Psum/(4*pi));            % Directivity (linear ratio)
directivity_dBi=10*log10(directivity_lin);     % Directivity (dB wrt isotropic)
direct_config=directivity_dBi;                 % Set global directivity variable

fprintf('\nDirectivity = %3.2f dBi\n',directivity_dBi);
fprintf('At :  Theta = %3.2f\n        Phi = %3.2f \n',Thmax*180/pi,Phmax*180/pi);
