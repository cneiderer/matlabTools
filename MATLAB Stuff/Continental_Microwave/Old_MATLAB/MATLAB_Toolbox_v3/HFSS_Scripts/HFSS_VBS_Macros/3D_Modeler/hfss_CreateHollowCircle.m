function hfss_CreateHollowCircle(fid,Name,Axis,XCenter,YCenter,ZCenter,...
    InnerRad,OuterRad,Units)

% Inner Circle
hfss_CreateCircle(fid,'Inner_Circle',Axis,XCenter,YCenter,ZCenter,...
    InnerRad,Units)

% Outer Circle
hfss_CreateCircle(fid,'Outer_Circle',Axis,XCenter,YCenter,ZCenter,...
    OuterRad,Units)

% Subtract to form Hollow Circle
hfssSubtract(fid,{'Outer_Circle'},{'Inner_Circle'})

% Set Name Attribute of Hollow Circle 
fprintf(fid, 'oEditor.ChangeProperty _\n');
fprintf(fid, 'Array("NAME:AllTabs", _\n');
fprintf(fid, '\t Array("NAME:Geometry3DAttributeTab", _\n');
fprintf(fid, '\t\t Array("NAME:PropServers", "Outer_Circle"), _\n');
fprintf(fid, '\t\t Array("NAME:ChangedProps", _\n');
fprintf(fid, '\t\t\t Array("NAME:Name", "Value:=", "%s"), _\n', Name);
fprintf(fid, '\t\t\t Array("NAME:Color", "R:=", 255, "G:=", 0, "B:=", 0), _\n');
fprintf(fid, '\t\t\t Array("NAME:Transparent", "Value:=", 0.4) _\n');
fprintf(fid, '\t\t) _\n');
fprintf(fid, '\t) _\n');
fprintf(fid, ') \n');

