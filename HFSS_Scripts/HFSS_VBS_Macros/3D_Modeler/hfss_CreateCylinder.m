function hfss_CreateCylinder_Test(fid,Name,Axis,XCenter,YCenter,ZCenter,...
    Radius,Height,Units,RGB,Transparency)

% Draw Cylinder
fprintf(fid, '\n');
fprintf(fid, 'oEditor.CreateCylinder _\n');
fprintf(fid, 'Array("NAME:CylinderParameters", _\n');
    fprintf(fid, '"CoordinateSystemID:=", -1, _\n');
    fprintf(fid, '"XCenter:=", "0in", _\n');
    fprintf(fid, '"YCenter:=", "0in", _\n');
    fprintf(fid, '"ZCenter:=", "0in", _\n');
    fprintf(fid, '"Radius:=", "0.2in", _\n');
    fprintf(fid, '"Height:=", "1in", _\n');
    fprintf(fid, '"WhichAxis:=", "Z", _\n');
    fprintf(fid, '"NumSides:=", "0"), _\n');
fprintf(fid, 'Array("NAME:Attributes", _\n');
	fprintf(fid, '"Name:=", "%s", _\n', Name);
	fprintf(fid, '"Flags:=", "", _\n');
	fprintf(fid, '"Color:=", "(132 132 193)", _\n');
	fprintf(fid, '"Transparency:=", 0, _\n');
	fprintf(fid, '"PartCoordinateSystem:=", "Global", _\n');
    fprintf(fid, '"MaterialName:=", "vacuum", _\n');
    fprintf(fid, '"SolveInside:=", true) \n');
    
fprintf(fid, '\n');

% Parameterize Cylinder
fprintf(fid, 'oEditor.ChangeProperty _\n');
fprintf(fid, 'Array("NAME:AllTabs", _\n');
fprintf(fid, '\t Array("NAME:Geometry3DCmdTab", _\n');
fprintf(fid, '\t\t Array("NAME:PropServers", "%s:CreateCylinder:1"), _\n', Name);
fprintf(fid, '\t\t Array("NAME:ChangedProps", _\n');
fprintf(fid, '\t\t\t Array("NAME:Center Position", _\n');
    fprintf(fid, '\t\t\t\t "X:=", ');
        var_type(fid,XCenter,Units);
    fprintf(fid, ', _\n');
    fprintf(fid, '\t\t\t\t "Y:=", ');
        var_type(fid,YCenter,Units);
    fprintf(fid, ', _\n');
    fprintf(fid, '\t\t\t\t "Z:=", ');
        var_type(fid,ZCenter,Units);
    fprintf(fid, '), _\n');
fprintf(fid, '\t\t\t Array("NAME:Radius", _\n');
    fprintf(fid, '\t\t\t\t "Value:=", ');
        var_type(fid,Radius,Units);
    fprintf(fid, '), _\n');
fprintf(fid, '\t\t\t Array("NAME:Height", _\n');
    fprintf(fid, '\t\t\t\t "Value:=", ');
        var_type(fid,Height,Units);
    fprintf(fid, '), _\n');
fprintf(fid, '\t\t\t Array("NAME:Axis", _\n');
    fprintf(fid, '\t\t\t\t "Value:=", "%s") _\n', Axis);
fprintf(fid, '\t\t) _\n');
fprintf(fid, '\t) _\n');
fprintf(fid, ') \n');

fprintf(fid, '\n');

%% Set cylinder color
fprintf(fid, 'oEditor.ChangeProperty _\n');
fprintf(fid, 'Array("NAME:AllTabs", _\n');
fprintf(fid, '\t Array("NAME:Geometry3DAttributeTab", _\n');
fprintf(fid, '\t\t Array("NAME:PropServers", "%s"), _\n', Name);
fprintf(fid, '\t\t Array("NAME:ChangedProps", _\n');
fprintf(fid, '\t\t\t Array("NAME:Color", _\n');
fprintf(fid, '\t\t\t\t "R:=", %d, _\n', RGB(1));
fprintf(fid, '\t\t\t\t "G:=", %d, _\n', RGB(2));
fprintf(fid, '\t\t\t\t "B:=", %d _\n', RGB(3));
fprintf(fid, '\t\t\t ) _\n');
fprintf(fid, '\t\t ) _\n');
fprintf(fid, '\t ) _\n');
fprintf(fid, ')\n');

fprintf(fid, '\n');

%% Set box transparency
fprintf(fid, 'oEditor.ChangeProperty _\n');
fprintf(fid, 'Array("NAME:AllTabs", _\n');
fprintf(fid, '\t Array("NAME:Geometry3DAttributeTab", _\n');
fprintf(fid, '\t\t Array("NAME:PropServers", "%s"), _\n', Name);
fprintf(fid, '\t\t Array("NAME:ChangedProps", _\n');
fprintf(fid, '\t\t\t Array("NAME:Transparent", _\n');
fprintf(fid, '\t\t\t\t "Value:=", %f _\n', Transparency);
fprintf(fid, '\t\t\t ) _\n');
fprintf(fid, '\t\t ) _\n');
fprintf(fid, '\t ) _\n');
fprintf(fid, ') \n');

fprintf(fid, '\n');

%%%%% ---------- %% Sub-Functions %% ---------- %%%%%
%% Find variable type
function var_type(fid,var_under_test,Units,flag)

if isstr(var_under_test)
    fprintf(fid, '"%s"',var_under_test);
else
    fprintf(fid, '"%f%s"',var_under_test,Units);
end

% % Close or Continue
% if (exist('flag','var')) && (flag==1)
%     fprintf(fid, ') _\n');
% else 
%     fprintf(fid, ', _\n');
% end