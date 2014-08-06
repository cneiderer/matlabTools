function hfss_DuplicateAroundAxis(fid,ObjectList,Axis,Angle,Units,NumClones)

% DuplicateAroundAxis
fprintf(fid, 'oEditor.DuplicateAroundAxis _\n');

% Selections:
fprintf(fid, 'Array("NAME:Selections", "Selections:=", "');
nObjects = length(ObjectList);
for iObj = 1:nObjects,
	fprintf(fid, '%s', ObjectList{iObj});
	if (iObj ~= nObjects)
		fprintf(fid, ',');
	end;
end;
fprintf(fid, '"), _\n');

% Parameters:
fprintf(fid, 'Array("NAME:DuplicateAroundAxisParameters", _n');
fprintf(fid, '"WhichAxis:=", %s, _\n', upper(Axis));
fprintf(fid, '"AngleStr:=", %f%s, ');
var_type(fid,Angle,Units);
fprintf(fid, '"NumClones:=", %d)', NumClones);

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