function [spec_comparison_wkbk] = sys_comp_xls_SpecCaseStudy_ver(filepaths)

%
% sys_comp_xls_SpecCaseStudy_ver.m
%
% Description:
%   
% Inputs:
%
% Outputs:
%
% Author:
%   Curtis Neiderer, 6/22/2009
%
% Notes/Changes:
%

%% Select Workbook Files if Necessary
if ~exist('filepaths','var') || isempty(filepaths)
    [comp_wkbks,comp_path]=uigetfile('*.xls',...
        'Select the compliance system compliance workbooks:',...
        'MultiSelect','on');
end

%% For filepaths List
if ~iscell(comp_wkbks) && ~ischar(comp_wkbks)
    warning('You did not select any compliance workbooks!!!')
else
    filepaths={};
    disp('Compliance workbooks selected: ')
    if ischar(comp_wkbks)
        filepaths{1,1}=fullfile(comp_path,comp_wkbks);
        disp(['-- ',fullfile(comp_path,comp_wkbks)]);
    else
        comp_wkbks=sort(comp_wkbks);
        for ii=1:length(comp_wkbks)
            filepaths{ii,1}=fullfile(comp_path,comp_wkbks{ii});
            disp(['-- ',fullfile(comp_path,comp_wkbks{ii})])
        end
    end
end

%% Open System Compliance Template
% Start excel and keep visible
xls=actxserver('Excel.Application');
xls.Visible=1;      % Keep excel visible
% xls.WindowState=2;  % Minimize excel to toolbar

% Add new workbook
[comp_xls,comp_xlspath]=uiputfile('*.xls',...
    'Save your system compliance case study spreadsheet as: ',...
    ['system_compliance_case_study_',datestr(now,1),'.xls']);
filename=fullfile(comp_xlspath,comp_xls);
xlsWorkbook=xlsAddnewWorkbook(xls,filename,...
    'S:\Curtis_Neiderer\MATLAB_Toolbox\Templates\system_compliance_template.xlt');

% Get workbook sheet names and activate
if strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'TX_parameters')
    TX_sheet=xlsWorkbook.Worksheets.Item(1);
    RX_sheet=xlsWorkbook.Worksheets.Item(2);
elseif strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'RX_parameters')
    RX_sheet=xlsWorkbook.Worksheets.Item(1);
    TX_sheet=xlsWorkbook.Worksheets.Item(2);
else
    error({'Sheet name does not match "TX_param" or "Rx_param",',...
        ' please check your spreadsheet names'})
end

%% Read Data from Files and Write to Case Study Workbook
% Open waitbar
wb=waitbar(0,'Loading data from compliance workbooks, please wait ...');
complete_RX_data=[];
complete_TX_data=[];
for jj=1:length(filepaths) 
     
    waitbar(jj/length(filepaths));
    
%     % Open workbook
%     current_workbook=xlsOpen(excel,filepaths{jj});
     
    % Get system name
    name_start=regexpi(filepaths{jj},'SN');
    system_name=filepaths{jj}(name_start:name_start+4);

    % Read data from excel to MATLAB
    RX_data=xlsread(filepaths{jj},'RX_parameters');
    TX_data=xlsread(filepaths{jj},'TX_parameters');
    
    % Format data into struct
    % "RX" data
    system_data.RX.NB_Ku_CDL_RL=RX_data(1:12,7);
    system_data.RX.NB_Ku_CDL_FL=RX_data(17:28,7);
    system_data.RX.NB_N_CDL_IL=RX_data(33:44,7);
    system_data.RX.NB_N_CDL_OL=RX_data(49:60,7);
    system_data.RX.NB_X_CDL_RL=RX_data(65:76,7);
    system_data.RX.NB_Intelsat_DL=RX_data(81:92,7);
    system_data.RX.WB_Ku_CDL_RL=RX_data(97:108,7);
    system_data.RX.WB_Ku_CDL_FL=RX_data(113:124,7);
    system_data.RX.WB_N_CDL_IL=RX_data(129:140,7);
    system_data.RX.WB_N_CDL_OL=RX_data(145:156,7);
    % "TX" data
    system_data.TX.NB_Ku_CDL_RL=TX_data(1:12,7);
    system_data.TX.NB_Ku_CDL_FL=TX_data(17:28,7);
    system_data.TX.NB_N_CDL_IL=TX_data(33:44,7);
    system_data.TX.NB_N_CDL_OL=TX_data(49:60,7);
    system_data.TX.NB_X_CDL_FL=TX_data(65:76,7);
    system_data.TX.NB_Intelsat_UL=TX_data(81:92,7);
    system_data.TX.WB_Ku_CDL_RL=TX_data(97:108,7);
    system_data.TX.WB_Ku_CDL_FL=TX_data(113:124,7);
    system_data.TX.WB_N_CDL_IL=TX_data(129:140,7);
    system_data.TX.WB_N_CDL_OL=TX_data(145:156,7);
    
%     % Format data into giant arrays
%     % "RX" data
%     complete_RX_data=[complete_RX_data,RX_data(:,7)];
%     complete_RX_enum=[complete_RX_enum,system_name];
%     % "TX" data
%     complete_TX_data=[complete_TX_data,TX_data(:,7)];
%     complete_RX_enum=[complete_TX_enum,system_name];
    
    % Write data
    % "RX" Data
    
    % "TX" Data
    
    
    % Save data into structure
    eval(['Overall_Data.',system_name,'=system_data;']);
    
    % Clear old variables
    clear current_data system_data name_start system_name;
    
end
% Close waitbar
close(wb)

% %% Open System Compliance Template
% % Start excel and keep visible
% xls=actxserver('Excel.Application');
% xls.Visible=1;      % Keep excel visible
% % xls.WindowState=2;  % Minimize excel to toolbar
% 
% % Add new workbook
% [comp_xls,comp_xlspath]=uiputfile('*.xls',...
%     'Save your system compliance case study spreadsheet as: ',...
%     ['system_compliance_case_study_',datestr(now,1),'.xls']);
% filename=fullfile(comp_xlspath,comp_xls);
% xlsWorkbook=xlsAddnewWorkbook(xls,filename,...
%     'S:\Curtis_Neiderer\MATLAB_Toolbox\Templates\system_compliance_template.xlt');
% 
% % Get workbook sheet names and activate
% if strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'TX_parameters')
%     TX_sheet=xlsWorkbook.Worksheets.Item(1);
%     RX_sheet=xlsWorkbook.Worksheets.Item(2);
% elseif strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'RX_parameters')
%     RX_sheet=xlsWorkbook.Worksheets.Item(1);
%     TX_sheet=xlsWorkbook.Worksheets.Item(2);
% else
%     error({'Sheet name does not match "TX_param" or "Rx_param",',...
%         ' please check your spreadsheet names'})
% end
% 
% % Write data to compliance template and color accordingly 
% system_names=fields(Overall_Data);
% for kk=1:length(system_names) 
%   
%     Overall_Data.system_names{kk}
%     
%     
% end


% % Calculate mean, standard deviation, and variance of each spec and write
% % values into compliance document
% [num_rows,num_cols]=size(complete_RX_data);
% complete_RX_calcs=[];
% for nn=1:num_rows
%     complete_RX_calcs=[complete_RX_calcs;mean(complete_RX_data(nn,:)),...
%         std(complete_RX_data(nn,:)),var(complete_RX_data(nn,:))];
% end
% RX_to_write=[complete_RX_data,NaN(num_rows,1),complete_RX_calcs];
% 
% [num_rows,num_cols]=size(complete_TX_data);
% complete_TX_calcs=[];
% for nn=1:num_rows
%     complete_TX_calcs=[complete_TX_calcs;mean(complete_TX_data(nn,:)),...
%         std(complete_TX_data(nn,:)),var(complete_TX_data(nn,:))];
% end
% TX_to_write=[complete_TX_data,NaN(num_rows,1),complete_TX_calcs];


% Save workbook and close excel



% Open powerpoint

% Create plots of spec compliance and copy into powerpoint presentation

% 


