function test_function

%% Create VBS file
vbs_file=fullfile('S:\Curtis_Neiderer\VBScript_Files','test_function.vbs');
fid=fopen(vbs_file,'w');

%% Add header to VBS file
createVBSheader(fid,vbs_file);

%% Open new HFSS Project
hfss_NewProject(fid)

%% Insert Design
hfss_InsertDesign(fid,'test_function','driven modal');

%%
hfss_VariableDefinition(fid,'xbox',1,'in');
hfss_VariableDefinition(fid,'ybox',1,'in');
hfss_VariableDefinition(fid,'zbox',1,'in');

%%
hfss_CreateBox_Test(fid,'TEST','-xbox/2','-ybox/2','-zbox/2',...
    'xbox','ybox','zbox','in',[50,50,50],0.25)