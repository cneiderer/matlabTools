function hfss_SaveProject(fid,projectFile,Overwrite)

% Inputs:
if ~exist('Overwrite','var') || isempty(Overwrite)
	Overwrite = false;
end;

% SaveProject
fprintf(fid, '\n');
fprintf(fid, 'oProject.SaveAs _\n');
fprintf(fid, '    "%s", _\n', projectFile);
if (Overwrite)
    fprintf(fid, '    true\n');
else
    fprintf(fid, '    false\n');
end;