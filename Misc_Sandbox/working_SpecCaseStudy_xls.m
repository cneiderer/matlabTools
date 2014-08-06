function [filename]=working_SpecCaseStudy_xls(complete_data)

%
% working_SpecCaseStudy.m
%
% Description:
%   
%   
% Inputs:
%   complete_data   ->  structure with data from multiple TWISTER units
%
% Outputs:
%   
%
% Author:
%   Curtis Neiderer, 6/29/2009
%
% Notes/Changes:
%   Note 1.1: 6/30/2009
%   The initial version of the TWISTER_Compliance_SpecCaseStudy is
%   complete.  It's done in a somewhat haphazard fashion because I'm being
%   lazy, but it works nontheless.
%       

% Load data into MATLAB for formatting and output to Excel
if exist('complete_data','var')
    % Continue, data passed directly from batch script
elseif exist('complete_data','file')
    load(complete_data)
else
    cd('C:\MATLAB_Toolbox\Results\TWISTER_Related\'); % change to results directory
    [mat_file,mat_path]=uigetfile('*.mat','MAT-files (*.mat)',...
        'Select mat file containg TWISTER batch data: ');
    load(fullfile(mat_path,mat_file));
    cd('C:\MATLAB_Toolbox\'); % change back to top-level toolbox directory
end

%% Start excel and keep visible
xls=actxserver('Excel.Application');
% xls.Visible=1;      % Keep excel visible
xls.WindowState=2;  % Minimize excel to toolbar

% Add new workbook
[comp_xls,comp_xlspath]=uiputfile('*.xls',...
    'Save your system compliance spreadsheet as: ',...
    ['Spec_Case_Study_',datestr(now,30),'.xls']);

filename=fullfile(comp_xlspath,comp_xls);

xlsWorkbook=xlsAddnewWorkbook(xls,filename,...
    'C:\MATLAB_Toolbox\MicrosoftOffice_Scripts\Templates\Batch_System_Compliance_template.xlt');  
%     'C:\MATLAB_Toolbox\MicrosoftOffice_Scripts\Templates\SystemCompliance_SpecCaseStudy.xlt');

% Get workbook sheet names and activate
if strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'TX_parameters')
    TX_sheet=xlsWorkbook.Worksheets.Item(1);
    RX_sheet=xlsWorkbook.Worksheets.Item(2);
elseif strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'RX_parameters')
    RX_sheet=xlsWorkbook.Worksheets.Item(1);
    TX_sheet=xlsWorkbook.Worksheets.Item(2);
else
    error('Sheet name does not match "TX_param" or "Rx_param", please check your spreadsheet names')
end

%% Populate the system_compliance spreadsheet with measurement data
system_names=fields(complete_data);
meas_col=6;
for cc=1:length(system_names)
    
    meas_col=meas_col+1;
    current_system=system_names{cc};
    eval(['current_sys_data=complete_data.',current_system,';']);
    
    datatype_list=fields(current_sys_data);    
    for yy=1:length(datatype_list)
        
        % Skip sys_name field
        if strcmpi(datatype_list{yy},'sys_name')
            continue;
        end

        eval(['measurement_data=current_sys_data.',datatype_list{yy},';']);
    %     eval('measurement_data=data.temp_tx_data;');
        if isempty(measurement_data)
            disp(['Empty Datatype: ',datatype_list{yy},...
                ' , skipping to next datatype'])
        else

            disp(['Processing ',datatype_list{yy},' measurments ...'])

            for zz=1:length(measurement_data)

                if ~isempty(measurement_data(zz).band_name) && ...
                        ~isempty(measurement_data(zz).center_freq) ...
                        && ~isempty(measurement_data(zz).measurements)
                    disp(['- Band: ',measurement_data(zz).band_name])

                    if strcmpi(measurement_data(zz).mode,'TX')
                        xlsSheet=TX_sheet;
                        xlsSheet.Activate();
                    elseif strcmpi(measurement_data(zz).mode,'RX')
                        xlsSheet=RX_sheet;
                        xlsSheet.Activate();
                    else
                        error('data_type does not match case, please check your data structure')
                    end

%                     %
%                     xlsSetCellVal(sys_name,xlsSheet,2,162);
%                     xlsSetCellVal(user_name,xlsSheet,2,164);
%                     xlsSetCellVal(datestr(now,31),xlsSheet,2,165);

                    % Find the band location in excel

                    switch measurement_data(zz).band_name
                        case 'Ku-CDL RL'
                            band_location=[4,100];
                        case 'Ku-CDL FL'
                            band_location=[20,116];
                        case 'N-CDL OL'
                            band_location=[52,148];
                        case 'N-CDL IL'
                            band_location=[36,132];
                        case 'X-CDL RL'
                            band_location=[68,68];
                        case 'Intelsat DL'
                            band_location=[84,84];
                        case 'X-CDL FL'
                            band_location=[68,68];
                        case 'Intelsat UL'
                            band_location=[84,84];
                        otherwise
                            error('Could not find band_name case, please check your data')
                    end


                    % Find antenna location in excel
                    if strcmpi(measurement_data(zz).antenna_type,'NB')
                        antenna_location=band_location(1);
                    elseif strcmpi(measurement_data(zz).antenna_type,'WB')
                        antenna_location=band_location(2);
                    else
                        error('antenna_type does not match any of the cases')
                    end


                    % Compare measurements with spec values
%                     verdict_col=8;
%                     meas_col=7;
                    limit_col=6;
                    spec_col=5;
                    spec_row=antenna_location-1;
                    
                    col_start=7;
                    row_start=antenna_location-1;

                    xlsSetCellVal(system_names{cc},xlsSheet,meas_col,spec_row);

                    meas_field_list=fields(measurement_data(zz).measurements);
                    for xx=1:length(meas_field_list)

                        spec_row=spec_row+1;

                        disp(['   Comparing ',meas_field_list{xx},...
                            ' value with spec'])    
                        eval(['meas_val=measurement_data(zz).measurements.',...
                            meas_field_list{xx},';']);


                        % Write measurment to spreadsheet
                        xlsSetCellVal(meas_val,xlsSheet,meas_col,spec_row);

                        % Get spec value
                        spec_cell=xlsGetValue(xlsSheet,spec_col,spec_row);
                        if regexpi(spec_cell,'\d*[.]\d*\s','end') >= 3
                            spec_val=str2double(spec_cell(1:regexpi(spec_cell,...
                                '\d*[.]\d*\s','end')-1));
                        elseif regexpi(spec_cell,':','end')
                            spec_val=str2double(spec_cell(1:regexpi(spec_cell,...
                                ':','end')-1));
                        elseif regexpi(spec_cell,'NA')
                            spec_val=[];
                            continue;
                        else
                            error(['Something is wrong, the expression in spec_cell does not match'...
                                ' any of the regular expression options'])
                        end

                        % Is spec "Max" or "Min"
                        limit_str=xlsGetValue(xlsSheet,limit_col,spec_row);
                        if strcmpi(limit_str,'Max')
                            verdict_color=compare_values(spec_val,1,meas_val);
                            xlsSetCellBackground(verdict_color{1},xlsSheet,meas_col,spec_row);
                            xlsSetCellForeground(verdict_color{2},xlsSheet,meas_col,spec_row);
                        elseif strcmpi(limit_str,'Min')
                            verdict_color=compare_values(spec_val,0,meas_val);
                            xlsSetCellBackground(verdict_color{1},xlsSheet,meas_col,spec_row);
                            xlsSetCellForeground(verdict_color{2},xlsSheet,meas_col,spec_row);
                        else
                            error('limit_str is unrecognized case, please check your spreadsheet')
                        end
                        
                    end
                    
                    % Add border around data
                    temp_range_obj=xlsGetRange(xlsSheet,col_start,row_start,meas_col,spec_row);
                    temp_range_obj.Borders.LineStyle=1;
                    temp_range_obj.HorizontalAlignment=3;
                    temp_range_obj.VerticalAlignment=2;

                end                
                
            end

        end

        % Autofit the rows and columns
        xlsSheet.Columns.AutoFit;
        xlsSheet.Rows.AutoFit;
        
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

%% Calculate spec statistics and write to Excel
SpecCaseStudy_calcs(filename);

% % Note: This is a very lazy, non-robust way to do this
% 
% % Read data from excel to MATLAB
% RX_data=xlsread(filename,'RX_parameters');
% TX_data=xlsread(filename,'TX_parameters');
% 
% % Format data into giant arrays
% complete_RX_data=RX_data(:,7:end);
% complete_TX_data=TX_data(:,7:end);
% 
% % Calculate mean, standard deviation, and variance
% rx_spec_stats=[];
% for kk=1:length(RX_data)
%     rx_spec_stats=[rx_spec_stats;mean(complete_RX_data(kk,1:end)),...
%         std(complete_RX_data(kk,1:end)),var(complete_RX_data(kk,1:end))];
% end
% tx_spec_stats=[];
% for mm=1:length(TX_data)
%     tx_spec_stats=[tx_spec_stats;mean(complete_TX_data(mm,1:end)),...
%         std(complete_TX_data(mm,1:end)),var(complete_TX_data(mm,1:end))];
% end
% 
% % Write spec stats back to excel
% [n_row,n_col]=size(RX_data);
% rx_range_obj=get_stat_range_obj(n_col+2,4,n_col+4,n_row+3);
% xlswrite(filename,rx_spec_stats,'RX_parameters',rx_range_obj);
% [n_row,n_col]=size(TX_data);
% tx_range_obj=get_stat_range_obj(n_col+2,4,n_col+4,n_row+3);
% xlswrite(filename,tx_spec_stats,'TX_parameters',tx_range_obj);
% 
% test=1;
% 
% %% Make stem plots of spec compliance, then copy into powerpoint


%% --------------- %%%%% Sub-Functions %%%%% --------------- %%
%
function verdict_color = compare_values(spec_val,max_flag,meas_val)

% Spec is a max value
if max_flag==1 
   if meas_val<(spec_val*0.9) % 10 percent margin
       verdict_color={'g','k'};
   elseif (meas_val>=(spec_val*0.9)) && (meas_val<=spec_val) % within 10 percent
       verdict_color={'y','k'};
   else % misses spec
       verdict_color={'r','w'};
   end
% Spec is a min value
elseif max_flag==0 
   if (meas_val>(spec_val*1.1)) % 10 percent margin
       verdict_color={'g','k'};
   elseif (meas_val>=spec_val) && (meas_val<=(spec_val*1.1)) % within 10 percent
       verdict_color={'y','k'};
   else % misses spec
       verdict_color={'r','w'};
   end    
else
    ('Invalid max_flag value entered, value must be "0" or "1"');
end

% % 
% function range_obj = get_stat_range_obj(start_col,start_row,end_col,end_row)
% 
% if ~exist('end_row','var')
%     end_row=start_row;
%     if ~exist('end_col','var')
%         end_col=start_col;
%     end
% end
% 
% if start_col>256 || end_col>256 || start_row>65536 || end_row>65536
%     error('The range falls outside Excel''s limits')
% end
% 
% if ~ischar(start_col)
%     start_col=xlsConvertColumn(start_col);
% end
% 
% if ~ischar(end_col)
%     end_col=xlsConvertColumn(end_col);
% end
% 
% range_obj=([start_col,num2str(start_row),':',end_col,num2str(end_row)]);
