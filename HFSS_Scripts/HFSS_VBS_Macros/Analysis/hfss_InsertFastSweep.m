function hfss_InsertFastSweep(fid,Name,SolutionName,fStartGHz,fStopGHz,nPoints)
   
% Inputs:
if isempty(nPoints)
    nPoints=250;
end

% FastSweep
fprintf(fid, '\n');
fprintf(fid, 'Set oModule = oDesign.GetModule("AnalysisSetup")\n');

fprintf(fid, 'oModule.InsertFrequencySweep _\n');
fprintf(fid, '"%s", _\n', SolutionName);
fprintf(fid, 'Array("NAME:%s", _\n', Name);
fprintf(fid, '"IsEnabled:=", true, _\n');
fprintf(fid, '"SetupType:=", "LinearCount", _\n');
fprintf(fid, '"StartValue:=", "%fGHz", _\n', fStartGHz);
fprintf(fid, '"StopValue:=", "%fGHz", _\n', fStopGHz);
fprintf(fid, '"Count:=", %d, _\n', nPoints);
fprintf(fid, '"Type:=", "Fast", _\n');
fprintf(fid, '"SaveFields:=", false, _\n');
fprintf(fid, '"ExtrapToDC:=", false)\n');