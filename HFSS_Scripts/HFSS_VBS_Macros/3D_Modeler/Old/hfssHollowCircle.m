% ----------------------------------------------------------------------------
% function hfssHollowCircle(fid,Name,Axis,Center,InnerRad,OuterRad,Units)
% 
% Description :
% -------------
% Creates the VB Script necessary to create a HollowCircle in HFSS. (Useful 
% for assigning SMA Ports.)
%
% Parameters :
% ------------
% fid      - file identifier of the HFSS script file.
% Name     - name of the port (in HFSS).
% Axis     - choose between 'X', 'Y', or 'Z' to represent the circle axis.
% Center   - center of the circle (use the [x, y, z] format).
% InnerRad - radius of inner circle edge of HollowPort.
% OuterRad - radius of outer circle edge of HollowPort.
% Units    - units for all the above quantities (use either 'in', 'mm', 'meter'
%            or anything else defined in HFSS).
% 
% Note :
% ------
%
% Example : 
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssCircle(fid, 'SMA_Port', 'Z', [10, 11, 12], 13, 20, 'mm');
%
% Notes:
%   Need to find way to change Inner_Circle and Outer_Circle Names when
%   using multiple hollow circles.  Prevents HFSS confusion when trying to
%   find object.
%

function hfssHollowCircle(fid,Name,Axis,Center,InnerRad,OuterRad,Units)

% Inner Circle
hfssCircle(fid,'Inner_Circle',Axis,Center,InnerRad,Units)

% Outer Circle
hfssCircle(fid,'Outer_Circle',Axis,Center,OuterRad,Units)

% Subtract to form Hollow Circle
hfssSubtract(fid,{'Outer_Circle'},{'Inner_Circle'})

% Set Name Attribute of Hollow Circle 
fprintf(fid, '\n');
fprintf(fid, 'oDesign.ChangeProperty _\n');
fprintf(fid, 'Array("NAME:AllTabs", _\n');
fprintf(fid, 'Array("NAME:Geometry3DAttributeTab", _\n');
fprintf(fid, 'Array("NAME:PropServers",  _\n');
fprintf(fid, '"Outer_Circle"), _\n');
fprintf(fid, 'Array("NAME:ChangedProps", _\n');
fprintf(fid, 'Array("NAME:Name", _\n');
fprintf(fid, '"Value:=", "%s"))))\n',Name);