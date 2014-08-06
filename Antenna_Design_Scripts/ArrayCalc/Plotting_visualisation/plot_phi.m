function [phicut,pwrdBn]=plot_phi(phimin,phistep,phimax,theta_list,...
                                  polarisation,normalise)
% Plots pattern cuts in phi for specified values of theta
%
% Default figure(4) for cartesian display
% Default figure(5) for polar display
%
% Usage: [phi,pwrdB]=plot_phi(phimin,phistep,phimax,theta_list,...
%                             polarisation,normalise)
%
% phimin........Minimum value of phi (Deg)
% phistep.......Step value for phi (Deg)
% phimax........Maximum value for phi (Deg)
% theta_list....List of Theta values for phi cut (Deg)
% polarisation..Polarisation (string)
% normalise.....Normalisation (string) 
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
% e.g. For two 360Deg phi cuts for theta values of 90 and 45 Deg 
%      normalised to maximum in theta=90 Deg cut use :
%      [phi,pwrdB]=plot_phi(0,1,360,[90,45],'tot','first')   
%
%      The returned values [phi,pwrdB] correspond to the last plot requested
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
 fprintf('Plot may not be scaled correctly.\n');
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
dBmin=dBmax-dBrange;            % Minimum dB value for plots

[row,N]=size(theta_list);       % Number of cuts
plotcolourlist=['r','g','b','c','m','y'];

figure(5);
polaxis(dBmin,dBmax,5,15);   % Plot polar axis
hold on;

fprintf('\n');
normalise_found=0;

for n=1:N
 theta=theta_list(1,n);
 fprintf('Phi cut at Theta = %3.2f\n',theta);
 pcolour=[plotcolourlist(1,mod(n,6)),'-'];             % Plot colour string

 % Calculate the phi pattern cut for specified theta values
 [phicut,Emulti]=phi_cut(phimin,phistep,phimax,theta);  
 
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
  fprintf('Invalid normalisation, use "first","each" or "none"\n');
  fprintf('Normalisation set to 0\n');
  norm=0;   
 end

 pwrdBn=pwrdB-norm;

 figure(4); % Cartesiasn plots
 plot(phicut,pwrdBn,pcolour,'LineWidth',2);            % Phi pattern cut
 hold on;

 figure(5); % Polar plots
 polplot(phicut,pwrdBn,dBmin,pcolour,'LineWidth',2);   % Phi pattern cut
end 


% Add legend to Cartesian plot
figure(4); 
axis([phimin phimax dBmin dBmax]);
plot([phimin,phimax],[-3,-3],'k:');  % Put -3dB line on plot
lx=0.66;   % Top left of legend list on graph is at (fx,fy)
ly=0.25;   % Screen coords are (0,0) bottom left (1,1) top right

k=1;
for i=1:N,
  pcolour=[plotcolourlist(1,mod(i,6)),'-'];   % Plot colour string
  T1=sprintf('Theta = %g',theta_list(1,i));   % Theta cut label
  plotsc((lx-0.05),(ly-k.*0.03),(lx-0.01),(ly-k.*0.03),pcolour);
  textsc(lx,((ly)-(k).*0.03),T1);
  k=k+1;
end
T1=['Phi ',upper(polarisation),' pattern cuts for specified Theta  ',Tdirec];
title(T1);
grid on;
zoom on;


% Add legend to Polar plot

figure(5);  
circ((-dBmin-3),'k:');  % Put -3dB circle  (-dBmin is 0 dB on the polar plot)
lx=0.85;    % Top left of legend list on graph is at (fx,fy)
ly=0.2;     % Screen coords are (0,0) bottom left (1,1) top right

k=1;
for i=1:N,
  pcolour=[plotcolourlist(1,mod(i,6)),'-'];     % Plot colour string
  T1=sprintf('Theta = %g',theta_list(1,i));     % Theta cut label
  plotsc((lx-0.05),(ly-k.*0.03),(lx-0.01),(ly-k.*0.03),pcolour);
  textsc(lx,((ly)-(k).*0.03),T1);
  k=k+1;
end
Ttitle=['Phi ',upper(polarisation),' pattern cuts for specified Theta'];
textsc(-0.25,1.05,Ttitle);
textsc(-0.25,1.00,Tdirec);