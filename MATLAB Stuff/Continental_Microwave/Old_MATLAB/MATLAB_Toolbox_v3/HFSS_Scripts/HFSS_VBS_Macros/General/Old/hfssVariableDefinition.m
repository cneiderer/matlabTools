% ----------------------------------------------------------------------------
% function hfssVariableDefinition(fid, variable, value, units)
% 
% Description :
% -------------
% Create the VB Script necessary to define the value of a nonexistent
% variable
%
% Parameters :
% ------------
% fid      - file identifier of the HFSS script file.
% variable - The name of the variable to be changed.
% value    - The new value for the variable (DOUBLE).
% units    - units of the variable (specify using either 'in', 'mm',
%           'meter' or anything else defined in HFSS).
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'w');
%  
% % define the value of a variable.
% hfssVariableDefinition(fid, 'radius', 5, 'cm')
%

function hfssVariableDefinition(fid, variable, value, units)

% Preamble.
fprintf(fid, '\n');

% Change the variable name
fprintf(fid, 'oDesign.ChangeProperty _\n');
fprintf(fid, 'Array("NAME:AllTabs", _\n');
fprintf(fid, 'Array("NAME:LocalVariableTab", _\n');
fprintf(fid, 'Array("NAME:PropServers",  _\n');
fprintf(fid, '"LocalVariables"), _\n');
fprintf(fid, 'Array("NAME:NewProps", _\n');
fprintf(fid, 'Array("NAME:%s", _\n', variable);
fprintf(fid, '"PropType:=", _\n');
fprintf(fid, '"VariableProp", _\n');
fprintf(fid, '"UserDef:=", _\n');
fprintf(fid, 'true, _\n');

if ~isstr(value)
    fprintf(fid, '"Value:=", "%f%s"))))\n', value, units);
else
    fprintf(fid, '"Value:=", "%s"))))\n', value);
end
