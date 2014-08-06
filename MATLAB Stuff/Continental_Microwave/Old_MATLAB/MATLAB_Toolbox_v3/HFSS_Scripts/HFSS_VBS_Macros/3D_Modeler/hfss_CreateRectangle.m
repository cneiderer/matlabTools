function hfss_CreateRectangle(fid,Name,Axis,XStart,YStart,ZStart,...
    Height,Width,Units)

% Rectangle
fprintf(fid, '\n');
fprintf(fid, 'oEditor.CreateRectangle _\n');

% Rectangle Parameters:
fprintf(fid, 'Array("NAME:RectangleParameters", _\n');
fprintf(fid, '"IsCovered:=", true, _\n');

fprintf(fid, '"XStart:=", ');
var_type(fid,XStart,Units);
fprintf(fid, '"YStart:=", ');
var_type(fid,YStart,Units);
fprintf(fid, '"ZStart:=", ');
var_type(fid,ZStart,Units);

fprintf(fid, '"Width:=", ');
var_type(fid,Width,Units);
fprintf(fid, '"Height:=", ');
var_type(fid,Height,Units);

fprintf(fid, '"WhichAxis:=", "%s"), _\n', upper(Axis));

% Rectangle Attributes:
fprintf(fid, 'Array("NAME:Attributes", _\n');
fprintf(fid, '"Name:=", "%s", _\n', Name);
fprintf(fid, '"Flags:=", "", _\n');
fprintf(fid, '"Color:=", "(255 0 0)", _\n');
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