function yrotc_array(ang,elstart,elfinish)
% Rotate and copy array geometry about y-axis, rotation is relative
% to the current orientation, new elements are added onto the end
% of array_config.
%
% Usage : yrotc_array(ang,elstart,elfinish)
%
% ang.......Rotation angle (Deg)
%
% elstart...Start element number (1 to N) where N 
%           is the number of elements in the array
%
% elfinish..Finish element number (1 to N) where N
%           is the number of elements in the array.
%           For elfinish>N, elfinish is set equal to N
%
% +ve defined by RH screw rule, holding y-axis
% RH = +ve
% LH = -ve
%
%         z
%         |
%         |
%         |_____ y  RH Screw towards origin
%        /      
%       / 
%      x    
%

global array_config

[Trow,Tcol,N]=size(array_config);  % Number of elements in array N

YROT=roty(ang*pi/180);             % Get y-axis rotation matrix for angle specified

% initialise a unit coordinate system of 4 points

P1=[0;0;0];
P2=[1;0;0];
P3=[0;1;0];
P4=[0;0;1];

if elfinish>N
 elfinish=N;
end

if elstart<1
 elstart=1;
end

fprintf('Rotate-copy elements %i to %i around Y-axis by %3.2f Deg\n',...
         elstart,elfinish,ang);

newn=N+1;  % index start for adding the new elements

for n=elstart:1:elfinish           % Over elstart to elfinish sources
  Amp=array_config(1,5,n);         % Amplitude of (n)th source (lin volts)
  Pha=array_config(2,5,n);         % Phase of (n)th source (radians)

  Trot=array_config(1:3,1:3,n);    % Element orientataion (rotation matrix)
  Toff=array_config(1:3,4,n);      % Element position (offset matrix)

  % Position unit coordinate system according to (nth) element rotation
  % and offset matrices. 
  P1ref=Trot*P1+Toff;
  P2ref=Trot*P2+Toff;
  P3ref=Trot*P3+Toff;
  P4ref=Trot*P4+Toff;
  
  % Rotate the unit coordinate system representing the (nth) element
  % to its new position using the YROT matrix.
  P1rot=YROT*P1ref;
  P2rot=YROT*P2ref;
  P3rot=YROT*P3ref;
  P4rot=YROT*P4ref;

  % There are now 4 points in two coordinate systems, global reference
  % and final array position.

  xyz1=[P1,P2,P3,P4];             % Assemble refrence points into matrix
  xyz2=[P1rot,P2rot,P3rot,P4rot]; % Assemble rotated points into matrix

  [RotOff]=coord2Troff(xyz1,xyz2);

  New_Trot=RotOff(1:3,1:3);
  New_Toff=RotOff(1:3,4);

  array_config(1:3,1:3,newn)=New_Trot;
  array_config(1:3,4,newn)=New_Toff;
  array_config(1:3,5,newn)=array_config(1:3,5,n);
  newn=newn+1;
end
