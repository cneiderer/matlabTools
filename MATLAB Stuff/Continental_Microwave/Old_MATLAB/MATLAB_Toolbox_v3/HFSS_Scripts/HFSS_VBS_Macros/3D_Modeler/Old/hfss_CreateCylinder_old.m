function hfss_CreateCylinder(fid,Name,Axis,XCenter,YCenter,ZCenter,...
    Radius,Height,Units)

% Cylinder
fprintf(fid, '\n');
fprintf(fid, 'oEditor.CreateCylinder _\n');

% Cylinder Parameters:
fprintf(fid, 'Array("NAME:CylinderParameters", _\n');

fprintf(fid, '"XCenter:=", ');
var_type(fid,XCenter,Units);
fprintf(fid, '"YCenter:=", ');
var_type(fid,YCenter,Units);
fprintf(fid, '"ZCenter:=", ');
var_type(fid,ZCenter,Units);
fprintf(fid, '"Radius:=", ');
var_type(fid,Radius,Units);
fprintf(fid, '"Height:=", ');
var_type(fid,Height,Units);

fprintf(fid, '"WhichAxis:=", "%s"), _\n', upper(Axis));

% Cylinder Properties:
fprintf(fid, 'Array("NAME:Attributes", _\n'); 
fprintf(fid, '"Name:=", "%s", _\n', Name);
fprintf(fid, '"Flags:=", "", _\n');
fprintf(fid, '"Color:=", "(84 84 84)", _\n');
fprintf(fid, '"Transparency:=", 0.5, _\n');
fprintf(fid, '"PartCoordinateSystem:=", "Global", _\n');
fprintf(fid, '"MaterialName:=", "vacuum", _\n');
fprintf(fid, '"SolveInside:=", true)\n');

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