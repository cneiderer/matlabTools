function plot_pattern3D(deltheta,delphi,polarisation,normalise)
% Plot 3D pattern 
% Default figure (10)
%
% Usage: plot_pattern3D(deltheta,delphi,polarisation,normalise)
%
% deltheta.....Step value of theta (Deg)  Such that 180/deltheta is an integer
% delphi.......Step value for phi (Deg)   Such that 360/delphi is an integer
% polarisation.Polarisation (string)
% normalise....Normalisation (string)
% 
% Options for polarisation are :
%  
%               'tot' - Total E-field
%               'vp'  - Vertical polarisation
%               'hp'  - Horizontal polarisation
%   
% Options for normalise are : 
%
%               'yes'  - Normalise pattern suface to its maximum value
%               'no'   - Directivity (dBi), no normalisation
%                        Note : calc_directivity must be run first !
%
%
% e.g. plot_pattern3D(10,15,'tot','no')
%
%         z
%         |-theta   (theta 0-180 measured from z-axis)
%         |/
%         |_____ y
%        /\
%       /-phi       (phi 0-360 measured from x-axis)
%      x    

global direct_config;
global normd_config;
global dBrange_config;
global range_config;

dBrange=dBrange_config;   % dB range for plots

switch polarisation
 case 'tot',pol=1;
 case 'vp',pol=2;
 case 'hp',pol=3;
 otherwise, disp('Unknown polarisation option, use "tot", "vp" or "hp"\n'),...
            pol=1,polarisation='tot'; 
end

if direct_config==0 & strcmp(normalise,'no')
 fprintf('\nWarning, directivity = 0 dBi has calc_directivity been run?\n');
 fprintf('Plot may not be scaled correctly.\n');
end

% If absolute (no normalisation ) is requested, setup peak directivity 
% string to add to plots and set dBmax to plot values above 0 dBi
if strcmp(normalise,'no')
 dBmax=(ceil((direct_config)/10))*10;    % Maximum dB value for plots
 Tdirec=sprintf('(Peak Directivity = %3.2f dBi)',direct_config);
else 
 dBmax=0;
 Tdirec='(Normalised to 0dB)';
end
dBmin=dBmax-dBrange;          % Minimum dB value for plots

dth=deltheta*pi/180;          % Delta theta step
dph=delphi*pi/180;            % Delta phi step

NphiStep=floor(2*pi/dph);     % Number of phi steps         
NthetaStep=floor(pi/dth);     % Number of theta steps


% Initialise arrays for surface x,y,z data and colour data Rc as radius. 
% Rc = sqrt(x^2+y^2+z^2)

x=ones(NphiStep,NthetaStep*NphiStep);
y=ones(NphiStep,NthetaStep*NphiStep);
z=ones(NphiStep,NthetaStep*NphiStep);
Rc=ones(NphiStep,NthetaStep*NphiStep);

fprintf('\nCalculating 3D Pattern Data : d(Th)=%3.2f   d(Phi)=%3.2f\n',deltheta,delphi);

BarLen=40;               % Progress bar length (space characters)
BarStep=(pi)/(BarLen);   % Bar step length as a proportion of theta(max)=pi
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
m=0;                                           % Phi loop counter
for theta=0:dth:(pi)                           % Phi integration
 m=m+1;
 while (theta>BarProg) & ((BarProg+BarStep)<=pi)
  fprintf('.');                                % Progress bar
  BarProg=BarProg+BarStep;
 end 
 n=0;
 for phi=(-pi):dph:(pi)               
  n=n+1;

  if theta==pi % | theta==0 % thetac is the value of theta for the
   thetac=theta;            % the centre of the surface patch and
  else                      % is used for the colour scale
   thetac=theta+(dth/2);
  end

  if phi==pi % | phi==-pi   % phic is the value of phi for the centre
   phic=phi;                % of the surface patch and is used to for
  else                      % the colour scale
   phic=phi+(dph/2);
  end

  Ecorner=fieldsum(range_config,theta,phi);       % E(theta,Phi) surface patch corners
  Ecentre=fieldsum(range_config,thetac,phic);     % E(theta,Phi) surface patch centres

  Ethph=Ecorner(1,pol);    % E(theta,Phi) polarisation component selection for surface patch corners
  Ethphc=Ecentre(1,pol);   % E(theta,Phi) polarisation component selection for surface patch centres
  Pthph=Ethph.^2;          % Convert to power
  Pthphc=Ethphc.^2;        % Convert to power

  % Patch corners
  if Pthph>0 
   pat=10*log10(Pthph)+dBmax-dBmin;
  else
   pat=0;
  end
  if pat<0
   pat=0;
  end
  [xr,yr,zr]=sph2cart1(pat,theta,phi);  % Convert from spherical to cartesian coords
     
  x(m,n)=real(xr);    % Fill x-matrix mesh data
  y(m,n)=real(yr);    % Fill y-matrix mesh data
  z(m,n)=real(zr);    % Fill z-matrix mesh data NB real part is taken because-    
                      % -of Vsmall complex components being introduced due to rounding errors  

  % Patch centres
  if Pthphc>0 
   patc=10*log10(Pthphc)+dBmax-dBmin;
  else
   patc=0;
  end
  if patc<0
   patc=0;
  end
  [xrc,yrc,zrc]=sph2cart1(patc,thetac,phic);  % Convert from spherical to cartesian coords
  
  Rc(m,n)=sqrt(xrc.^2+yrc.^2+zrc.^2);         % Plot data as radius in dB 

 end
end



MaxVal=max(max(Rc));

if strcmp(normalise,'yes')
 PlotData=Rc-MaxVal+dBrange;
 Tmax=' ';
else
 PlotData=Rc+direct_config-normd_config;
 MaxPlotValue=max(max(PlotData))-dBrange;
 Tmax=sprintf(' (Max Plot Value = %3.2f dBi)',MaxPlotValue);
end

figure(10);
clf;
surface(x,y,z,'cdata',PlotData); 
view([60,20]);
colormap('jet');
xlabel('Global X-axis');
ylabel('Global Y-axis');
zlabel('Global Z-axis');
T1=['3D ',upper(polarisation),' Pattern Plot ',Tdirec,Tmax];
title(T1);
axis equal;
axis off;
rotate3d;
colorbar;
h=get(colorbar,'yticklabel');
hmax=max(h);
set(colorbar,'yticklabel',str2num(h)-dBrange);

hold on;

% Add global axis lines to plot

% Scale axis lengths according to 
% dimensions of pattern surface
axlenx=max(max(x))*1.2; 
axleny=max(max(y))*1.2;
axlenz=max(max(z))*1.2;

% X-axis
elaxis(1:3,1)=[ 0   ; 0   ;0  ].*axlenx;
elaxis(1:3,2)=[ 1   ; 0   ;0  ].*axlenx;

% Y-axis
elaxis(1:3,3)=[ 0   ; 0   ;0  ].*axleny;
elaxis(1:3,4)=[ 0   ; 1   ;0  ].*axleny;
% Z-axis
elaxis(1:3,5)=[ 0   ; 0   ;0  ].*axlenz;
elaxis(1:3,6)=[ 0   ; 0   ;1  ].*axlenz;


 % Plot global X-axis
 plot3(elaxis(1,1:2),elaxis(2,1:2),elaxis(3,1:2),'k-','linewidth',2);
 text(elaxis(1,2),elaxis(2,2),elaxis(3,2),'gx','fontsize',8,'fontweight','bold');
 
 % Plot global Y-axis
 plot3(elaxis(1,3:4),elaxis(2,3:4),elaxis(3,3:4),'k-','linewidth',2);
 text(elaxis(1,4),elaxis(2,4),elaxis(3,4),'gy','fontsize',8,'fontweight','bold');

 % Plot global Z-axis
 plot3(elaxis(1,5:6),elaxis(2,5:6),elaxis(3,5:6),'k-','linewidth',2);
 text(elaxis(1,6),elaxis(2,6),elaxis(3,6),'gz','fontsize',8,'fontweight','bold');