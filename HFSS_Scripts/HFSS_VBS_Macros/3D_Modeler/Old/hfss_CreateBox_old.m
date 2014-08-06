function hfss_CreateBox(fid,Name,XStart,YStart,ZStart,XSize,YSize,ZSize,Units)

% Box
fprintf(fid, '\n');
fprintf(fid, 'oEditor.CreateBox _\n');

% Box Parameters:
fprintf(fid, 'Array("NAME:BoxParameters", _\n');
fprintf(fid, '"XStart:=", ');
var_type(fid,XStart,Units);
fprintf(fid, '"YStart:=", ');
var_type(fid,YStart,Units);
fprintf(fid, '"ZStart:=", ');
var_type(fid,ZStart,Units);
fprintf(fid, '"XSize:=", ');
var_type(fid,XSize,Units);
fprintf(fid, '"YSize:=", ');
var_type(fid,YSize,Units);
fprintf(fid, '"ZSize:=", ');
var_type(fid,ZSize,Units,1);

% Box Attributes:
fprintf(fid, 'Array("NAME:Attributes", _\n');
fprintf(fid, '"Name:=", "%s", _\n', Name);
fprintf(fid, '"Flags:=", "", _\n');
fprintf(fid, '"Color:=", "(102 102 102)", _\n');
fprintf(fid, '"Transparency:=", 0.75, _\n');
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
    fprintf(fid, ') \n');
else 
    fprintf(fid, ', _\n');
end
