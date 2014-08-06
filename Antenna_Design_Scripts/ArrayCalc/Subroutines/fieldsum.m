function Emulti=fieldsum(R,th,phi)
% Summation of field contributions at location (R,th,phi) 
% from each element in array_config, at frequency freq_config. 
%
% Usage: Emulti=fieldsum(R,th,phi)
%
% R....Radius of farfield point
% th...Theta (radians)
% phi..Phi (radians)
%
% 
% Returned values :
%
% Emulti..[Etot,Evp,Ehp] where :
%         
%         Etot = Total E-field
%         Evp =  Vertical E-field component (Z-axis in global coords)
%         Ehp =  Horizontal E-field component (X-Y plane in global coords)



% As well as calculating the total E-field at a given farfield point.
% Two polarisation scaling factors are calculated :
% HP (Horizontal Polarisation)   0<= HP <=1
% VP (Vertical Polarisation)     0<= VP <=1
%
% To calculate the scaling factors a unit vector along the (n)th element
% X-axis is defined. This represents the E-field orientation in all linearly
% polarised element models. When viewed from the farfield point the 
% Z-component of the unit vector represents the VP component and the
% Y-component of the unit vector represents the HP component.
% 
% These scaling factors are then applied to the total E-field to give
% Vertical and Horizontally polarised patterns.
%
% Note: The Theta reference angle for VP and HP is 90 Deg (Horizon)


global array_config;
global freq_config;
global velocity_config;

[Trow,Tcol,N]=size(array_config);    % Number of elements in array N
Etot=0;                              % Total field init                
Evp=0;                               % Vertical field init
Ehp=0;                               % Horizontal field init

lambda=velocity_config/freq_config;  % Wavelength
k=2*pi/lambda;                       % Propagation constant

[xff,yff,zff]=sph2cart1(R,th,phi);   % Far-field point for summation
xyzff=[xff;yff;zff;];

CPflag=0;                            % Flag for circular polarisation
                                     % if set, causes VP=HP -3dB down
                                     % from Etotal

EvpSum=0;
EhpSum=0;

for n=1:N                          % Sum over N sources
  Amp=array_config(1,5,n);         % Amplitude of (n)th source (lin volts)
  Pha=array_config(2,5,n);         % Phase of (n)th source (radians)

  Trot=array_config(1:3,1:3,n);    % Element orientataion (rotation matrix)
  Toff=array_config(1:3,4,n);      % Element position (offset matrix)
    
  xyzffloc=inv(Trot)*(xyzff-Toff); % Far-field point in local coords  
  
  xloc=xyzffloc(1,1);              % x-coord
  yloc=xyzffloc(2,1);              % y-coord
  zloc=xyzffloc(3,1);              % z-coord

  [rloc,thloc,philoc]=cart2sph1(xloc,yloc,zloc);  % Convert to (r,theta,phi) coords
  
  eltype=array_config(3,5,n);                     % Select appropriate element model
  switch eltype
   case 0,EleAmp=1;CPflag=1;                      % Use CP for iso so that VP=HP=-3dBi
   case 1,EleAmp=patchr(thloc,philoc);
   case 2,EleAmp=patchc(thloc,philoc);
   case 3,EleAmp=dipole(thloc,philoc);
   case 4,EleAmp=dipoleg(thloc,philoc);
   case 5,EleAmp=helix(thloc,philoc);CPflag=1;    % Circular pol for helix (VP=HP=-3dB down on Total)
   case 6,EleAmp=interp(thloc,philoc);
   case 7,EleAmp=user1(thloc,philoc);
   otherwise,disp('Invalid element type, isotropic used');EleAmp=1;
  end;

  % Polarisation unit vector manipulation
  if CPflag==0             % If linear pol
   uo=[0;0;0];             % Unit origin
   ux=[1;0;0];             % Unit x-axis (E-field vector for elements)
   ux=ux.*1e-9;            % Scale unit by 1e-9 so as not to be problematic when
                           % the farfield point is chosen to have a small radius

   uor=Trot*uo+Toff;       % Transform origin point to global coords
   uxr=Trot*ux+Toff;       % Transform unit x-axis (E-field vector)
  
   PZr=rotz(-phi);         % Phi rotation
   PYr=roty(-th-pi/2);     % Theta rotation (add 90 Deg so theta is referenced from horizon)

   Prot=PZr*PYr;           % Construct polarisation rotation matrix
   Poff=xyzff;             % Offsets are just the farfield point location (x,y,z)

   uorf=inv(Prot)*(uor-Poff);  % Origin point as viewed from farfield point
   uxrf=inv(Prot)*(uxr-Poff);  % Unit x-axis (E-field vector) as viewed from farfield point
   
   VPc=(uxrf(3,1)-uorf(3,1))*1e-9; % Vertical (Z-component) of E-field vector as viewed from
                                  % the farfield point, and rescale back to unity

   HPc=(uxrf(2,1)-uorf(2,1))*1e-9; % Horizontal (Y-component) of E-field vector as viewed from
                                  % the farfield point, and rescale back to unity
  else            % For Circularly polarised elements
   VPc=0.7079;    % For circular polarisation VP=HP -3dB down from Etot (lin volts)
   HPc=0.7079;    % For circular polarisation VP=HP -3dB down from Etot (lin volts)
  end 
 
  VectSum=sqrt(VPc.^2+HPc.^2); % Vector sum of Vertical and Horizontal components 
  if VectSum>0
   VP=VPc./VectSum;            % Vertical as a proportion on the total
   HP=HPc./VectSum;            % Horizontal as a proportion of the total
  else
   VP=1e-9;                     % If there are no vector component Vert or Horiz 
   HP=1e-9;                     % e.g. end on on a dipole, set to Nan to avoid
  end                           % a divide by zero warning.

  if CPflag==0                  % If linearly polarised
   AmpVP=abs(VP);                      % Amplitude for the Vertical vector component
   PhaVP=(pi/2)*sign(VP)+(pi/2);       % Phase for the Vertical vector component

   AmpHP=abs(HP);                      % Amplitude for the Horizontal vector component
   PhaHP=(pi/2)*sign(HP)+(pi/2);       % Phase for the Horizontal vector component
  else                          % If circularly polarised
   AmpVP=abs(VP);
   PhaVP=0;                            % No geometric phase change used
   AmpHP=abs(HP);  
   PhaHP=0;                            % No geometric phase change used
 end   


  PhaVPt=mod((k.*rloc+Pha+PhaVP),(2*pi)); % (propagation, element-excitation
                                          % and VP-vector-phase) modulo 360

  PhaHPt=mod((k.*rloc+Pha+PhaHP),(2*pi)); % (propagation, element-excitation
                                          % and HP-vector-phase) modulo 360
  
  Evpn=Amp.*EleAmp.*AmpVP.*exp(-j.*PhaVPt); % Vertical E-field component propagated to far-field point
  Ehpn=Amp.*EleAmp.*AmpHP.*exp(-j.*PhaHPt); % Horiz E-field component propagated to far-field point
  
  EvpSum=EvpSum+Evpn;  % Summation of VP E-field comps for the N elements     
  EhpSum=EhpSum+Ehpn;  % Summation of HP E-field comps for the N elements 
 
end

Evp=abs(EvpSum)/N;       % Scale Evp according to number of elements N
Ehp=abs(EhpSum)/N;       % Scale Ehp according to number of elements N
Etot=sqrt(Evp^2+Ehp^2);  % Calc total E-field
Emulti=[Etot,Evp,Ehp];   % Function output