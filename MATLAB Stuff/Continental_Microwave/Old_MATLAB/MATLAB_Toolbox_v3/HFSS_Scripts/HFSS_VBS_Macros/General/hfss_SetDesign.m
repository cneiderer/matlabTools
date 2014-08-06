function hfss_SetDesign(fid,designName)

% create the necessary script.
fprintf(fid, '\n');

fprintf(fid, 'Set oDesign = oProject.SetActiveDesign("%s")\n', designName);
fprintf(fid, 'Set oEditor = oDesign.SetActiveEditor("3D Modeler")\n');