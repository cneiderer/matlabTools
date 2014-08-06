function [] = record_specs_in_template

%
% record_specs_in_template.m
%
% Description:
%   Reads in the spec values from one excel spreadsheet and adds them to
%   the baseline template before saving the file for RF_spec_analysis_mod.m
%   and RF_spec_analysis_xls.m
%
% Inputs:
%   Excel workbook with the spec values
%
% Outputs:
%   Excel workbook of the modified baseline spec analysis template for use
%   with RF_spec_analysis_mod.m and RF_spec_analysis_xls.m 
%
% Author:
%   Curtis Neiderer, 12/15/2008
%
% Notes:
%   This was written to make spec changing a little more user friendly.  
%   Rather than having the specs in the baseline template, they're read in 
%   from another excel spreadsheet that organizes them in much clearer 
%   format. This will probably have to be overhauled when I get around to
%   changing RF_spec_analysis_mod.m and RF_spec_analysis_xls.m
%


%% Get spec values
[specs,spec_units] = get_spec_values;

%% Start excel and keep visible
xls=actxserver('Excel.Application');
xls.Visible=1;

% Add new workbook
xlsWorkbook=xls.Workbook.Add(fullfile(cd,'Templates','RF_spec_analysis_template_ver4.xlt'));

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

%% Loop through 'Tx' & 'Rx' specs recording in correct location
for ii=1:2
    
    % Activate sheet and get appropriate specs
    if ii==1
        xlsSheet=Tx_sheet;
        xlsSheet.Activate();
        spec_data=specs.tx_specs;
        mode='Tx';
        min_gain_max_IL='Max_IL';
        max_gain_min_IL='Min_IL';
    elseif ii==2
        xlsSheet=Rx_sheet;
        xlsSheet.Activate();
        spec_data=specs.rx_specs;
        mode='Rx';
        min_gain_max_IL='Min_Gain';
        max_gain_min_IL='Max_Gain';
    end
    
    for kk=1:length(spec_data)
    % Find current band and assign location
    if spec_data(kk).Frequency==15.25        % Ku STD-CDL FL
        location_row=[4,22];
    elseif spec_data(kk).Frequency==14.615     % Ku STD-CDL RL
        location_row=[40,58];
    elseif spec_data(kk).Frequency==15.19       % Ku NCDL OL
        location_row=[76,94];
    elseif spec_data(kk).Frequency==14.665        % Ku NCDL IL
        location_row=[112,130];
    elseif spec_data(kk).Frequency==9.85     % X STD-CDL FL
        location_row=[148,166];
    elseif spec_data(kk).Frequency==14.125   % Ku Intelsat (Tx)
        location_row=[184,184];
    elseif spec_data(kk).Frequency==10.3      % X STD-CDL RL
        location_row=[148,166];
    elseif spec_data(kk).Frequency==11.85   % Ku Intelsat (Rx)
        location_row=[184,184];
    end
        
    % Find polarization row
    if strcmpi(spec_data(kk).Polarization,'RHCP')
        polar_row=location_row(1);
    elseif strcmpi(spec_data(kk).Polarization,'LHCP')
        polar_row=location_row(2);
    elseif strcmpi(spec_data(kk).Polarization,'Linear')
        polar_row=location_row(1);
    end
    
    % Band Info
    xlsSetCellVal(spec_data(kk).Band,xlsSheet,2,polar_row-3);               % Band
    xlsSetCellVal(spec_data(kk).Frequency,xlsSheet,2,polar_row-2);          % Freq
    xlsSetCellVal(spec_data(kk).Polarization,xlsSheet,2,polar_row-1);       % Polar
    
    % Amplitude Specs
    xlsSetCellVal(spec_data(kk).W1_Amp,xlsSheet,2,polar_row+1);             % W1 Amp
    xlsSetCellVal(spec_data(kk).W2_Amp,xlsSheet,2,polar_row+2);             % W2 Amp
    xlsSetCellVal(spec_data(kk).Slope,xlsSheet,2,polar_row+3);              % Slope
    xlsSetCellVal(spec_data(kk).Max_Var,xlsSheet,2,polar_row+4);            % Max Var
    
    % Phase Specs
    xlsSetCellVal(spec_data(kk).GD_W1,xlsSheet,2,polar_row+5);              % GD1
    xlsSetCellVal(spec_data(kk).GD_W2,xlsSheet,2,polar_row+6);              % GD2
    xlsSetCellVal(spec_data(kk).GD_W3,xlsSheet,2,polar_row+7);              % GD3
    xlsSetCellVal(spec_data(kk).Edge_to_Edge,xlsSheet,2,polar_row+8);       % E-E
    
    % Miscellaneous Specs
    xlsSetCellVal(spec_data(kk).S11_VSWR,xlsSheet,2,polar_row+9);           % S11 VSWR
    xlsSetCellVal(spec_data(kk).S22_VSWR,xlsSheet,2,polar_row+10);          % S22 VSWR

    eval(['xlsSetCellVal(spec_data(kk).',min_gain_max_IL,',xlsSheet,2,polar_row+11);']);  % Min Gain / Max IL
    eval(['xlsSetCellVal(spec_data(kk).',max_gain_min_IL,',xlsSheet,2,polar_row+12);']);                 % Max Gain / Min IL
    
    % Add border around data
    temp_range_obj=xlsGetRange(xlsSheet,2,polar_row-3,2,polar_row+12);
    temp_range_obj.Borders.LineStyle=1;
    temp_range_obj.HorizontalAlignment=3;
    
    % Autofit the rows and columns
    xlsSheet.Columns.AutoFit;
    xlsSheet.Rows.AutoFit;

    end
    
end

% Select Path and filename for saving excel
% [save_filename,save_path]=uiputfile('*.xls','Save the updated template as:',['RF_spec_analysis',datestr(now,1),'.xls']);
% saveas_filepath=fullfile(save_path,save_filename,datestr(now,1));

saveas_filepath=fullfile('S:\Curtis_Neiderer\MATLAB_Toolbox',['RF_spec_analysis_',datestr(now,1),'.xls']);

% Save and close excel
xlsWorkbook.SaveAs(saveas_filepath);
xlsWorkbook.Close;
xls.Quit;
xls.delete;