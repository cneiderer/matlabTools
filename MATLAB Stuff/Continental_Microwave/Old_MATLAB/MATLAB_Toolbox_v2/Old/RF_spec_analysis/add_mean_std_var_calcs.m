function [] = add_mean_std_var_calcs

%
% add_mean_std_var_calcs.m
%
% Description:
%   Reads the measured data from the RF_spec_analysis_*.xls workbook
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
%   Will want to write another version of this script when I overhaul the
%   RF_spec_analysis_mod.m script to save-off system_data into struct. This
%   will hopefully make it somewhat easier to get specific band
%   measurements and calculations.
%

%% Start excel and keep visible
xls=actxserver('Excel.Application');
xls.Visible=1;

% Add new workbook
[existing_file,existing_path]=uigetfile('*.xls','Select the spec analysis file to be amended:');
    
% Open selected file
xlsWorkbook=xls.Workbook.Open(fullfile(existing_path,existing_file));

% Get workbook sheet names 
if strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'Tx')
    Tx_sheet=xlsWorkbook.Worksheets.Item(1);
    Rx_sheet=xlsWorkbook.Worksheets.Item(2);
elseif strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'Rx')
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
            
%             %% Make CDF Plot
%             
%             % Create new figure & resize 
%             if (group_cnt==1) || (group_cnt==5) || (group_cnt==9) 
% 				
%                 % Store figure handles
%                 fig_handles=[fig_handles,figure];
%                 
%                 % Set figure name
%                 if group_cnt==1
%                     set(fig_handles(end),'Name','Amplitude Measurements');
%                 elseif group_cnt==5
%                     set(fig_handles(end),'Name','Phase Measurements');
%                 elseif group_cnt==9
%                     set(fig_handles(end),'Name','Miscellaneous Measurments');
%                 end
%                 
%                 % Resize figure
%                 left_pos=300;
%                 bottom_pos=300;
%                 width_pos=750;
%                 height_pos=500;
%                 rect_pos=[left_pos,bottom_pos,width_pos,height_pos];
%                 set(fig_handles(end),'Position',rect_pos);
%                 
%             end
%             
%             % Add Axes & Label
%             switch group_cnt
%                 case 1
%                     subplot(4,1,1);
%                     xlabel('[dB]');
%                     ylabel('W1 Amp');
%                 case 2
%                     subplot(4,1,2);
%                     xlabel('[dB]');
%                     ylabel('W2 Amp');
%                 case 3
%                     subplot(4,1,3);
%                     xlabel('[dB]');
%                     ylabel('Slope');
%                 case 4
%                     subplot(4,1,4);
%                     xlabel('[dB/MHz]');
%                     ylabel('Max Var');
%                 case 5
%                     subplot(4,1,1);
%                     xlabel('[ns]');
%                     ylabel('GD W1');
%                 case 6
%                     subplot(4,1,2);
%                     xlabel('[ns]');
%                     ylabel('GD W2');
%                 case 7
%                     subplot(4,1,3);
%                     xlabel('[ns]');
%                     ylabel('GD W3');
%                 case 8
%                     subplot(4,1,4);
%                     xlabel('[ns]');
%                     ylabel('E-E');
%                 case 9
%                     subplot(4,1,1);
% %                     xlabel('');
%                     ylabel('S11 VSWR');
%                 case 10
%                     subplot(4,1,2);
% %                     xlabel('');
%                     ylabel('S22 VSWR');                    
%                 case 11
%                     subplot(4,1,3);
%                     xlabel('[dB]');
%                     if ii==1
%                         ylabel('Max IL')
%                     elseif ii==2
%                         ylabel('Min Gain')
%                     end
%                 case 12
%                     subplot(4,1,4);
%                     xlabel('[dB]');
%                     if ii==1
%                         ylabel('Min IL')
%                     elseif ii==2
%                         ylabel('Max Gain')
%                     end
%                 otherwise
%             end
%             hold on;
%                         
%             % Plot measured_data
%             cdf_data=[];
% 			cdf_forplot=[];
%             for zz=1:length(measured_data)
%                 eval('cdf_data=[cdf_data,repmat(measured_data(zz),1,2)];');
%                 eval('cdf_forplot=[cdf_forplot,((zz-1):zz)/length(measured_data)];');
%             end
%             
%             plot(cdf_data,cdf_forplot,'-b','LineWidth',2);
%             hold on;
%             
%             % Check if spec_val is character (i.e., 'N/A' or 'NA')
%             if ~ischar(spec_val)
%                 
%                 % Plot spec
%                 spec_value=spec_val*ones(1,length(measured_data)+1);
%                 spec_forplot=(0:length(measured_data))/length(measured_data);
%                 plot(spec_value,spec_forplot,'--r','LineWidth',2);  
%                 
%                 % Set Xlimits
%                 min_xlim=min(min(measured_data),spec_val)-0.25;
%                 max_xlim=max(max(measured_data),spec_val)-0.25;
%                 xlim([min_xlim,max_xlim]);
%                 
%             else
%                 
%                 % Set Xlimits
%                 min_xlim=min(measured_data)-0.25;
%                 max_xlim=max(measured_data)-0.25;
%                 xlim([min_xlim,max_xlim]);
%                 
%             end
%             hold off;
            
            
            
            clear cdf_data cdf_forplot spec_value spec_forplot
            
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

% Select Path and filename for saving excel
% [save_filename,save_path]=uiputfile('*.xls','Save your RF spec analysis as:',['RF_spec_analysis_with_calcs_',datestr(now,1),'.xls']);
% saveas_filepath=fullfile(save_path,save_filename);

saveas_filepath=fullfile('S:\Curtis_Neiderer\MATLAB_Toolbox\',['RF_spec_analysis_with_calcs_',datestr(now,1),'.xls']);

% Save and close excel
xlsWorkbook.SaveAs(saveas_filepath);
xlsWorkbook.Close;
xls.Quit;
xls.delete;


%% ---------- Sub-Functions ---------- %%
