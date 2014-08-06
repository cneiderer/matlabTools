function [] = lumped_loading_vbs_v3(varargin);

%
% lumped_loading_vbs.m
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
% fid=fopen(fullfile('S:\Curtis_Neiderer\MATLAB_Toolbox',...
%     'combline_filter_design_v1.vbs'),'w');
[pathstr,filename]=fileparts(HFSS_proj);
fid=fopen(fullfile('S:\Curtis_Neiderer\MATLAB_Toolbox\VBS_files',...
    [filename,'.vbs']),'w');

%% Add header to VBS file
createVBSheader(fid,...
    fullfile('S:\Curtis_Neiderer\MATLAB_Toolbox\VBS_files',...
    [filename,'.vbs']));

%% Open new HFSS Project
hfssNewProject(fid);

%% Insert Design
hfssInsertDesign(fid,filename,'driven modal');

%% Define Design Properties
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' ---------------------------------------------- \n');
fprintf(fid, ''' Define Design Properties \n');
fprintf(fid, ''' ---------------------------------------------- \n');
fprintf(fid, '\n');

% SMA Variables
hfssVariableDefinition(fid,'SMA_InnerCond_dia',0.05,...
    filter_info.units.length);
hfssVariableDefinition(fid,'SMA_Dielectric_dia',0.136,...
    filter_info.units.length);

% Tap Variables
hfssVariableDefinition(fid,'Tap_location',filter_info.tap_location,...
    filter_info.units.length);
hfssVariableDefinition(fid,'Tap_length',filter_info.tapline_len,...
    filter_info.units.length);
hfssVariableDefinition(fid,'Tap_diameter',filter_info.tapline_dia,...
    filter_info.units.length);

% Resonator Variables
hfssVariableDefinition(fid,'Res_diameter',filter_info.res_diameter,...
    filter_info.units.length);

% if strcmpi(SymType,'even') % Even # of Resonators
    for ii=1:SymRes
        hfssVariableDefinition(fid,['res',num2str(ii),'_loc'],...
            filter_info.resonator_loc(ii),filter_info.units.length);
        hfssVariableDefinition(fid,['res',num2str(ii),'_length'],...
            filter_info.res_length,filter_info.units.length);
    end
% elseif strcmpi(SymType,'odd') % Odd # of Resonators
%     for jj=1:SymRes
%         hfssVariableDefinition(fid,['res',num2str(jj),'_loc'],...
%             filter_info.resonator_loc(jj),filter_info.units.length);
%         hfssVariableDefinition(fid,['res',num2str(jj),'_length'],...
%             filter_info.res_length,filter_info.units.length);
%     end
% end

% Filter Dim
hfssVariableDefinition(fid,'GPS',filter_info.GPS,...
    filter_info.units.length)
hfssVariableDefinition(fid,'Res_gap',filter_info.resonator_gap,...
    filter_info.units.length)
hfssVariableDefinition(fid,'Filter_length',filter_info.filter_length,...
    filter_info.units.length)
hfssVariableDefinition(fid,'Filter_height',...
    (filter_info.res_length+filter_info.resonator_gap),...
    filter_info.units.length)


%% Draw and Parameterize Objects
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Draw Objects and Parameterize Necessary Dimensions \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

%% Draw FilterAir
hfssBox(fid,'FilterAir',...
	[-filter_info.GPS/2,0,0],[filter_info.GPS,filter_info.filter_length,...
    (filter_info.res_length+filter_info.resonator_gap)],'in')

%% Draw Resonators
cut_resonators={}; % Cell array with res names to be cut from FilterAir
if strcmpi(SymType,'even')
    for kk=1:SymRes
        hfssCylinder(fid,['Res',num2str(kk)],'Z',...
            [0,filter_info.resonator_loc(kk),0],...
            (filter_info.res_diameter/2),filter_info.res_length,'in');
        cut_resonators=[cut_resonators,{['Res',num2str(kk)]},...
            {['Res',num2str(kk),'_1']}];                             
    end
elseif strcmpi(SymType,'odd')
    for kk=1:SymRes
        hfssCylinder(fid,['Res',num2str(kk)],'Z',...
            [0,filter_info.resonator_loc(kk),0],...
            (filter_info.res_diameter/2),filter_info.res_length,'in');
        
%         if kk < SymRes
%             cut_resonators=[cut_resonators,{['Res',num2str(kk)]},...
%                 {['Res',num2str(kk),'_1']}];                             
%         else
%             cut_resonators=[cut_resonators,{['Res',num2str(kk)]}];
%         end
        
        cut_resonators=[cut_resonators,{['Res',num2str(kk)]}];
        if kk < SymRes
            cut_resonators=[cut_resonators,{['Res',num2str(kk),'_1']}];
        end
        
    end
end

%% Draw Tap Line
% Tapline1
hfssCylinder(fid,'TapLine1','Y',[0,0,filter_info.tap_location],...
    (filter_info.tapline_dia/2),...
    (filter_info.tapline_len+filter_info.res_diameter/2),'in');
hfssParameterizeCylinder(fid,'TapLine1','Y',0,0,'Tap_location',...
    'Tap_diameter/2','Tap_length+(Res_diameter/2)',...
    filter_info.units.length)

%% Draw SMA Connectors
% Dielectrics
hfssCylinder(fid,'SMA_Dielectric1','Y',[0,0,filter_info.tap_location],...
    (.136/2),-.136,'in');
hfssParameterizeCylinder(fid,'SMA_Dielectric1','Y',0,0,'Tap_location',...
    'SMA_Dielectric_dia/2','-SMA_Dielectric_dia','in')

% InnerConds
hfssCylinder(fid,'SMA_InnerCond1','Y',[0,0,filter_info.tap_location],...
    (.05/2),-.136,'in');
hfssParameterizeCylinder(fid,'SMA_InnerCond1','Y',0,0,'Tap_location',...
    (.05/2),-.136,'in')

%% Draw and Assign Ports
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Draw Sheet Objects and Assign WavePorts \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

% Port 1
hfssCircle(fid,'Port1','Y',[0,-.136,filter_info.tap_location],(.136/2),'in');
hfssCircle(fid,'Port1_2','Y',[0,-.136,filter_info.tap_location],(.05/2),'in');
hfssSubtract(fid,{'Port1'},{'Port1_2'});
hfssAssignWavePort(fid,'P1','Port1',1,false,[0,0,0],[0,0,0],'in');

%% Mirror Duplicate
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Mirror Duplicate Objects \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

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

duplicate_obj_list=[dup_resonators,{'TapLine1'},{'SMA_Dielectric1'},...
    {'SMA_InnerCond1'},{'Port1'}];
hfssDuplicateMirror(fid,duplicate_obj_list,[0,SymPoint,0],[0,1,0],...
    filter_info.units.length,true)

%% Save base design 
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Save base design \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

hfssSaveProject(fid,...
    fullfile('C:\Curtis_Neiderer\HFSS_Projects\VBS_created_projects',...
    ['design_',HFSS_proj]),false);

%% Unite & subtract necessary geometries
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Unite and Subtract Objects as Necessary \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

% Unite TapLine1 with Res1
hfssUnite(fid,{'Res1','TapLine1'});
hfssUnite(fid,{'Res1_1','TapLine1_1'});
% Subtract Resonators from FilterAir
hfssSubtract(fid,{'FilterAir'},cut_resonators)
% Subtract SMA_InnerConds from SMA_Dielectric
hfssSubtract(fid,{'SMA_Dielectric1'},{'SMA_InnerCond1'});
hfssSubtract(fid,{'SMA_Dielectric1_1'},{'SMA_InnerCond1_1'});

%% Analysis Setup
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Analysis: Insert Solution Setup and Add Freq Sweep \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

%% Insert Solution Setup
center_freq=filter_info.f_lower+((filter_info.f_upper-filter_info.f_lower)/2);
hfssInsertSolution(fid, 'Setup1',center_freq,.1,25)

%% Add Frequency Sweep
lo_rej_freq=filter_info.f_lower-(center_freq*.25);
hi_rej_freq=filter_info.f_upper+(center_freq*.25);
hfssFastSweep(fid,'Sweep1','Setup1',lo_rej_freq,hi_rej_freq,300)

%% Save HFSS Working Design 
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Save working copy of base design \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

hfssSaveProject(fid,...
    fullfile('C:\Curtis_Neiderer\HFSS_Projects\VBS_created_projects',...
    ['working_',HFSS_proj]), false);

% %% Close Active Project
% % Comment Section
% fprintf(fid, '\n');
% fprintf(fid, ''' -------------------------------------------------- \n');
% fprintf(fid, ''' Close Active Project \n');
% fprintf(fid, ''' -------------------------------------------------- \n');
% fprintf(fid, '\n');
% 
% hfssCloseActiveProject(fid)

%% Close *.vbs file
fclose(fid);