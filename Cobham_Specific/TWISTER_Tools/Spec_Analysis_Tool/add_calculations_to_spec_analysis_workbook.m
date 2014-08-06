function [] = add_calculations_to_spec_analysis_workbook

%
% add_calculatiosn_to_spec_analysis_workbook.m
%
% Description:
%   Reads the measured data from the spec_analysis_*.xls workbook
%   created with RF_spec_analysis_mod.xls and adds calculations for the
%   mean, standard deviation, and variance of the measurements before
%   saving the updated workbook as RF_spec_analysis_with_calcs_*.xls
%
% Inputs:
%   RF_spec_analysis_*.xls  ->  excel workbook to add calculations to,
%                               selected via uigetfile
%
% Outputs:
%   RF_spec_analysi_with_calcs  ->  updated excel workbook
%
% Author:
%   Curtis Neiderer, 12/15/2008
%
% Notes:
%   Date: 12/xx/2008
%   Comment:
%       Will want to write another version of this script when I overhaul the
%       RF_spec_analysis_mod.m script to save-off system_data into struct. This
%       will hopefully make it somewhat easier to get specific band
%       measurements and calculations.
%   
%   Date: 1/14/2009
%   Change 1.1:
%       Added a data type header above the data columns for each band to
%       help distguish different data types when workbooks are printed to
%       hard copy.
%       
%             data_range_obj=xlsGetRange(xlsSheet,3,head_row-3,last_col,head_row-1);
%             data_range_obj.Merge;
%             data_range_obj.Borders.LineStyle=1;
%             data_range_obj.HorizontalAlignment=3;
%             data_range_obj.VerticalAlignment=2;
%

%% Start excel and keep visible
xls=actxserver('Excel.Application');
xls.Visible=1;

% Add new workbook
[existing_file,existing_path]=uigetfile('*.xls','Select the spec analysis file to be edited:');
saveas_filepath=fullfile(existing_path,existing_file);

% Open selected file
xlsWorkbook=xls.Workbook.Open(fullfile(existing_path,existing_file));

% Get workbook sheet names 
if strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'TX_data')
    Tx_sheet=xlsWorkbook.Worksheets.Item(1);
    Rx_sheet=xlsWorkbook.Worksheets.Item(2);
elseif strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'RX_data')
    Rx_sheet=xlsWorkbook.Worksheets.Item(1);
    Tx_sheet=xlsWorkbook.Worksheets.Item(2);
else
    error('Something is wrong, sheet name does not match "Tx" or "Rx"')
end
xls_worksheets=[Tx_sheet,Rx_sheet];

%% Add calculations to Tx_sheet & Rx_sheet
for ii=1:length(xls_worksheets)
   
    % Activate sheet
    xlsSheet=xls_worksheets(ii);
    xlsSheet.Activate();
   
    % Load data from sheet
    for head_row=[4,22,40,58,76,94,112,130,148,166,184]
          
        zz=1;
        test_col=2;
        while zz
            
            test_col=test_col+1;
            
            % Find last col with data
            test_cell_val=xlsGetValue(xlsSheet,test_col,head_row);
            if ~isnan(test_cell_val)
                continue;
            else
                last_col=test_col-1;
                start_row=head_row+1;
                zz=0;
            end
        
        end
        
        % Add data type header above data columns and format
        data_range_obj=xlsGetRange(xlsSheet,3,head_row-3,last_col,head_row-1);
        data_range_obj.Merge;
        data_range_obj.Borders.LineStyle=1;
        data_range_obj.HorizontalAlignment=3;
        data_range_obj.VerticalAlignment=2;
        
        if ii==1
            data_range_obj.Value='TX Spec Analysis';
        elseif ii==2
            data_range_obj.Value='RX Spec Analysis';
        end
        
        % Add calculation headers
        xlsSetCellVal('Avg',xlsSheet,last_col+2,head_row);
        xlsSetCellBackground('k',xlsSheet,last_col+2,head_row);
        xlsSetCellForeground('w',xlsSheet,last_col+2,head_row);
                
        xlsSetCellVal('Std',xlsSheet,last_col+3,head_row);
        xlsSetCellBackground('k',xlsSheet,last_col+3,head_row);
        xlsSetCellForeground('w',xlsSheet,last_col+3,head_row);
        
        xlsSetCellVal('Var',xlsSheet,last_col+4,head_row);
        xlsSetCellBackground('k',xlsSheet,last_col+4,head_row);
        xlsSetCellForeground('w',xlsSheet,last_col+4,head_row);
        
        calc_head_obj=xlsGetRange(xlsSheet,last_col+2,head_row,last_col+4,head_row);
        calc_head_obj.HorizontalAlignment=3;
        
        % Load data       
        group_cnt=0;
        fig_handles=[];
        for row=start_row:(start_row+11)
            
            group_cnt=group_cnt+1;
            
            % Get row of data
            measured_data=[];
            for col=3:last_col
                temp_meas=xlsGetValue(xlsSheet,col,row);
                measured_data=[measured_data,temp_meas];
            end
           
            % Make calculations 
            avg_meas=mean(measured_data);
            standard_dev=std(measured_data);
            var_meas=var(measured_data);

            % Write values to excel
            xlsSetCellVal(avg_meas,xlsSheet,last_col+2,row);
            spec_val=compare_val_with_spec(avg_meas,xlsSheet,last_col+2,row);
            
            xlsSetCellVal(standard_dev,xlsSheet,last_col+3,row);
            xlsSetCellVal(var_meas,xlsSheet,last_col+4,row);        
            
        end
          
        % Add border around calculations
        temp_range_obj=xlsGetRange(xlsSheet,last_col+2,start_row,last_col+4,start_row+11);
        temp_range_obj.Borders.LineStyle=1;
        temp_range_obj.HorizontalAlignment=3;
        
    end
    
end

% Autofit the rows and columns
xlsSheet.Columns.AutoFit;
xlsSheet.Rows.AutoFit;

% Save and close excel
xlsWorkbook.Save;
xlsWorkbook.Close;
xls.Quit;
xls.delete;


%% ---------- Sub-Functions ---------- %%
