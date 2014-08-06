function []=MATLAB_HFSS_box

vbs_file=fullfile('S:\Curtis_Neiderer\VBScript_Files',['MATLAB_box.vbs']);
fid=fopen(vbs_file,'w');

%% Add header to VBS file
createVBSheader(fid,vbs_file);

%% Open new HFSS Project
hfss_NewProject(fid)

%% Insert Design
hfss_InsertDesign(fid,'MATLAB_box','driven modal');

%%
hfss_VariableDefinition(fid,'xStart',-5,'in');
hfss_VariableDefinition(fid,'yStart',-5,'in');
hfss_VariableDefinition(fid,'zStart',-5,'in');
hfss_VariableDefinition(fid,'xSize',10,'in');
hfss_VariableDefinition(fid,'ySize',10,'in');
hfss_VariableDefinition(fid,'zSize',10,'in');


%%
hfss_CreateBox_Test(fid,'Box1',0,0,0,1,1,1,'in',[1,1,1],0.7)

%% Close VBScript file
fclose(fid);