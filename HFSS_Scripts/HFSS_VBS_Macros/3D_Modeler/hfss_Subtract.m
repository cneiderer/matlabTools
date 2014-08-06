function hfss_Subtract(fid,blankParts,toolParts,keepOrig)

% Subtract
fprintf(fid, '\n');
fprintf(fid, 'oEditor.Subtract _\n');
fprintf(fid, 'Array("NAME:Selections", _\n');

% Blank Parts:
fprintf(fid, '"Blank Parts:=", _\n');
if (iscell(blankParts))
	nBlank = length(blankParts);
	fprintf(fid, '"');
	for iB = 1:nBlank-1,
		fprintf(fid, '%s,', blankParts{iB});
	end;
	fprintf(fid, '%s", _\n', blankParts{nBlank});
else
	fprintf(fid, '"%s", _\n', blankParts);
end;

% Tool Parts:
fprintf(fid, '"Tool Parts:=", _\n');
if (iscell(toolParts))
	nTool = length(toolParts);
	fprintf(fid, '"');
	for iB = 1:nTool-1,
		fprintf(fid, '%s,', toolParts{iB});
	end;
	fprintf(fid, '%s"), _\n', toolParts{nTool});
else
	fprintf(fid, '"%s"), _\n', toolParts);
end;

% Subtract
fprintf(fid, 'Array("NAME:SubtractParameters", _\n');
fprintf(fid, '"KeepOriginals:=", %d) \n', keepOrig);