function hfss_DuplicateAlongLine(fid,ObjectList,XComp,YComp,ZComp,Units...
    NumClones)

% DuplicateAlongLine
fprintf(fid, '\n');
fprintf(fid, 'oEditor.DuplicateAlongLine _\n');

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
fprintf(fid, 'Array("NAME:DuplicateToAlongLineParameters", _\n');
fprintf(fid, '"XComponent:=", ');
var_type(fid,XComp,Units);
fprintf(fid, '"YComponent:=", ');
var_type(fid,YComp,Units);
fprintf(fid, '"ZComponent:=", ');
var_type(fid,ZComp,Units);

fprintf(fid, '"NumClones:=", %d), _\n', NumClones);

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
