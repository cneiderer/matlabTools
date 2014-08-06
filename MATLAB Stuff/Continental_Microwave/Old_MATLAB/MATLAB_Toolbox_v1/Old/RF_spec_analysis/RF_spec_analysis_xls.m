% function [] = RF_spec_analysis_xls(system_data,data_type,filename)
function [saveas_filepath] = RF_spec_analysis_xls(varargin)

%
% RF_spec_analysis_xls.m
%
% Description:
%   Takes in the system_data structure from RF_spec_analysis_mod.m as well
%   as the excel file to be edited, if the argument exists.  If the excel 
%   file exists, it writes the data to that file, otherwise it will create
%   a new excel file to write to.
%
% Inputs:
%   - system_data        ->  system measurement data struct
%   - existing_filename  ->  name of existing excel file to add data to
%
% Outputs:
%   - excel spreadsheet saved & named by user with system data measurements
%     added
%
% Author:
%   Curtis Neiderer, 12/9/2008
%
% Notes:
%   As with RF_spec_analysis_mod.m, this script can be greatly improved
%   when I have the time to do so.
%


%% Check to see if an existing excel workbook was passed in
if nargin==3
    system_data=varargin{1};
    data_type=varargin{2};
    existing_filename=varargin{3};
elseif nargin==2
    system_data=varargin{1};
    data_type=varargin{2};
    existing_filename=[];
elseif nargin<=1
    error('No enough input arguments to RF_spec_analysis_xls')
end

%% Start excel and keep visible
xls=actxserver('Excel.Application');
xls.Visible=1;

% Add new workbook
if isempty(existing_filename) || ~exist(existing_filename)
    [wb_file,wb_path]=uigetfile('*.xls','Select the *.xls file to write data to: ',['RF_spec_analysis_',datestr(now,1),'.xls']);
    xlsWorkbook=xls.Workbook.Add(fullfile(wb_path,wb_file));
else
    xlsWorkbook=xls.Workbook.Open(existing_filename);
end

% Get workbook sheet names and activate
if strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'Tx')
    Tx_sheet=xlsWorkbook.Worksheets.Item(1);
    Rx_=xlsWorkbook.Worksheets.Item(2);
elseif strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'Rx')
    Rx_sheet=xlsWorkbook.Worksheets.Item(1);
    Tx_sheet=xlsWorkbook.Worksheets.Item(2);
else
    error('Something is wrong, sheet name does not match "Tx" or "Rx"')
end

if strcmpi(data_type,'Tx')
    xlsSheet=Tx_sheet;
    xlsSheet.Activate();
elseif strcmpi(data_type,'Rx')
    xlsSheet=Rx_sheet;
    xlsSheet.Activate();
else
    error('Data type does not match either case "Tx" or "Rx", so no sheets were activated')
end

% Record measurement data into spreadsheet
for ii=1:length(system_data)
    
    % Find current band and assign location
    if findstr(system_data(ii).filename,'15.25')        % Ku STD-CDL FL
        location_row=[2,20];
    elseif findstr(system_data(ii).filename,'14.61')    % Ku STD-CDL RL
        location_row=[38,56];
    elseif findstr(system_data(ii).filename,'15.19')    % Ku NCDL OL
        location_row=[74,92];
    elseif findstr(system_data(ii).filename,'14.66')    % Ku NCDL IL
        location_row=[110,128];
    elseif findstr(system_data(ii).filename,'9.85')     % X STD-CDL FL
        location_row=[146,164];
    elseif findstr(system_data(ii).filename,'14.12')    % Ku Intelsat (Tx)
        location_row=[182,182];
    elseif findstr(system_data(ii).filename,'10.3')     % X STD-CDL RL
        location_row=[146,164];
    elseif findstr(system_data(ii).filename,'11.85')    % Ku Intelsat (Rx)
        location_row=[182,182];
    end

    % Find polarization
    if findstr(system_data(ii).filename,'RH')
        polar_row=location_row(1);
    elseif findstr(system_data(ii).filename,'LH')
        polar_row=location_row(2);
    else
        error(['Could not determine polarization of file: ',system_data(ii).filename])
    end
    
    % Find empty data column    
    xx=1;
    cnt=2;
    while xx
       
        % Count across the columns as you test, starting at col3
        cnt=cnt+1;
        
        test_cell=xlsGetValue(xlsSheet,cnt,polar_row+2);
        if ~isempty(test_cell) & ~isnan(test_cell)
            continue;
        else
            cell_col=cnt;
            cell_row=polar_row+2;
            xx=0;
        end
         
    end
    
    % System_Name
    xlsSetCellVal(system_data(ii).system_name,xlsSheet,cell_col,cell_row);
    xlsSetCellBackground('k',xlsSheet,cell_col,cell_row);
    xlsSetCellForeground('w',xlsSheet,cell_col,cell_row);
    
    % Amplitude Measurements
    xlsSetCellVal(system_data(ii).results.W1_Amp,xlsSheet,cell_col,cell_row+1);     % W1 Amp
    compare_val_with_spec(system_data(ii).results.W1_Amp,xlsSheet,cell_col,cell_row+1);
    xlsSetCellVal(system_data(ii).results.W2_Amp,xlsSheet,cell_col,cell_row+2);           % W2 Amp
    compare_val_with_spec(system_data(ii).results.W2_Amp,xlsSheet,cell_col,cell_row+2);
    xlsSetCellVal(system_data(ii).results.Slope,xlsSheet,cell_col,cell_row+3);              % Slope
    compare_val_with_spec(system_data(ii).results.Slope,xlsSheet,cell_col,cell_row+3);
    xlsSetCellVal(system_data(ii).results.Ripple,xlsSheet,cell_col,cell_row+4);             % Max Var
    compare_val_with_spec(system_data(ii).results.Ripple,xlsSheet,cell_col,cell_row+4);
    
    % Phase Measurements
    xlsSetCellVal(system_data(ii).results.W1_GroupDelay,xlsSheet,cell_col,cell_row+5);      % GD1
    compare_val_with_spec(system_data(ii).results.W1_GroupDelay,xlsSheet,cell_col,cell_row+5);
    xlsSetCellVal(system_data(ii).results.W2_GroupDelay,xlsSheet,cell_col,cell_row+6);      % GD2
    compare_val_with_spec(system_data(ii).results.W2_GroupDelay,xlsSheet,cell_col,cell_row+6);
    xlsSetCellVal(system_data(ii).results.W3_GroupDelay,xlsSheet,cell_col,cell_row+7);      % GD3
    compare_val_with_spec(system_data(ii).results.W3_GroupDelay,xlsSheet,cell_col,cell_row+7);
    xlsSetCellVal(system_data(ii).results.Edge_to_Edge,xlsSheet,cell_col,cell_row+8);       % E-E
    compare_val_with_spec(system_data(ii).results.Edge_to_Edge,xlsSheet,cell_col,cell_row+8);
    
    % Miscellaneous Measurements
    xlsSetCellVal(system_data(ii).results.S11_Max,xlsSheet,cell_col,cell_row+9);            % S11 VSWR
    compare_val_with_spec(system_data(ii).results.S11_Max,xlsSheet,cell_col,cell_row+9);
    xlsSetCellVal(system_data(ii).results.S22_Max,xlsSheet,cell_col,cell_row+10);            % S22 VSWR
    compare_val_with_spec(system_data(ii).results.S22_Max,xlsSheet,cell_col,cell_row+10);
    
    xlsSetCellVal(abs(system_data(ii).results.Min_Gain),xlsSheet,cell_col,cell_row+11);           % Min Gain
    compare_val_with_spec(abs(system_data(ii).results.Min_Gain),xlsSheet,cell_col,cell_row+11);
    xlsSetCellVal(abs(system_data(ii).results.Max_Gain),xlsSheet,cell_col,cell_row+12);           % Min Gain
    compare_val_with_spec(abs(system_data(ii).results.Max_Gain),xlsSheet,cell_col,cell_row+12);
    
    % Add border around data
    temp_range_obj=xlsGetRange(xlsSheet,cell_col,cell_row,cell_col,cell_row+12);
    temp_range_obj.Borders.LineStyle=1;
    temp_range_obj.HorizontalAlignment=3;
    
end

% Autofit the rows and columns
xlsSheet.Columns.AutoFit;
xlsSheet.Rows.AutoFit;

% Select Path and filename for saving excel
if isempty(existing_filename) || ~exist(existing_filename)
    
    % [save_filename,save_path]=uiputfile('*.xls','Save your RF spec analysis as:','RF_spec_analysis.xls');
    % saveas_filepath=fullfile(save_path,save_filename);
    
    saveas_filepath=fullfile('S:\Curtis_Neiderer\MATLAB_Toolbox\',['RF_spec_analysis_',datestr(now,1),'.xls']);
    xlsWorkbook.SaveAs(saveas_filepath);
    
else
    xlsWorkbook.Save;
    saveas_filepath=existing_filename;
end

% Save and close excel
xlsWorkbook.Close;
xls.Quit;
xls.delete;
