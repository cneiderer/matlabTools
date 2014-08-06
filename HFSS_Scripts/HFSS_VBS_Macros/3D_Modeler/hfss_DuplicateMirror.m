function hfss_DuplicateMirror(fid,ObjectList,BaseX,BaseY,BaseZ,...
    NormalX,NormalY,NormalZ,Units)

% DuplicateMirror
fprintf(fid, 'oEditor.DuplicateMirror _\n');

% Selections:
fprintf(fid, 'Array("NAME:Selections", "Selections:=", _\n');
fprintf(fid, '"');
nObjects = length(ObjectList);
for iObj = 1:nObjects,
	fprintf(fid, '%s', ObjectList{iObj});
	if (iObj ~= nObjects)
		fprintf(fid, ',');
	end;
end;
fprintf(fid, '", _\n');
fprintf(fid, '"NewPartsModelFlag:=", "Model"), _\n');

% Paramters:
fprintf(fid, 'Array("NAME:DuplicateToMirrorParameters", _\n');
fprintf(fid, '"DuplicateMirrorBaseX:=", ');
var_type(fid,BaseX,Units);
fprintf(fid, '"DuplicateMirrorBaseY:=", ');
var_type(fid,BaseY,Units);
fprintf(fid, '"DuplicateMirrorBaseZ:=", ');
var_type(fid,BaseZ,Units);
fprintf(fid, '"DuplicateMirrorNormalX:=", ');
var_type(fid,NormalX,Units);
fprintf(fid, '"DuplicateMirrorNormalY:=", ');
var_type(fid,NormalY,Units);
fprintf(fid, '"DuplicateMirrorNormalZ:=", ');
var_type(fid,NormalZ,Units,1);
fprintf(fid, 'Array("NAME:Options", "DuplicateBoundaries:=", true) \n');

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
    fprintf(fid, '), _\n');
else 
    fprintf(fid, ', _\n');
end