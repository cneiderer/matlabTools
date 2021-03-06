function flag=deletemeshfile(fname)
try
    if(exist(mwpath(fname))) 
	delete(mwpath(fname)); 
    end
catch
    error(['You do not have permission to delete temporary files, if you are working in a multi-user ',...
         'environment, such as Unix/Linux and there are other users using iso2mesh, ',...
         'you may need to define ISO2MESH_SESSION=''yourstring'' to make your output ',...
         'files different from others; if you do not have permission to ',mwpath(''),...
         ' as the temporary directory, you have to define ISO2MESH_TEMP=''/path/you/have/write/permission'' ',...
         'in matlab/octave base workspace.']);
end

