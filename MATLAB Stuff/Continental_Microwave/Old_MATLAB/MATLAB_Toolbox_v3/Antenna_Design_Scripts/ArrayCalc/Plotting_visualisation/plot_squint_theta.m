function plot_squint_theta(thetamin,thetastep,thetamax,...
         phi_cut,phi_squint,theta_squint_list,polarisation,normalise)
% Plots pattern cuts in theta for specified theta-squint angles
%
% Default figure(6) for cartesian display
% Default figure(7) for polar display
%
% Usage: plot_squint_theta(thetamin,thetastep,thetamax,phi_cut,phi_squint,...
%                          theta_squint_list,polarisation,normalise)
%
% thetamin...........Minimum value of theta (Deg)
% thetastep..........Step value for theta (Deg)
% thetamax...........Maximum value for theta (Deg)
%
% phi_cut............Phi value cut (Deg)
% phi_squint.........Squint value in phi direction (Deg)
% theta_squint_list..List of squint values in theta direction (Deg)
%
% polarisation.......Polarisation (string)
% normalise..........Normalisation (string) 
% 
% Options for polarisation are :
%  
%               'tot' - Total E-field
%               'vp'  - Vertical polarisation
%               'hp'  - Horizontal polarisation
%
% Options for normalise are : 
%
%               'first'    - Normalise all cuts to first pattern's maximum value
%               'each'     - Normalise each pattern cut to its maximum value
%               'none'     - Directivity (dBi), no normalisation
%                            Note : calc_directivity must be run first !
%
%
% e.g. For two -90 to +90 Deg theta cuts for theta squints values of 0, 5 and 10 Deg 
%      normalised to maximum in theta=0 Deg cut use :
%      plot_squint_theta(-90,1,90,0,0,[0,5,10],'tot','first')   
%
%         z
%         |-theta   (theta 0-180 measured from z-axis)
%         |/
%         |_____ y
%        /\
%       /-phi       (phi 0-360 measured from x-axis)
%      x    
%

global direct_config;
global normd_config;
global dBrange_config;

dBrange=dBrange_config;   % dB range for plots

switch polarisation
 case 'tot',pol=1;
 case 'vp',pol=2;
 case 'hp',pol=3;
 otherwise, disp('Unknown polarisation option, use "tot", "vp" or "hp"\n'),...
            pol=1,polarisation='tot'; 
end


if direct_config==0 & strcmp(normalise,'none')
 fprintf('Warning, directivity = 0 dBi has calc_directivity been run?\n');
end

% If absolute values are plotted, setup peak directivity 
% string to add to plots and set dBmax to plot values above 0 dBi
if strcmp(normalise,'none')
 dBmax=(ceil((direct_config)/5))*5;    % Maximum dB value for plots
 Tdirec=sprintf('(Peak Directivity = %3.2f dBi)',direct_config);
else 
 dBmax=0;
 Tdirec=' ';
end
dBmin=dBmax-dBrange;                     % Minimum dB value for plots

[row,N]=size(theta_squint_list);         % Number of cuts
plotcolourlist=['r','g','b','c','m','y']; 

figure(7);
polaxis(dBmin,dBmax,5,15);   % Plot polar axis
hold on;

fprintf('\n');
normalise_found=0;

for n=1:N
 theta_squint=theta_squint_list(1,n);
 squint_array(theta_squint,phi_squint,1);              % Squint the array
 %fprintf('Theta squint = %3.2f\n',theta_squint);
 pcolour=[plotcolourlist(1,mod(n,6)),'-'];             % Plot colour string

 % Calculate the theta pattern cut for specified phi values
 [thetacut,Emulti]=theta_cut(thetamin,thetastep,thetamax,phi_cut);  
 
 thetacut=thetacut';        % Theta angles in degrees transposed
 Efield=Emulti(:,pol);      % Select column vector of pattern data
                            % polarisation Etot / Evp / Ehp as required
 
 Efield=Efield';            % Transpose

 pwrdB=20*log10(abs(Efield));

 if strcmp(normalise,'first') & n==1
  norm=max(pwrdB);
  normalise_found=1;
 end

 if strcmp(normalise,'each')
  norm=max(pwrdB);
  normalise_found=1;
 end

 if strcmp(normalise,'none')
  norm=normd_config-direct_config;
  normalise_found=1;
 end

 
 if normalise_found==0
  fprintf('Invalid normalisation, use "first","each" or "none"\n');
  fprintf('Normalisation set to 0\n');
  norm=0;   
 end

 pwrdBn=pwrdB-norm;

 figure(6); % Cartesiasn plots
 plot(thetacut,pwrdBn,pcolour,'LineWidth',2);          % Theta pattern cut
 hold on;

 figure(7); % Polar plots
 polplot(thetacut,pwrdBn,dBmin,pcolour,'LineWidth',2); % Theta pattern cut
end 


% Add legend to Cartesian plot
figure(6); 
axis([thetamin thetamax dBmin dBmax]);
plot([thetamin,thetamax],[-3,-3],'k:');  % Put -3dB line on plot
lx=0.63;    % Top left of legend list on graph is at (fx,fy)
ly=1.00;    % Screen coords are (0,0) bottom left (1,1) top right

k=1;
for i=1:N,
  pcolour=[plotcolourlist(1,mod(i,6)),'-'];           % Plot colour string
  T1=sprintf('Theta squint = %g',theta_squint_list(1,i));   % Theta cut label
  plotsc((lx-0.05),(ly-k.*0.03),(lx-0.01),(ly-k.*0.03),pcolour);
  textsc(lx,((ly)-(k).*0.03),T1);
  k=k+1;
end

T1=sprintf('Phi Squint Angle = %g',phi_squint);
T2=sprintf('Phi Cut Angle = %g',phi_cut);
textsc(0.05,0.97,T1);
textsc(0.05,0.94,T2);

T1=['Theta ',upper(polarisation),' pattern cuts for specified Theta squints  ',Tdirec];
title(T1);
grid on;
zoom on;


% Add legend to Polar plot

figure(7);
circ((-dBmin-3),'k:');  % Put -3dB circle  (-dBmin is 0 dB on the polar plot)
lx=0.85;    % Top left of legend list on graph is at (fx,fy)
ly=0.2;     % Screen coords are (0,0) bottom left (1,1) top right

k=1;
for i=1:N,
  pcolour=[plotcolourlist(1,mod(i,6)),'-'];                       % Plot colour string
  T1=sprintf('Theta sqnt = %g',theta_squint_list(1,i));         % Theta cut label
  plotsc((lx-0.05),(ly-k.*0.03),(lx-0.01),(ly-k.*0.03),pcolour);
  textsc(lx,((ly)-(k).*0.03),T1);
  k=k+1;
end
Ttitle=['Theta ',upper(polarisation),' pattern cuts for specified Phi'];
textsc(-0.25,1.05,Ttitle);
textsc(-0.25,1.00,Tdirec);

T1=sprintf('Phi Squint Angle = %g',phi_squint);
T2=sprintf('Phi Cut Angle = %g',phi_cut);
textsc(-0.25,0.95,T1);
textsc(-0.25,0.92,T2);

