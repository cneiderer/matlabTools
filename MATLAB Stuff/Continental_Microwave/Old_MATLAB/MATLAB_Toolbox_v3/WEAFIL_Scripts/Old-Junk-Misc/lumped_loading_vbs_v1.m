function [] = lumped_loading_vbs(varargin);

%
% lumped_loading_vbs.m
%

%% Assign Input Arguments
if nargin==2
    filter_info=varargin{1};
    HFSS_proj=varargin{2};
elseif nargin==1
    filter_info=varargin{1};
    HFSS_proj='default_filter.hfss';
elseif nargin==0
    error('No input arguments')
else
    error('Something weird happened')
end

%% Find Symmetry Point
if mod(filter_info.resonators,2)==1
    draw_res_through=ceil(filter_info.resonators/2);
%     SymRes=ceil(filter_info.resonators/2);
    SymPoint=filter_info.resonator_loc(ceil(filter_info.resonators/2));
    SymType='odd';
elseif mod(filter_info.resonators,2)==0
    draw_res_through=filter_info.resonators/2;
%     SymRes=(filter_info.resonators/2);
    SymPoint=filter_info.filter_length/2;
    SymType='even';
end

%% Parameterize Necessary Dimensions
design_props.param1.name='tap_location';
design_props.param1.nom_val=filter_info.tap_location;

%% Create *.vbs file
% fid=fopen(fullfile('S:\Curtis_Neiderer\MATLAB_Toolbox',...
%     'combline_filter_design_v1.vbs'),'w');
[pathstr,filename]=fileparts(HFSS_proj);
fid=fopen(fullfile('S:\Curtis_Neiderer\MATLAB_Toolbox\VBS_files',...
    [filename,'_',datestr(now,1),'.vbs']),'w');

%% Open new HFSS Project
hfssNewProject(fid)

%% Insert Design
hfssInsertDesign(fid,filename,'driven modal')

%% Define Design Properties

hfssVariableDefinition(fid,'tap_location',filter_info.tap_location,...
    filter_info.units.length)
hfssVariableDefinition(fid,'tap_length',filter_info.tapline_len,...
    filter_info.units.length)
hfssVariableDefinition(fid,'res_diameter',filter_info.res_diameter,...
    filter_info.units.length)

% for ii=1:draw_res_through
%     hfssVariableDefinition(fid,['res',num2str(ii),'_loc'],...
%         filter_info.resonator_loc(ii),filter_info.units.length);
%     hfssVariableDefinition(fid,['res',num2str(ii),'_length'],...
%         filter_info.res_length,filter_info.units.length);
% end

res_cnt=filter_info.resonators+1;
if strcmpi(SymType,'even')
    for ii=1:draw_res_through
        res_cnt=res_cnt-1;
        hfssVariableDefinition(fid,['res',num2str(ii),'_loc'],...
            filter_info.resonator_loc(ii),filter_info.units.length);
        hfssVariableDefinition(fid,['res',num2str(ii),'_length'],...
            filter_info.res_length,filter_info.units.length);
        hfssVariableDefinition(fid,['res',num2str(res_cnt),'_loc'],...
            ['res',num2str(ii),'_loc'],filter_info.units.length);
        hfssVariableDefinition(fid,['res',num2str(res_cnt),'_length'],...
            ['res',num2str(ii),'_length'],filter_info.units.length);
    end
elseif strcmpi(SymType,'odd')
    for jj=1:draw_res_through
        res_cnt=res_cnt-1;
        hfssVariableDefinition(fid,['res',num2str(ii),'_loc'],...
            filter_info.resonator_loc(ii),filter_info.units.length);
        hfssVariableDefinition(fid,['res',num2str(ii),'_length'],...
            filter_info.res_length,filter_info.units.length);
        if jj<draw_res_through % draw_res_through==res_cnt
            hfssVariableDefinition(fid,['res',num2str(res_cnt),'_loc'],...
                ['res',num2str(jj),'_loc'],filter_info.units.length);
            hfssVariableDefinition(fid,['res',num2str(res_cnt),'_length'],...
                ['res',num2str(jj),'_length'],filter_info.units.length);
        end
    end
end
    
%% Draw FilterAir
hfssBox(fid,'FilterAir',...
	[-filter_info.GPS/2,0,0],[filter_info.GPS,filter_info.filter_length,...
    (filter_info.res_length+filter_info.resonator_gap)],'in')

%% Draw Resonators
cut_resonators={};
% for kk=1:draw_res_through
% for kk=1:(filter_info.resonators)
%     hfssCylinder(fid,['Res',num2str(kk)],'Z',...
%         [0,filter_info.resonator_loc(kk),0],...
%         (filter_info.res_diameter/2),filter_info.res_length,'in');
%     cut_resonators=[cut_resonators,{['Res',num2str(kk)]}];
% end
for kk=1:(filter_info.resonators)
    hfssCylinder(fid,['Res',num2str(kk)],'Z',...
        [0,filter_info.resonator_loc(kk),0],...
        (filter_info.res_diameter/2),filter_info.res_length,'in');
    
    cut_resonators=[cut_resonators,{['Res',num2str(kk)]}];
    
%     hfssParameterizeCylinder(fid,['Res',num2str(kk)],'Z',...
%         0,['Res',num2str(kk),'_loc'],0,...
%         'Res_diameter/2',['Res',num2str(kk),'_length'],...                  %% Check radius arg
%         filter_info.units.length)                                     
end

%% Draw Tap Line
% Port 1
hfssCylinder(fid,'TapLine1','Y',[0,0,filter_info.tap_location],...
    (filter_info.tapline_dia/2),...
    (filter_info.tapline_len+filter_info.res_diameter/2),'in');

% hfssParameterizeCylinder(fid,'TapLine1','Y',0,0,'tap_location',...
%     'tap_diameter/2','tap_length+(res_diameter/2)',...
%     filter_info.units.length)

% Port 2
hfssCylinder(fid,'TapLine2','Y',...
    [0,filter_info.filter_length,filter_info.tap_location],...
    (filter_info.tapline_dia/2),...
    -(filter_info.tapline_len+(filter_info.res_diameter/2)),'in');

% hfssParameterizeCylinder(fid,'TapLine2','Y',0,0,'tap_location',...
%     'tap_diameter/2','-(tap_length+(res_diameter/2))',...
%     filter_info.units.length)

%% Draw SMA Connector
% Dielectric
% hfssHollowCylinder(fid,'SMA_Dielectric1','Y',[0,0,filter_info.tap_location],...
%     .05,(.136/2),-.136,'in');
% hfssHollowCylinder(fid,'SMA_Dielectric2','Y',...
%     [0,filter_info.filter_length,filter_info.tap_location],...
%     .05,(.136/2),.136,'in');

% Dielectric
hfssCylinder(fid,'SMA_Dielectric1','Y',[0,0,filter_info.tap_location],...
    (.136/2),-.136,'in');

% hfssParameterizeCylinder(fid,'SMA_Dielectric1','Y',0,0,'tap_location',...
%     (.136/2),-.136,'in')

hfssCylinder(fid,'SMA_Dielectric2','Y',...
    [0,filter_info.filter_length,filter_info.tap_location],...
    (.136/2),.136,'in');

% hfssParameterizeCylinder(fid,'SMA_Dielectric1','Y',0,0,'tap_location',...
%     (.136/2),.136,'in')

% InnerCond
hfssCylinder(fid,'SMA_InnerCond1','Y',[0,0,filter_info.tap_location],...
    (.05/2),-.136,'in');

% hfssParameterizeCylinder(fid,'SMA_Dielectric1','Y',0,0,'tap_location',...
%     (.05/2),-.136,'in')

hfssCylinder(fid,'SMA_InnerCond2','Y',...
    [0,filter_info.filter_length,filter_info.tap_location],...
    (.05/2),.136,'in');

% hfssParameterizeCylinder(fid,'SMA_Dielectric1','Y',0,0,'tap_location',...
%     (.05/2),.136,'in')

%% Save base design before uniting, subtracting, etc.
hfssSaveProject(fid,['design_',HFSS_proj],true)

%% Unite & subtract necessary geometries
% Unite TapLine1 with Res1
hfssUnite(fid,{'Res1','TapLine1'}); 
% Unite TapLine2 with Res*
hfssUnite(fid,{['Res',num2str(filter_info.resonators)],'TapLine2'}); 
% Subtract Resonators from FilterAir
hfssSubtract(fid,{'FilterAir'},cut_resonators)
% Subtract SMA_InnerConds from SMA_Dielectric
hfssSubtract(fid,{'SMA_Dielectric1'},{'SMA_InnerCond1'});
hfssSubtract(fid,{'SMA_Dielectric2'},{'SMA_InnerCond2'});

%% Draw and Assign Ports
% Port 1
hfssCircle(fid,'Port1','Y',[0,-.136,filter_info.tap_location],(.136/2),'in');
hfssCircle(fid,'Port1_2','Y',[0,-.136,filter_info.tap_location],(.05/2),'in');
hfssSubtract(fid,{'Port1'},{'Port1_2'});
hfssAssignWavePort(fid,'P1','Port1',1,false,[0,0,0],[0,0,0],'in');
% Port 2
hfssCircle(fid,'Port2','Y',...
    [0,(filter_info.filter_length+.136),filter_info.tap_location],(.136/2),'in');
hfssCircle(fid,'Port2_2','Y',...
    [0,(filter_info.filter_length+.136),filter_info.tap_location],(.05/2),'in');
hfssSubtract(fid,{'Port2'},{'Port2_2'});
hfssAssignWavePort(fid,'P2','Port2',1,false,[0,0,0],[0,0,0],'in');

% % Port 1
% hfssHollowCircle(fid,'Port1','Y',[0,0,filter_info.tap_location],.05,(.136/2),...
%     'in');
% hfssAssignWavePort(fid,'P1','Port1',1,false,[0,0,0],[0,0,0],'in');
% % Port 2
% hfssHollowCircle(fid,'Port2','Y',...
%     [0,filter_info.filter_length,filter_info.tap_location],.05,(.136/2),...
%     'in')
% hfssAssignWavePort(fid,'P2','Port2',1,false,[0,0,0],[0,0,0],'in');



%% Duplicate everything around SymPoint
% Note: To be added in future, takes advantage of filter symmetry to 
% complete drawing of model.



%% Insert Solution Setup
center_freq=(filter_info.f_upper-filter_info.f_lower)/2;
hfssInsertSolution(fid, 'Setup1',center_freq, .1, 10)

%% Add Frequency Sweep
lo_rej_freq=filter_info.f_lower-(center_freq*.1);
hi_rej_freq=filter_info.f_upper+(center_freq*.1);
% % Interpolated
% hfssInterpolatingSweep(fid,'Sweep1','Setup1',lo_rej_freq,hi_rej_freq,...
%     100,25,0.5)
% Fast
hfssFastSweep(fid,'Sweep1','Setup1',lo_rej_freq,hi_rej_freq,250)

%% Save HFSS Working Design 
hfssSaveProject(fid, [,'working_',HFSS_proj], true)

% %% Solve Solution Setup
% hfssSolveSetup(fid, 'Setup1')
% 
% %% Save HFSS Working Design
% hfssSaveProject(fid, ['working_',HFSS_proj], true)

% %% 
% hfssCloseActiveProject(fid)

%% Close *.vbs file
fclose(fid);