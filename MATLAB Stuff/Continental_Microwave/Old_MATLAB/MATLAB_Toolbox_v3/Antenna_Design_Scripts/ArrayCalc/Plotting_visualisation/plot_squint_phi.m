function plot_squint_phi(phimin,phistep,phimax,...
         theta_cut,theta_squint,phi_squint_list,polarisation,normalise)
% Plots pattern cuts in phi for specified phi-squint angles
%
% Default figure(8) for cartesian display
% Default figure(9) for polar display
%
% Usage: plot_theta(phimin,phistep,phimax,...
%        theta_cut,theta_squint,phi_squint_list,polarisation,normalise)
%
% phimin.............Minimum value of phi (Deg)
% phistep............Step value for phi (Deg)
% phimax.............Maximum value for phi (Deg)
%
% theta_cut..........Theta value cut (Deg)
% theta_squint.......Squint value in theta direction (Deg)
% phi_squint_list....List of squint values in phi direction (Deg)
%
% polaristion........Polarisation (string)
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
% e.g. For two -90 to +90 Deg phi cuts for phi squints values of 0, 5 and 10 Deg 
%      normalised to maximum in phi=0 Deg cut use :
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


if direct_config==0 & strcmp(normalise,'absolute')
 fprintf('Warning, directivity = 0 dBi has calc_directivity been run?\n');
end

% If absolute values are plotted, setup peak directivity 
% string to add to plots and set dBmax to plot values above 0 dBi
if strcmp(normalise,'absolute')
 dBmax=(ceil((direct_config)/10))*10;    % Maximum dB value for plots
 Tdirec=sprintf('(Peak Directivity = %3.2f dBi)',direct_config);
else 
 dBmax=0;
 Tdirec=' ';
end
dBmin=dBmax-dBrange;                     % Minimum dB value for plots

[row,N]=size(phi_squint_list);           % Number of cuts
plotcolourlist=['r','g','b','c','m','y']; 

figure(9);
polaxis(dBmin,dBmax,5,15);   % Plot polar axis
hold on;

fprintf('\n');
normalise_found=0;

for n=1:N
 phi_squint=phi_squint_list(1,n);
 squint_array(theta_squint,phi_squint,1);              % Squint the array
 %fprintf('Phi squint = %3.2f\n',phi_squint);
 pcolour=[plotcolourlist(1,mod(n,6)),'-'];             % Plot colour string

 % Calculate the phi pattern cut for specified theta values
 [phicut,Emulti]=phi_cut(phimin,phistep,phimax,theta_cut);  
 
 phicut=phicut';          % Phi angles in degrees transposed
 Efield=Emulti(:,pol);    % Select column vector of pattern data
                          % polarisation Etot / Evp / Ehp as required
 
 Efield=Efield';          % Transpose
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
  fprintf('Invalid normalisation, use "first","each" or "absolute"\n');
  fprintf('Normalisation set to 0\n');
  norm=0;   
 end

 pwrdBn=pwrdB-norm;

 figure(8); % Cartesiasn plots
 plot(phicut,pwrdBn,pcolour,'LineWidth',2);           % Phi pattern cut
 hold on;

 figure(9); % Polar plots
 polplot(phicut,pwrdBn,dBmin,pcolour,'LineWidth',2);  % Phi pattern cut
end 


% Add legend to Cartesian plot
figure(8); 
axis([phimin phimax dBmin dBmax]);
plot([phimin,phimax],[-3,-3],'k:');  % Put -3dB line on plot
lx=0.63;    % Top left of legend list on graph is at (fx,fy)
ly=1.00;    % Screen coords are (0,0) bottom left (1,1) top right

k=1;
for i=1:N,
  pcolour=[plotcolourlist(1,mod(i,6)),'-'];             % Plot colour string
  T1=sprintf('Phi squint = %g',phi_squint_list(1,i));   % Phi cut label
  plotsc((lx-0.05),(ly-k.*0.03),(lx-0.01),(ly-k.*0.03),pcolour);
  textsc(lx,((ly)-(k).*0.03),T1);
  k=k+1;
end

T1=sprintf('Theta Squint Angle = %g',theta_squint);
T2=sprintf('Theta Cut Angle = %g',theta_cut);
textsc(0.05,0.97,T1);
textsc(0.05,0.94,T2);

Ttitle=['Phi ',upper(polarisation),' pattern cuts for specified Phi squints',Tdirec];
title(Ttitle);
grid on;
zoom on;


% Add legend to Polar plot

figure(9);
circ((-dBmin-3),'k:');  % Put -3dB circle  (-dBmin is 0 dB on the polar plot)
lx=0.85;    % Top left of legend list on graph is at (fx,fy)
ly=0.2;     % Screen coords are (0,0) bottom left (1,1) top right

k=1;
for i=1:N,
  pcolour=[plotcolourlist(1,mod(i,6)),'-'];                   % Plot colour string
  T1=sprintf('Phi squint = %g',phi_squint_list(1,i));         % Phi cut label
  plotsc((lx-0.05),(ly-k.*0.03),(lx-0.01),(ly-k.*0.03),pcolour);
  textsc(lx,((ly)-(k).*0.03),T1);
  k=k+1;
end

Ttitle=['Phi ',upper(polarisation),' pattern cuts for specified Phi squints'];
textsc(-0.25,1.05,Ttitle);
textsc(-0.25,1.00,Tdirec);

T1=sprintf('Theta Squint Angle = %g',theta_squint);
T2=sprintf('Theta Cut Angle = %g',theta_cut);
textsc(-0.25,0.95,T1);
textsc(-0.25,0.92,T2);

