function cover_loading_CLD_vbs(varargin)

%
% cover_loading_CLD_vbs.m
%
% Description:
%   Builds macro to create a combline filter with cover loading within 
%   HFSS based on WEAFIL WGD data file.
%
% Inputs:
%   varargin{1} ->  filter_info struct containing design specs from WEAFIL
%   varargin{2} ->  HFSS_proj name
%
% Outputs:
%   VBScript macro file for HFSS
%
% Author:
%   Curtis Neiderer, 3/5/2009
%
% Notes / Changes:
%   Version 1: 3/5/2009
%

%% Assign Input Arguments
if nargin==2
    filter_info=varargin{1};
    HFSS_proj=varargin{2};
elseif nargin==1
    filter_info=varargin{1};
    HFSS_proj=fullfile('',['combline_',datestr(now,30),'.hfss']);
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

%% Resonator Layout
for ii=1:SymRes
    hfss_VariableDefinition(fid,['res',num2str(ii),'_loc'],...
        filter_info.resonator_loc(ii),filter_info.units.length);
    hfss_VariableDefinition(fid,['res',num2str(ii),'_length'],...
        filter_info.res_length,filter_info.units.length);
    hfss_VariableDefinition(fid,['resPhys',num2str(ii),'_length'],...
        filter_info.res_PhysLength,filter_info.units.length);
%     hfss_VariableDefinition(fid,['res',num2str(ii),'_spacing'],...
%         filter_info.res_spacing(ii),filter_info.units.length);
%     hfss_VariableDefinition(fid,['tuning',num2str(ii),'_gap'],...
%         filter_info.tuning_gaps(ii),filter_info.units.length);
end

%% General Filter Dimensions
hfss_VariableDefinition(fid,'GPS',filter_info.GPS,...
    filter_info.units.length)
hfss_VariableDefinition(fid,'Res_diameter',filter_info.res_diameter,...
    filter_info.units.length);
hfss_VariableDefinition(fid,'Res_innerDiameter',...
	filter_info.res_innerDiameter,filter_info.units.length);
hfss_VariableDefinition(fid,'Filter_length',filter_info.filter_length,...
    filter_info.units.length);
hfss_VariableDefinition(fid,'Filter_height',...
    (filter_info.res_length+filter_info.cover_thickness),...
    filter_info.units.length);
hfss_VariableDefinition(fid,'CoverAir_dia',filter_info.cover_diameter,...
    filter_info.units.length);
hfss_VariableDefinition(fid,'CoverAir_thickness',...
    filter_info.cover_thickness,filter_info.units.length);

%% Draw and Parameterize Objects
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Draw Objects and Parameterize Necessary Dimensions \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

%% Draw FilterAir
fprintf(fid, '\n');
fprintf(fid, ''' ----- Draw FilterAir ');
fprintf(fid, '\n');
hfss_CreateBox(fid,'FilterAir','-GPS/2',0,0,'GPS','Filter_length',...
    filter_info.res_length,'in',[85,85,85],0.5);

        
%         % CoverAir
%         hfss_CreateCylinder(fid,['CoverAir',num2str(kk)],'Z',...
%             0,['res',num2str(kk),'_loc'],'Filter_height','CoverAir_dia/2',...
%             'CoverAir_height',filter_info.units.length);
%         % CoverAir Name & Sym CoverAir Name
%         CoverAirList=[CoverAirList,{['CoverAir',num2str(kk)]},...
%             {['CoverAir',num2str(kk),'_1']}];        
%         
%         % CoverAir
%         hfss_CreateCylinder(fid,['CoverAir',num2str(kk)],'Z',...
%             0,['res',num2str(kk),'_loc'],'Filter_height',...
%             'CoverAir_dia/2','CoverAir_height',filter_info.units.length);
%         % CoverAir Name & Sym CoverAir Name
%         CoverAirList=[CoverAirList,{['ResAir',num2str(kk)]}]; 

%% Draw Resonators & CoverAir
ResNameList={}; % Cell array with res names to be cut from FilterAir
ResSubNameList={};
CoverAirList={};
if strcmpi(SymType,'even')
    for kk=1:SymRes

        fprintf(fid, '\n');
        fprintf(fid, [''' ----- Draw Res',num2str(kk)]);
        fprintf(fid, '\n');
        hfss_CreateCylinder(fid,['Res',num2str(kk)],'Z',...
            0,['res',num2str(kk),'_loc'],0,...
            'Res_diameter/2',['resPhys',num2str(kk),'_length'],...
            filter_info.units.length,[85,85,85],0.5);
        % Res Name and Sym Res Name 
        ResNameList=[ResNameList,{['Res',num2str(kk)]},...
            {['Res',num2str(kk),'_1']}]; 
        
        fprintf(fid, '\n');
        fprintf(fid, [''' ----- Draw ResSub',num2str(kk)]);
        fprintf(fid, '\n');
        hfss_CreateCylinder(fid,['ResSub',num2str(kk)],'Z',...
            0,['res',num2str(kk),'_loc'],['resPhys',num2str(kk),'_length'],...
            'Res_innerDiameter/2',['resPhys',num2str(kk),...
            '_length-res',num2str(kk),'_length'],...
            filter_info.units.length,[255,0,0],0.5);
        % ResSub Name and Sym ResSub Name 
        ResSubNameList=[ResSubNameList,{['ResSub',num2str(kk)]},...
            {['ResSub',num2str(kk),'_1']}]; 
            
        fprintf(fid, '\n');
        fprintf(fid, [''' ----- Draw CoverAir',num2str(kk)]);
        fprintf(fid, '\n');
        hfss_CreateCylinder(fid,['Load',num2str(kk)],'Z',...
            0,['res',num2str(kk),'_loc'],filter_info.res_length,...
            'CoverAir_dia/2','CoverAir_thickness',...
            filter_info.units.length,[0,0,255],0.5);
        % Load Name and Sym Load Name 
        CoverAirList=[CoverAirList,{['Load',num2str(kk)]},...
            {['Load',num2str(kk),'_1']}];        
                            
    end
elseif strcmpi(SymType,'odd')
    for kk=1:SymRes
        
        fprintf(fid, '\n');
        fprintf(fid, [''' ----- Draw Res',num2str(kk)]);
        fprintf(fid, '\n');
        hfss_CreateCylinder(fid,['Res',num2str(kk)],'Z',...
            0,['res',num2str(kk),'_loc'],0,...
            'Res_diameter/2',['resPhys',num2str(kk),'_length'],...
            filter_info.units.length,[85,85,85],0.5);
        % Res Name and Sym Res Name 
        ResNameList=[ResNameList,{['Res',num2str(kk)]}]; 
        
        fprintf(fid, '\n');
        fprintf(fid, [''' ----- Draw ResSub',num2str(kk)]);
        fprintf(fid, '\n');
        hfss_CreateCylinder(fid,['ResSub',num2str(kk)],'Z',...
            0,['res',num2str(kk),'_loc'],['resPhys',num2str(kk),'_length'],...
            'Res_innerDiameter/2',['resPhys',num2str(kk),...
            '_length-res',num2str(kk),'_length'],...
            filter_info.units.length,[255,0,0],0.5);
        % ResSub Name and Sym ResSub Name 
        ResSubNameList=[ResSubNameList,{['ResSub',num2str(kk)]}]; 
            
        fprintf(fid, '\n');
        fprintf(fid, [''' ----- Draw CoverAir',num2str(kk)]);
        fprintf(fid, '\n');
        hfss_CreateCylinder(fid,['Load',num2str(kk)],'Z',...
            0,['res',num2str(kk),'_loc'],filter_info.res_length,...
            'CoverAir_dia/2','CoverAir_thickness',...
            filter_info.units.length,[0,0,255],0.5);
        % Load Name and Sym Load Name 
        CoverAirList=[CoverAirList,{['Load',num2str(kk)]}];  

        % Add Sym Res Name & Load Name
        if kk < SymRes
            ResNameList=[ResNameList,{['Res',num2str(kk),'_1']}];
            ResSubNameList=[ResSubNameList,{['ResSub',num2str(kk),'_1']}];
            CoverAirList=[CoverAirList,{['Load',num2str(kk),'_1']}];
        end
        
    end
end

% Assign material 
hfss_AssignMaterial(fid,ResNameList,'pec','metal')
hfss_AssignMaterial(fid,CoverAirList,'pec','metal')

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

% Subtract Resonator_Subs from Resonators
for pp=1:SymRes
    fprintf(fid, '\n');
    fprintf(fid, [''' ----- Subtracting ResSub',num2str(pp),...
        ' from Res',num2str(pp)]);
    fprintf(fid, '\n');
    hfss_Subtract(fid,{['Res',num2str(pp)]},{['ResSub',num2str(pp)]},true);
end

%% Duplicate around SymPoint
dup_resonators={}; dup_coverair={};
if strcmpi(SymType,'even')
    for mm=1:SymRes
        dup_resonators=[dup_resonators,{['Res',num2str(mm)]}];
        dup_coverair=[dup_coverair,{['Load',num2str(mm)]}];
    end
elseif strcmpi(SymType,'odd')
    for mm=1:(SymRes-1)
        dup_resonators=[dup_resonators,{['Res',num2str(mm)]}];
        dup_coverair=[dup_coverair,{['Load',num2str(mm)]}];
    end    
end

% Unite TapLine1 with Res1 and SMA_InnerCond1
fprintf(fid, '\n');
fprintf(fid, ''' ----- Unite Tapline1 and SMA_InnerCond1 with Res1');
fprintf(fid, '\n');
hfss_Unite(fid,{'Res1','Tapline1','SMA_InnerCond1'});

% Duplicate resonators & CoverAir
fprintf(fid, '\n');
fprintf(fid, ''' ----- Duplicate Resonators & Resonator Loads')
fprintf(fid, '\n');
hfss_DuplicateMirror(fid,dup_resonators,0,SymPoint,0,0,1,0,...
    filter_info.units.length);
hfss_DuplicateMirror(fid,dup_coverair,0,SymPoint,0,0,1,0,...
    filter_info.units.length);

% Duplicate SMA, Port, etc.
fprintf(fid, '\n');
fprintf(fid, ''' ----- Duplicate SMA_Dielectric1 and Port1');
fprintf(fid, '\n');
duplicate_obj_list=[{'SMA_Dielectric1'},{'Port1'}];
hfss_DuplicateMirror(fid,duplicate_obj_list,0,SymPoint,0,0,1,0,...
    filter_info.units.length);

% Unite
fprintf(fid, '\n');
fprintf(fid, ''' ----- FilterAir with SMA_Dielectrics');
fprintf(fid, '\n');
hfss_Unite(fid,{'FilterAir','SMA_Dielectric1','SMA_Dielectric1_1'});

% Unite FilterAir with CoverAir
hfss_Unite(fid,[{'FilterAir'},CoverAirList]);

% Subtract Resonators from FilterAir
fprintf(fid, '\n');
fprintf(fid, ''' ----- Subtract Resonators from FilterAir');
fprintf(fid, '\n');
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