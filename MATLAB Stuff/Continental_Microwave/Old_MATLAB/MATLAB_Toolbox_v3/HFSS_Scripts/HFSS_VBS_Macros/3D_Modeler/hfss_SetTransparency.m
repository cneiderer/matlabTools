function hfss_SetTransparency(fid,ObjectList,Value)

% Inputs
if (Value<0) | (Value>1)
	error('Transparency value must be between 0 and 1!!!');
end;

fprintf(fid, '\n');
fprintf(fid, 'oEditor.ChangeProperty _\n');
fprintf(fid, 'Array("NAME:AllTabs", _\n');
fprintf(fid, '\tArray("NAME:Geometry3DAttributeTab", _\n');
fprintf(fid, '\t\tArray("NAME:PropServers",');

% Selections:
nObjects = length(ObjectList);
for iObj = 1:nObjects,
	fprintf(fid, '%s', ObjectList{iObj});
	if (iObj ~= nObjects)
		fprintf(fid, ',');
	end;
end;
fprintf(fid, '"), _\n');

fprintf(fid, '\t\tArray("NAME:ChangedProps", _\n');
fprintf(fid, '\t\t\tArray("NAME:Transparent", "Value:=",  %f) _\n', Value);
fprintf(fid, '\t\t\t) _\n');
fprintf(fid, '\t\t) _\n');
fprintf(fid, '\t)\n');