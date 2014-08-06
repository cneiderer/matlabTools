function hfss_CreateBox(fid,Name,XStart,YStart,ZStart,...
    XSize,YSize,ZSize,Units,RGB,Transparency)

%% Set default color and transparency, if necessary
if ~exist('RGB','var') || isempty(RGB)
    RGB=[0.15686,0.15686,0.15686];
end
if ~exist('Transparency','var')
    Transparency=0.5;
end

%% Create the box
fprintf(fid, '\n');
fprintf(fid, 'oEditor.CreateBox _\n');
fprintf(fid, 'Array("NAME:BoxParameters", _\n');
fprintf(fid, '\t "CoordinateSystemID:=", -1, _\n');
fprintf(fid, '\t "XPosition:=", "-0.5in", _\n');
fprintf(fid, '\t "YPosition:=", "-0.5in", _\n');
fprintf(fid, '\t "ZPosition:=", "-0.5in", _\n');
fprintf(fid, '\t "XSize:=", "1in", _\n');
fprintf(fid, '\t "YSize:=", "1in", _\n');
fprintf(fid, '\t "ZSize:=", "1in"), _\n'); 
fprintf(fid, 'Array("NAME:Attributes", _\n');
fprintf(fid, '\t "Name:=", "%s", _\n', Name);
fprintf(fid, '\t "Flags:=", "", _\n');
fprintf(fid, '\t "Color:=", "(132 132 193)", _\n');
fprintf(fid, '\t "Transparency:=", 0, _\n');
fprintf(fid, '\t "PartCoordinateSystem:=", "Global", _\n');
fprintf(fid, '\t "MaterialName:=", "vacuum", _\n');
fprintf(fid, '\t "SolveInside:=", true)\n');

fprintf(fid, '\n');

%% Parameterize the box
fprintf(fid, 'oEditor.ChangeProperty _\n');
fprintf(fid, 'Array("NAME:AllTabs", _\n');
fprintf(fid, '\t Array("NAME:Geometry3DCmdTab", _\n');
fprintf(fid, '\t\t Array("NAME:PropServers", _\n');
fprintf(fid, '\t\t "%s:CreateBox:1"), _\n', Name);
fprintf(fid, '\t\t Array("NAME:ChangedProps", _\n');
fprintf(fid, '\t\t\t Array("NAME:Position", _\n');
    fprintf(fid, '\t\t\t "X:=", ');
        var_type(fid,XStart,Units);
    fprintf(fid, ', _\n');
    fprintf(fid, '\t\t\t "Y:=", '); 
        var_type(fid,YStart,Units);
    fprintf(fid, ', _\n');
    fprintf(fid, '\t\t\t "Z:=", '); 
        var_type(fid,ZStart,Units);
    fprintf(fid, '), _\n');
    fprintf(fid, '\t\t\t Array("NAME:XSize", "Value:=", '); 
        var_type(fid,XSize,Units);
    fprintf(fid, '), _\n');
    fprintf(fid, '\t\t\t Array("NAME:YSize", "Value:=", '); 
        var_type(fid,YSize,Units);
    fprintf(fid, '), _\n');
    fprintf(fid, '\t\t\t Array("NAME:ZSize", "Value:=", '); 
        var_type(fid,ZSize,Units,1);
    fprintf(fid, ') _\n');
fprintf(fid, '\t\t ) _\n');
fprintf(fid, '\t ) _\n');
fprintf(fid, ') \n');

fprintf(fid, '\n');

%% Set box color
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

%%% ---------- %% Sub-Functions %% ---------- %%%

%% Find variable type
function var_type(fid,var_under_test,Units,flag)

if isstr(var_under_test)
    fprintf(fid, '"%s"',var_under_test);
else
    fprintf(fid, '"%f%s"',var_under_test,Units);
end
