function hfss_CloseActiveProject(fid)

% CloseActiveProject
fprintf(fid, '\n');
fprintf(fid, 'Set oProject = oDesktop.GetActiveProject()\n');
fprintf(fid, 'oProject.Close\n');