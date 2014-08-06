function hfss_Split(fid,ObjectList,SplitPlane,WhichSide)

% SplitPlane
% Possible values are "XY", "YZ", "ZX"
% WhichSide
% Side to keep. Possible values are "Both", "PositiveOnly", "NegativeOnly"

% Split
fprintf(fid, '\n');
fprintf(fid, 'oEditor.Split _\n');

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
fprintf(fid, 'Array("NAME:SplitToParameters", _\n');
fprintf(fid, '"SplitPlane:=" "%s", _\n', SplitPlane);
fprintf(fid, '"WhichSide:=" "%s") \n', WhichSide);
