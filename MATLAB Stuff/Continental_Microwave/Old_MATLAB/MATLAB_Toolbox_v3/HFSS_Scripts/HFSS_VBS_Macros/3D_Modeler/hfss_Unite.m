function hfss_Unite(fid,ObjectList)

% Unite
fprintf(fid, '\n');
fprintf(fid, 'oEditor.Unite  _\n');

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

% Unite
fprintf(fid, 'Array("NAME:UniteParameters", "KeepOriginals:=", false)\n');