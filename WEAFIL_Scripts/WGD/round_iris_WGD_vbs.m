function round_iris_WGD_vbs(varargin)

%
% round_iris_WGD_vbs.m
%
% Description:
%   Builds macro to create a waveguide filter with round irises within HFSS
%   based on WEAFIL WGD data file.
%
% Inputs:
%   varargin{1} ->  filter_info struct containing design specs from WEAFIL
%   varargin{2} ->  HFSS_proj name
%
% Outputs:
%   VBScript macro file for HFSS
%
% Author:
%   Curtis Neiderer, 3/6/2009
%
% Notes / Changes:
%   Version 1: 3/6/2009
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
    SymType='odd';
    SymRes=ceil(filter_info.resonators/2);
    SymIris=SymRes;
    SymPoint=filter_info.cavity_screws(SymRes);
elseif mod(filter_info.resonators,2)==0
    SymType='even';
    SymRes=(filter_info.resonators/2);
    SymIris=SymRes+1;
    SymPoint=filter_info.iris_screws(SymIris);   
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

% General Filter Specs
hfss_VariableDefinition(fid,'InputCav_length',filter_info.input_cav_length,...
    filter_info.units.length);
hfss_VariableDefinition(fid,'Iris_thickness',filter_info.iris_thickness,...
    filter_info.units.length);
hfss_VariableDefinition(fid,'WG_height',filter_info.waveguide_height,...
    filter_info.units.length);
hfss_VariableDefinition(fid,'WG_width',filter_info.waveguide_width,...
    filter_info.units.length);

% Cavity Lengths
for ii=1:SymRes
    hfss_VariableDefinition(fid,['Cav',num2str(ii),'_length'],...
        filter_info.cavity_lengths(ii),filter_info.units.length);
end

% Iris Widths
if strcmpi(SymType,'even')
    for jj=1:SymRes+1
        hfss_VariableDefinition(fid,...
            ['Iris',num2str(jj-1),num2str(jj),'_width'],...
            filter_info.iris_widths(jj),filter_info.units.length);
    end
elseif strcmpi(SymType,'odd')
    for jj=1:SymRes
        hfss_VariableDefinition(fid,...
            ['Iris',num2str(jj-1),num2str(jj),'_width'],...
            filter_info.iris_widths(jj),filter_info.units.length);       
    end
end

%% Draw and Parameterize Objects
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Draw Objects and Parameterize Necessary Dimensions \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

% Draw Input Cavity
fprintf(fid, ''' ----- Draw Input Cavity \n');
hfss_CreateBox(fid,'Input_Cavity1','-WG_width/2','-InputCav_length',0,...
    'WG_width','InputCav_length','WG_height',filter_info.units.length,...
    [85,85,85],0.5);
dupObj_list={'Input_Cavity1'};
uniteObj_list=[{'Input_Cavity1'},{'Input_Cavity1_1'}];

% Draw Cavities
cav_str=[];  
dupCav_list=[];
for kk=1:SymRes    
    cav_YStart=['Iris_thickness*',num2str(kk),cav_str];
    
    fprintf(fid, [''' ----- Draw Cavity',num2str(kk),' \n']);
    hfss_CreateBox(fid,['Cavity',num2str(kk)],'-WG_width/2',cav_YStart,0,...
        'WG_width',['Cav',num2str(kk),'_length'],'WG_height',...
        filter_info.units.length,[85,85,85],0.5);
    
    cav_str=[cav_str,'+Cav',num2str(kk),'_length'];

    uniteObj_list=[uniteObj_list,{['Cavity',num2str(kk)]}];
    if strcmpi(SymType,'even')  || (strcmpi(SymType,'odd') && kk<SymRes)
        uniteObj_list=[uniteObj_list,{['Cavity',num2str(kk),'_1']}];
        dupCav_list=[dupCav_list,{['Cavity',num2str(kk)]}];
    end
end
dupObj_list=[dupObj_list,dupCav_list];
 
% Draw Irises
iris_str=[];
dupIris_list=[];
for mm=1:SymIris
    
    if mm==1
        iris_YStart=0;
    else
        iris_YStart=[iris_str,'+Iris_thickness*',num2str(mm-1)];
    end
    
    fprintf(fid, [''' ----- Draw Iris',num2str(mm-1),num2str(mm),' \n']);
    hfss_CreateCylinder(fid,['Iris',num2str(mm-1),num2str(mm)],'Y',...
        0,iris_YStart,'WG_height/2',...
        ['Iris',num2str(mm-1),num2str(mm),'_width/2'],'Iris_thickness',...
        filter_info.units.length,[85,85,85],0.5);

    if mm==1
        iris_str=[iris_str,'Cav',num2str(mm),'_length'];
    else
        iris_str=[iris_str,'+Cav',num2str(mm),'_length'];
    end
    
    uniteObj_list=[uniteObj_list,{['Iris',num2str(mm-1),num2str(mm)]}];
    if strcmpi(SymType,'odd')  || (strcmpi(SymType,'even') && mm<SymIris)
        uniteObj_list=[uniteObj_list,...
            {['Iris',num2str(mm-1),num2str(mm),'_1']}];
        dupIris_list=[dupIris_list,{['Iris',num2str(mm-1),num2str(mm)]}];
    end
end
dupObj_list=[dupObj_list,dupIris_list];  

%% Draw and Assign Ports
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Draw Sheet Objects and Assign WavePorts \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

fprintf(fid, [''' ----- Draw waveport \n']);
hfss_CreateRectangle(fid,'Port1','Y',...
    '-WG_width/2','-InputCav_length',0,...
    'WG_width','WG_height','in');
hfss_AssignWavePort(fid,'P1','Port1',1,false,[0,0,0],[0,0,0],...
    filter_info.units.length);
dupObj_list=[dupObj_list,{['Port1']}];

%% Mirror Duplicate
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Mirror Duplicate Objects \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

hfss_DuplicateMirror(fid,dupObj_list,0,SymPoint,0,...
    0,1,0,...
    filter_info.units.length);

%% Unite & subtract necessary geometries
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Unite and Subtract Objects as Necessary \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

% Unite Cavities & Irises
hfss_Unite(fid,uniteObj_list)

%% Analysis Setup
% Comment Section
fprintf(fid, '\n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, ''' Analysis: Insert Solution Setup and Add Freq Sweep \n');
fprintf(fid, ''' -------------------------------------------------- \n');
fprintf(fid, '\n');

%% Insert Solution Setup
center_freq=filter_info.f_lower+((filter_info.f_upper-filter_info.f_lower)/2);
hfss_InsertSolutionSetup(fid, 'Setup1',center_freq,.1,25)

%% Add Frequency Sweep
lo_rej_freq=filter_info.f_lower-(center_freq*.25);
hi_rej_freq=filter_info.f_upper+(center_freq*.25);
hfss_InsertFastSweep(fid,'Sweep1','Setup1',lo_rej_freq,hi_rej_freq,100)

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