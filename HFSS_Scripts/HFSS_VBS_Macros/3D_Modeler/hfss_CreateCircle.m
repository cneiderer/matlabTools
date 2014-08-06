function hfss_CreateCircle(fid,Name,Axis,XCenter,YCenter,ZCenter,...
    Radius,Units,coverLines)

% Circle
fprintf(fid, '\n');
fprintf(fid, 'oEditor.CreateCircle _\n');

% Parameters:
fprintf(fid, 'Array("NAME:CircleParameters", _\n');
fprintf(fid, '"CoordinateSystemID:=", -1, _\n');
fprintf(fid, '"IsCovered:=", true, _\n');

fprintf(fid, '"XCenter:=", ');
var_type(fid,XCenter,Units);
fprintf(fid, '"YCenter:=", ');
var_type(fid,YCenter,Units);
fprintf(fid, '"ZCenter:=", ');
var_type(fid,ZCenter,Units);
fprintf(fid, '"Radius:=", ');
var_type(fid,Radius,Units);

fprintf(fid, '"WhichAxis:=", "%s", _\n', upper(Axis));
fprintf(fid, '"NumSegments:=", "0"), _\n');

% Attributes:
fprintf(fid, 'Array("NAME:Attributes", _\n');
fprintf(fid, '"Name:=", "%s", _\n', Name);
fprintf(fid, '"Flags:=", "", _\n');
fprintf(fid, '"Color:=", "(127 255 0)", _\n');
fprintf(fid, '"Transparency:=", 0, _\n');
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
