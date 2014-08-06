function hfss_IncludeVarForOptimization(fid,VarName)


fprintf(fid, 'oDesign.ChangeProperty _\n');
fprintf(fid, 'Array("NAME:AllTabs", _\n');
fprintf(fid, 'Array("NAME:LocalVariableTab", _\n');
fprintf(fid, 'Array("NAME:PropServers", "LocalVariables"), _\n');
fprintf(fid, 'Array("NAME:ChangedProps", _\n');

% VarList
nVar=length(VarName);
for ii=1:nVar
    fprintf(fid, 'Array("NAME:%s", _\n', VarName(ii));
    fprintf(fid, 'Array("NAME:Optimization", _\n');
    fprintf(fid, '"Included:=", true))');
    if ii==nVar
        fprintf(fid, ')))');
    else
        fprintf(fid, ', _\n');
    end
end
