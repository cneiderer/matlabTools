function hfss_SolveSetup(fid,SetupName)

% SolveSetup
fprintf(fid, '\n');
fprintf(fid, 'oDesign.Solve _\n');
fprintf(fid, 'Array("%s") \n', SetupName);