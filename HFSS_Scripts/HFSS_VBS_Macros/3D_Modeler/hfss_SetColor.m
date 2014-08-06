function hfss_SetColor(fid,ObjectList,Color)

if isstr(ObjectList)
    ObjectList={ObjectList};
% elseif iscell(ObjectList)
%     ObjectList=ObjectList;
end

nObjects=length(ObjectList);
for ii=1:nObjects
    
%     disp(ObjectList{ii});
    % ChangeProperty
    fprintf(fid, '\n');
    fprintf(fid, 'oEditor.ChangeProperty _\n');

    fprintf(fid, 'Array("NAME:AllTabs", _\n');
    fprintf(fid, '\t Array("NAME:Geometry3DAttributeTab", _\n');
    fprintf(fid, '\t\t Array("NAME:PropServers", "%s"), _\n',...
        ObjectList{ii});
    fprintf(fid, '\t\t Array("NAME:ChangedProps",  _\n');
    if isstr(Color)
        Color=get_color(Color);
        fprintf(fid, '\t\t\t Array("NAME:Color", "R:=", %d, "G:=", %d, "B:=", %d) _\n', ...
            Color(1), Color(2), Color(3));
    else
        fprintf(fid, '\t\t\t Array("NAME:Color", "R:=", %d, "G:=", %d, "B:=", %d) _\n', ...
            Color(1), Color(2), Color(3));
    end
    
    fprintf(fid, '\t\t) _\n');
    fprintf(fid, '\t) _\n');
    fprintf(fid, ') \n');
end

%% ---------- %% Sub-Functions %% ---------- %%
function [RGB] = get_color(Color)

switch Color
    case ('red')
        RGB=[255,0,0];
    case ('blue')
        RGB=[0,0,255];
    case ('green')
        RGB=[0,255,0];
    case ('yellow')
        RGB=[255,255,0];
    case ('cyan')
        RGB=[0,255,255];
    case ('orange')
        RGB=[255,69,0];
    case ('black')
        RGB=[0,0,0];
    case ('charcoal')
        RGB=[105,105,105];
    otherwise
        error('Specified color does not match any case!!!');
end