function IDD_lumped_loading_vbs(varargin)

%
% IDD_parallelplate_loaded_vbs.m
%
% Description:
%   Builds macro to create a interdigital filter with lumped loading within 
%   HFSS based on WEAFIL CLD data file.
%
% Inputs:
%   varargin{1} ->  filter_info struct containing design specs from WEAFIL
%   varargin{2} ->  HFSS_proj name
%
% Outputs:
%   VBScript macro file for HFSS
%
% Author:
%   Curtis Neiderer, xx/xx/2009
%
% Notes / Changes:

%% Assign Input Arguments
if nargin==2
    filter_info=varargin{1};
    HFSS_proj=varargin{2};
elseif nargin==1
    filter_info=varargin{1};
    HFSS_proj=fullfile('',['interdigital_',datestr(now,30),'.hfss']);
elseif nargin==0
    error('No input arguments')
else
    error('Something weird happened')
end

%% Find Symmetry Point
if mod(filter_info.resonators,2)==1
%     draw_res_through=ceil(filter_info.resonators/2);
    SymRes=ceil(filter_info.resonators/2);
    SymPoint=filter_info.resonator_loc(ceil(filter_info.resonators/2));
    SymType='odd';
elseif mod(filter_info.resonators,2)==0
%     draw_res_through=filter_info.resonators/2;
    SymRes=(filter_info.resonators/2);
    SymPoint=filter_info.filter_length/2;
    SymType='even';
end

%% Create VBS file
[pathstr,filename]=fileparts(HFSS_proj);
vbs_file=fullfile('S:\Curtis_Neiderer\VBScript_Files',[filename,'.vbs']);
fid=fopen(vbs_file,'w');

%% Add header to VBS file
createVBSheader(fid,vbs_file);

%% Open new HFSS Project
hfss_NewProject(fid)

%% Insert Design
hfss_InsertDesign(fid,filename,'driven modal');

%% Define Design Properties
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' ---------------------------------------------- \n');
fprintf(fid, ''' Define Design Properties \n');
fprintf(fid, ''' ---------------------------------------------- \n');
fprintf(fid, '\n');

% SMA Dimensions
hfss_VariableDefinition(fid,'SMA_InnerCond_dia',0.05,...
    filter_info.units.length);
hfss_VariableDefinition(fid,'SMA_Dielectric_dia',0.136,...
    filter_info.units.length);
hfss_VariableDefinition(fid,'SMA_length',0.136,...
    filter_info.units.length);

% Tap Dimensions
hfss_VariableDefinition(fid,'Tap_location',filter_info.tap_location,...
    filter_info.units.length);
hfss_VariableDefinition(fid,'Tap_length',filter_info.tapline_len,...
    filter_info.units.length);
hfss_VariableDefinition(fid,'Tap_diameter',filter_info.tapline_dia,...
    filter_info.units.length);

% Resonator Dimensions

%% Draw and Parameterize Objects
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Draw Objects and Parameterize Necessary Dimensions \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

%% Draw Resonators


% Assign material to resonators
fprintf(fid, '\n');
fprintf(fid, ''' ----- Set Resonator Material ');
hfss_AssignMaterial(fid,ResNameList,'pec','metal');

%% Draw Tap Line
% Tapline1
fprintf(fid, '\n');
fprintf(fid, ''' ----- Draw Tapline ');
hfss_CreateCylinder(fid,'Tapline1','Y',0,0,'Tap_location',...
    'Tap_diameter/2','Tap_length+(Res_diameter/2)',...
    filter_info.units.length,[85,85,85],0.5);

fprintf(fid, '\n');
fprintf(fid, ''' ----- Set Tapline Material ');
hfss_AssignMaterial(fid,'Tapline1','pec','metal');

%% Draw SMA Connectors
% Dielectrics
fprintf(fid, '\n');
fprintf(fid, ''' ----- Draw SMA Dielectric ');
hfss_CreateCylinder(fid,'SMA_Dielectric1','Y',0,0,'Tap_location',...
    'SMA_Dielectric_dia/2','-SMA_length','in',[85,85,85],0.5);

fprintf(fid, '\n');
fprintf(fid, ''' ----- Set Dielectric Material ');
hfss_AssignMaterial(fid,'SMA_Dielectric1','pec','metal');
% InnerConds
fprintf(fid, '\n');
fprintf(fid, ''' ----- Draw SMA InnerCond')
hfss_CreateCylinder(fid,'SMA_InnerCond1','Y',0,0,'Tap_location',...
    'SMA_InnerCond_dia/2','-SMA_length','in',[85,85,85],0.5);

fprintf(fid, '\n');
fprintf(fid, ''' ----- Set InnerCond Material ');
hfss_AssignMaterial(fid,'SMA_InnerCond1','pec','metal');

%% Draw and Assign Ports
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Draw Sheet Objects and Assign WavePorts \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

hfss_CreateCircle(fid,'Port1','Y',0,'-SMA_length','Tap_location',...
    'SMA_Dielectric_dia/2','in');
hfss_AssignWavePort(fid,'P1','Port1',1,false,[0,0,0],[0,0,0],...
    filter_info.units.length);

%% Mirror Duplicate
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Mirror Duplicate, Unite, and Subtract Objects \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

% Duplicate resonators 
dup_resonators={};
if strcmpi(SymType,'even')
    for mm=1:SymRes
        dup_resonators=[dup_resonators,{['Res',num2str(mm)]}];
    end
elseif strcmpi(SymType,'odd')
    for mm=1:(SymRes-1)
        dup_resonators=[dup_resonators,{['Res',num2str(mm)]}];
    end    
end

% Unite TapLine1 with Res1 and SMA_InnerCond1
hfss_Unite(fid,{'Res1','Tapline1','SMA_InnerCond1'});

hfss_DuplicateMirror(fid,dup_resonators,0,SymPoint,0,0,1,0,...
    filter_info.units.length);

% Duplicate SMA, Port, etc.
duplicate_obj_list=[{'SMA_Dielectric1'},{'Port1'}];
hfss_DuplicateMirror(fid,duplicate_obj_list,0,SymPoint,0,0,1,0,...
    filter_info.units.length);

% Unite
hfss_Unite(fid,{'FilterAir','SMA_Dielectric1','SMA_Dielectric1_1'});

% Subtract Resonators from FilterAir
hfss_Subtract(fid,{'FilterAir'},ResNameList,true);

%% Analysis Setup
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Analysis: Insert Solution Setup and Add Freq Sweep \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

%% Insert Solution Setup
center_freq=filter_info.f_lower+((filter_info.f_upper-filter_info.f_lower)/2);
hfss_InsertSolutionSetup(fid, 'Setup1',center_freq,.1,25);

%% Add Frequency Sweep
lo_rej_freq=filter_info.f_lower-(center_freq*.25);
hi_rej_freq=filter_info.f_upper+(center_freq*.25);
hfss_InsertFastSweep(fid,'Sweep1','Setup1',lo_rej_freq,hi_rej_freq,100);

%% Save HFSS Working Design 
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Save copy of base design \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

hfss_SaveProject(fid,...
    fullfile('C:\Curtis_Neiderer\HFSS_Projects\VBS_created_projects',...
    ['workingdesign_',HFSS_proj]), false);

%% Close VBScript file
fclose(fid);