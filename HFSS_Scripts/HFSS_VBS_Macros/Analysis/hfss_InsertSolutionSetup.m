function hfss_InsertSolutionSetup(fid,Name,fGHz,maxDeltaS,maxPass)

% InsertSolutionSetup
fprintf(fid, '\n');
fprintf(fid, 'Set oModule = oDesign.GetModule("AnalysisSetup")\n');
fprintf(fid, 'oModule.InsertSetup "HfssDriven", _\n');

% Attributes:
fprintf(fid, 'Array("NAME:%s", _\n', Name);
fprintf(fid, '"Frequency:=", "%fGHz", _\n', fGHz);
fprintf(fid, '"PortsOnly:=", false, _\n');
fprintf(fid, '"maxDeltaS:=", %f, _\n', maxDeltaS);
fprintf(fid, '"UseMatrixConv:=", false, _\n');
fprintf(fid, '"MaximumPasses:=", %d, _\n', maxPass);
fprintf(fid, '"MinimumPasses:=", 3, _\n');
fprintf(fid, '"MinimumConvergedPasses:=", 1, _\n');
fprintf(fid, '"PercentRefinement:=", 30, _\n');
fprintf(fid, '"ReducedSolutionBasis:=", false, _\n');
fprintf(fid, '"DoLambdaRefine:=", true, _\n');
fprintf(fid, '"DoMaterialLambda:=", true, _\n');
fprintf(fid, '"Target:=", 0.3333, _\n');
fprintf(fid, '"PortAccuracy:=", 2, _\n');
fprintf(fid, '"SetPortMinMaxTri:=", false)\n');