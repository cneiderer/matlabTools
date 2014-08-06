function hfss_AssignMaterial(fid,ObjectList,Material,MaterialType)

if isstr(ObjectList)
    ObjectList={ObjectList};
end

% AssignMaterial
fprintf(fid, '\n');
fprintf(fid, 'oEditor.AssignMaterial _\n');

% Selections:
fprintf(fid, 'Array("NAME:Selections", "Selections:=", "');
nObjects=length(ObjectList);
for ii=1:nObjects,
	fprintf(fid, '%s', ObjectList{ii});
	if (ii ~= nObjects)
		fprintf(fid, ',');
	end;
end;
fprintf(fid, '"), _\n');

% Attributes:
fprintf(fid, 'Array("NAME:Attributes", _\n');
fprintf(fid, '"MaterialName:=", "%s", _\n', Material);

switch lower(MaterialType)
    case 'vacuum'
        fprintf(fid, '"SolveInside:=", true)\n');
    case 'dielectric'
        fprintf(fid, '"SolveInside:=", true)\n');
    case 'metal'
        fprintf(fid, '"SolveInside:=", false)\n');
    otherwise
        Error('MaterialType does not match any cases!!!');
end

