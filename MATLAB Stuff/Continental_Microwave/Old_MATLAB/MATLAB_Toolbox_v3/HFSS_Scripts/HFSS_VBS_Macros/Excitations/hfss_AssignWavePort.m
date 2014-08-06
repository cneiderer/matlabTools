function hfss_AssignWavePort(fid,PortName,SheetObject,nModes,isLine,...
    intStart,intEnd,Units)

% WavePort
fprintf(fid, '\n');
fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup") \n');
fprintf(fid, '\n');
fprintf(fid, 'oModule.AssignWavePort _\n');
fprintf(fid, 'Array( _\n');
fprintf(fid, '"NAME:%s", _\n', PortName);
fprintf(fid, '"NumModes:=", %d, _\n', nModes); 
fprintf(fid, '"PolarizeEField:=",  false, _\n');
fprintf(fid, '"DoDeembed:=", false, _\n');
fprintf(fid, '"DoRenorm:=", false, _\n');

% Mode Integration Lines
for iM = 1:nModes,
	fprintf(fid, 'Array("NAME:Modes", _\n');
	if (isLine(iM))
		fprintf(fid, 'Array("NAME:Mode1", _\n');
		fprintf(fid, '"ModeNum:=",  %d, _\n', iM);
		fprintf(fid, '"UseIntLine:=", true, _\n');
		fprintf(fid, 'Array("NAME:IntLine", _\n');
		fprintf(fid, '"Start:=", _\n');
		fprintf(fid, 'Array("%f%s", "%f%s", "%f%s"), _\n', ... 
		        intStart(1), Units, intStart(2), Units, ...
		        intStart(3), Units); 
		fprintf(fid, '"End:=", _\n');
		fprintf(fid, 'Array("%f%s", "%f%s", "%f%s") _\n', ...
		        intEnd(1), Units, intEnd(2), Units, ...
		        intEnd(3), Units);
		fprintf(fid, '), _\n');
		fprintf(fid, '"CharImp:=", "Zpi")');
	else
		fprintf(fid, 'Array("NAME:Mode1", _\n');
		fprintf(fid, '"ModeNum:=",  %d, _\n', iM);
		fprintf(fid, '"UseIntLine:=", false) _\n');
	end;
	if (iM ~= nModes)
		fprintf(fid, ', _\n');
	end;
end;
fprintf(fid, '), _\n');
fprintf(fid, '"Objects:=", Array("%s")) \n', SheetObject);