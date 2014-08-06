function hfss_VariableDefinition(fid,Variable,Value,Units)

% Attributs:
fprintf(fid, '\n');
fprintf(fid, 'oDesign.ChangeProperty _\n');
fprintf(fid, 'Array("NAME:AllTabs", _\n');
fprintf(fid, 'Array("NAME:LocalVariableTab", _\n');
fprintf(fid, 'Array("NAME:PropServers",  _\n');
fprintf(fid, '"LocalVariables"), _\n');
fprintf(fid, 'Array("NAME:NewProps", _\n');
fprintf(fid, 'Array("NAME:%s", _\n', Variable);
fprintf(fid, '"PropType:=", _\n');
fprintf(fid, '"VariableProp", _\n');
fprintf(fid, '"UserDef:=", _\n');
fprintf(fid, 'true, _\n');

fprintf(fid, '"Value:=", ');
var_type(fid,Value,Units,1);
fprintf(fid, ')))\n');

%% ---------- %% Sub-Functions %% ---------- %%

%% Find variable type
function var_type(fid,var_under_test,Units,flag)

if isstr(var_under_test)
    fprintf(fid, '"%s"',var_under_test);
else
    fprintf(fid, '"%f%s"',var_under_test,Units);
end

% Close or Continue
if (exist('flag','var')) && (flag==1)
    fprintf(fid, ') _\n');
else 
    fprintf(fid, ', _\n');
end