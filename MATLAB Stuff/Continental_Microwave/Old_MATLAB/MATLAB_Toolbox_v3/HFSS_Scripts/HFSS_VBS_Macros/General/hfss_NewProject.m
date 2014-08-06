function hfss_NewProject(fid)

% HFSS NewProject Header
fprintf(fid, 'Dim oHfssApp\n');
fprintf(fid, 'Dim oDesktop\n');
fprintf(fid, 'Dim oProject\n');
fprintf(fid, 'Dim oDesign\n');
fprintf(fid, 'Dim oEditor\n');
fprintf(fid, 'Dim oModule\n');
fprintf(fid, '\n');

% Create a New Project.
fprintf(fid, 'Set oHfssApp  = CreateObject("AnsoftHfss.HfssScriptInterface")\n');
fprintf(fid, 'Set oDesktop = oHfssApp.GetAppDesktop()\n');
fprintf(fid, 'oDesktop.RestoreWindow\n');
fprintf(fid, 'oDesktop.NewProject\n');

% The new project created is the active project.
fprintf(fid, 'Set oProject = oDesktop.GetActiveProject\n');