function place_element(n,xr,yr,zr,x,y,z,eltype,Pwr,Pha)
% Place a single element in specific orientation and location
%
% Usage: place_element(n,xr,yr,zr,x,y,z,eltype,Pwr,Pha)
%
% n.......Element number (integer)
% xr......Rotation about X-axis (Deg)
% yr......Rotation about Y-axis (Deg)
% zr......Rotation about Z-axis (Deg)
% x.......X-coordinate (meters)
% y.......Y-coordinate (meters)
% z.......Z-coordinate (meters)
% eltype..Element type (string)
% Pwr.....Power (volts^2 in dB)
% Pha.....Phase (Deg)
%
% Set element number n=0 to append element to existing geometry.
%
% Valid strings for eltype are listed below. 
%              STRING    VALUE IN array_config
%              'iso'             0
%              'patchr'          1
%              'patchc'          2
%              'dipole'          3
%              'dipoleg'         4
%              'helix'           5
%              'interp'          6
%              'user1'           7
%
%         z
%         |-theta   (theta 0-180 measured from z-axis)
%         |/
%         |_____ y
%        /\
%       /-phi       (phi 0-360 measured from x-axis)
%      x    
%
% +ve rotation is defined as clock-wise looking from axis end towards
% the origin of the axis set.
%
% The xr,yr,zr rotations refer to sequential rotations about 
% x,y and z axes. The rotation matrix is defined as : 
%
%                       Trot=XR*YR*ZR 
%
% Where are XR,YR and ZR are 3D rotation matrices.
%
% If you need to use independant rotations, place the element
% with xr=yr=zr=0 and orientate element using : xrot_array,
% yrot_array or zrot_array functions.
%

% This function generates a global matrix variable :
% array_config(3,5,n)
%
% For each of n=1:N elements there is a 3x5 element
% matrix which defines the element's location, orientation
% excitation and type.
%
%                     /---------- 3x3 rotation matrix
%                    /    /------ 3x1 offset matrix
%                   /    /   /--- Amplitude,Phase,ElementType (1,2,3..)
%                  /    /   /
%               ----- ---- ---
%               L M N Xoff Amp
%   3x5 matrix  O P Q Yoff Pha
%               R S T Zoff Elt
%
% See Also : single_element  % A simpler version of this command


global array_config;

[Trow,Tcol,N]=size(array_config);    % Number of elements in array N

Abort=0;                             % Abort flag

if n>(N+1) | n<0
 fprintf('Warning, invalid element number use -1<n<(N+2) where\n');
 fprintf('N=number of existing elements, no element added.\n');
 Abort=1;
end

if Abort==0
 elnumber=1;                        % Default element number

 if n>1 & array_config(1,1,1)==-1   % If there are no existing elements 
  fprintf('Warning, no existing elements, element number set to 1\n');
  elnumber=1;                       % place at n=1   
 end

 if n==0 & array_config(1,1,1)~=-1                
  elnumber=(N+1);                   % Append to existing list as requested
 end
 
 if n>0 & array_config(1,1,1)~=-1
  elnumber=n;                       % Overwrite existing element
 end
 
 
 fprintf('Placing element number %i at X=%3.4f Y=%3.4f Z=%3.4f (m)\n',...
          elnumber,xr,yr,zr);

 XR=rotx(xr*pi/180);
 YR=roty(yr*pi/180);
 ZR=rotz(zr*pi/180);

 Trot=XR*YR*ZR;
 Toff=[x;y;z];

 Amplitude=10^(Pwr/20);       % Set amplitude in linear volts
 Phase=Pha/180*pi;            % Set phase in radians

 [Elt]=eltcode(eltype);       % Assign numeric code for element type 

 Texc=[Amplitude;Phase;Elt];                  % Assemble last column of 3x5 element matrix

 array_config(:,:,elnumber)=[Trot,Toff,Texc]; % Add element number (index) to array_config
end