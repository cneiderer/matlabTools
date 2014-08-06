function [] = spec_analysis_xls(varargin)

%
% spec_analysis_xls.m
%
% Description:
%
% Inputs:
%
% Outputs:
%
% Author:
%   Curtis Neiderer, 1/7/2009
%
% Notes / Changes:
%


%% Load compiled system data
if nargin==1
    mat_fullfilepath=varargin{1};
    load(mat_fullfilepath);
else
    [mat_file,mat_filepath]=uigetfile('*.mat','Select the *.mat system data file',['compiled_system_data_',datestr(now,1),'.mat']);

    if mat_filepath==0
        error('You did not select a compile_system_data_*.mat file to load')
    else
        mat_fullfilepath=fullfile(mat_filepath,mat_file);
        load(mat_fullfilepath);
    end
    
end

test=0;

%% Existing or new excel workbook???
xx=1;
while xx
    existing_xls=input('Would you like to edit an existing *.xls file (Y/N)? ','s');
    if strcmpi(existing_xls,'Y') || strcmpi(existing_xls,'Yes')

        % Select existing excel workbook to edit
        [existing_file,existing_filepath]=uigetfile('*.xls','Select existing *.xls file to be edited:');
        if existing_filepath==0
            error('You chose to edit a workbook, but did not select an existing workbook to edit') 
        else
            saveas_filepath=fullfile(existing_filepath,existing_file);
            disp(['--Selected *.xls to be edited: ',saveas_filepath])
        end

        xx=0;

    elseif strcmpi(existing_xls,'N') || strcmpi(existing_xls,'No') || isempty(existing_xls)
        
        % Choose a name and location to save your spec analysis workbook
        [new_xls,new_xlspath]=uiputfile('*.xls','Save your system compliance spreadsheet as: ',['spec_analysis_',datestr(now,1),'.xls']);
        if new_xls==0
            warning('You did not select a name for your spec analysis spreadsheet, please try again')
            xx=1;
        else
            saveas_filepath=fullfile(new_xlspath,new_xls);
            disp(['--Saved *.xls as: ',saveas_filepath])
            xx=0;
        end
               
    else
        warning('Your answer does not match "Y" or "N", please try again.')
        xx=1;
    end
end

% saveas_filepath=fullfile('S:\Curtis_Neiderer\MATLAB_Toolbox',['spec_analysis_',datestr(now,1),'.xls']);

test=1;

%% Start excel and keep visible
xls=actxserver('Excel.Application');
xls.Visible=1;      % Keep excel visible
% xls.WindowState=2;  % Minimize excel to toolbar

% Add workbook
xlsWorkbook=xlsAddnewWorkbook(xls,saveas_filepath,'S:\Curtis_Neiderer\MATLAB_Toolbox\Templates\Spec_Analysis_template.xlt');

% Get workbook sheet names and activate
if strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'TX_data')
    TX_sheet=xlsWorkbook.Worksheets.Item(1);
    RX_sheet=xlsWorkbook.Worksheets.Item(2);
elseif strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'RX_data')
    RX_sheet=xlsWorkbook.Worksheets.Item(1);
    TX_sheet=xlsWorkbook.Worksheets.Item(2);
else
    error('Sheet name does not match "TX_data" or "Rx_data", please check your spreadsheet names')
end

test=2;

%% Get the spec values and add them to template
add_specs_to_template(xls,xlsWorkbook,RX_sheet,TX_sheet);

test=3;

%% Populate the spec_analysis spreadsheet with measurement data
for ii=1:length(system_data)
    
    % Find correct sheet
    if strcmpi(system_data(ii).data_type,'TX')
        xlsSheet=TX_sheet;
        xlsSheet.Activate();
    elseif strcmpi(system_data(ii).data_type,'RX')
        xlsSheet=RX_sheet;
        xlsSheet.Activate();
    else
        error(['Data type does not match either case "TX" or "RX" for',system_data(ii).filename])
    end    
    
    test=4;
    
    % Find the band location
    switch system_data(ii).band_name
        case 'Ku-CDL RL'
            band_location=[5,23];
        case 'Ku-CDL FL'
            band_location=[41,59];
        case 'N-CDL OL'
            band_location=[77,95];
        case 'N-CDL IL'
            band_location=[113,131];
        case 'X-CDL RL'
            band_location=[149,167];
        case 'Intelsat DL'
            band_location=[185,185];
        case 'X-CDL FL'
            band_location=[149,167];
        case 'Intelsat UL'
            band_location=[185,185];
        otherwise
            error('Could not find band_name case, please check your data')
    end
    
    test=5;
    
    % Find polarization location
    if strcmpi(system_data(ii).polarization,'RH')
        polar_location=band_location(1);
    elseif strcmpi(system_data(ii).polarization,'LH')
        polar_location=band_location(2);
    else
        error(['Polarization for ',system_data(ii).filename,' does not match "RH" or "LH" case'])
    end
        
    test=6;
    
    % Find empty data column    
    xx=1;
    cnt=2;
    while xx
       
        % Count across the columns as you test, starting at col3
        cnt=cnt+1;
        
        test_cell=xlsGetValue(xlsSheet,cnt,polar_location);
        if ~isempty(test_cell) & ~isnan(test_cell)
            continue;
        else
            cell_col=cnt;
            cell_row=polar_location-1;
            xx=0;
        end
         
    end
    
    test=7;
    
    % Write system name to top of column
    xlsSetCellVal(system_data(ii).system_name,xlsSheet,cell_col,cell_row);
    xlsSetCellBackground('k',xlsSheet,cell_col,cell_row);
    xlsSetCellForeground('w',xlsSheet,cell_col,cell_row);
    
    test=8;
        
    % Amplitude Measurements
    xlsSetCellVal(system_data(ii).results.W1_Amp,xlsSheet,cell_col,cell_row+1);     % W1 Amp
    compare_measurement_with_spec(system_data(ii).results.W1_Amp,xlsSheet,cell_col,cell_row+1);
    xlsSetCellVal(system_data(ii).results.W2_Amp,xlsSheet,cell_col,cell_row+2);           % W2 Amp
    compare_measurement_with_spec(system_data(ii).results.W2_Amp,xlsSheet,cell_col,cell_row+2);
    xlsSetCellVal(system_data(ii).results.Slope,xlsSheet,cell_col,cell_row+3);              % Slope
    compare_measurement_with_spec(system_data(ii).results.Slope,xlsSheet,cell_col,cell_row+3);
    xlsSetCellVal(system_data(ii).results.Ripple,xlsSheet,cell_col,cell_row+4);             % Max Var
    compare_measurement_with_spec(system_data(ii).results.Ripple,xlsSheet,cell_col,cell_row+4);
    
    % Phase Measurements
    xlsSetCellVal(system_data(ii).results.W1_GroupDelay,xlsSheet,cell_col,cell_row+5);      % GD1
    compare_measurement_with_spec(system_data(ii).results.W1_GroupDelay,xlsSheet,cell_col,cell_row+5);
    xlsSetCellVal(system_data(ii).results.W2_GroupDelay,xlsSheet,cell_col,cell_row+6);      % GD2
    compare_measurement_with_spec(system_data(ii).results.W2_GroupDelay,xlsSheet,cell_col,cell_row+6);
    xlsSetCellVal(system_data(ii).results.W3_GroupDelay,xlsSheet,cell_col,cell_row+7);      % GD3
    compare_measurement_with_spec(system_data(ii).results.W3_GroupDelay,xlsSheet,cell_col,cell_row+7);
    xlsSetCellVal(system_data(ii).results.Edge_to_Edge,xlsSheet,cell_col,cell_row+8);       % E-E
    compare_measurement_with_spec(system_data(ii).results.Edge_to_Edge,xlsSheet,cell_col,cell_row+8);
    
    % Miscellaneous Measurements
    xlsSetCellVal(system_data(ii).results.S11_Max,xlsSheet,cell_col,cell_row+9);            % S11 VSWR
    compare_measurement_with_spec(system_data(ii).results.S11_Max,xlsSheet,cell_col,cell_row+9);
    xlsSetCellVal(system_data(ii).results.S22_Max,xlsSheet,cell_col,cell_row+10);            % S22 VSWR
    compare_measurement_with_spec(system_data(ii).results.S22_Max,xlsSheet,cell_col,cell_row+10);
    
    xlsSetCellVal(abs(system_data(ii).results.Min_Gain),xlsSheet,cell_col,cell_row+11);           % Min Gain
    compare_measurement_with_spec(abs(system_data(ii).results.Min_Gain),xlsSheet,cell_col,cell_row+11);
    xlsSetCellVal(abs(system_data(ii).results.Max_Gain),xlsSheet,cell_col,cell_row+12);           % Min Gain
    compare_measurement_with_spec(abs(system_data(ii).results.Max_Gain),xlsSheet,cell_col,cell_row+12);
    
    test=9;
    
    % Add border around data
    temp_range_obj=xlsGetRange(xlsSheet,cell_col,cell_row,cell_col,cell_row+12);
    temp_range_obj.Borders.LineStyle=1;
    temp_range_obj.HorizontalAlignment=3; 
    
    % Autofit the rows and columns
    xlsSheet.Columns.AutoFit;
    xlsSheet.Rows.AutoFit;
    
end

test=10;

%% Save and close excel
xlsWorkbook.Save;
xlsWorkbook.Close;
xls.Quit;
xls.delete;

%% --------------- %% Sub-Functions %% --------------- %%

function [spec_val] = compare_measurement_with_spec(measurement,xlsSheet,celltest_col,celltest_row)

%
spec_col=2;
spec_row=celltest_row;
spec_val=xlsGetValue(xlsSheet,spec_col,spec_row);
spec_name=xlsGetValue(xlsSheet,spec_col-1,spec_row);

% if strcmpi(spec_val,'N/A') || strcmpi(spec_val,'NA')
if ~ischar(spec_val)

    if strcmpi(spec_name,'Min_Gain [dB]')
        
        if measurement > (1.1*spec_val)
            xlsSetCellBackground('g',xlsSheet,celltest_col,celltest_row);
        elseif (measurement <= (1.1*spec_val)) & (measurement >= spec_val)
            xlsSetCellBackground('y',xlsSheet,celltest_col,celltest_row);
        else
            xlsSetCellBackground('r',xlsSheet,celltest_col,celltest_row);
            xlsSetCellForeground('w',xlsSheet,celltest_col,celltest_row);
        end
            
    else
    
        if measurement < (0.9*spec_val)
            xlsSetCellBackground('g',xlsSheet,celltest_col,celltest_row);
        elseif (measurement >= (0.9*spec_val)) & (measurement <= spec_val)
            xlsSetCellBackground('y',xlsSheet,celltest_col,celltest_row);
        else
            xlsSetCellBackground('r',xlsSheet,celltest_col,celltest_row);
            xlsSetCellForeground('w',xlsSheet,celltest_col,celltest_row);
        end
    
    end
    
end