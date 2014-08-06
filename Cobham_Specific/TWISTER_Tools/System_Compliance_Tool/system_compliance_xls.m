function [] = system_compliance_xls(varargin)

%
% system_compliance_xls.m
%
% Description:
%   This script follows system_compliance_check.m to create a formatted 
%   excel workbook for easy comparison and validation of the system data 
%   with the spec values.
%
% Inputs:
%   *_measurement_data_*.mat    ->  Either pass *.mat file path in directly
%                                   or script will prompt you to find it
%
% Outputs:
%   system_compliance_*.xls     ->  An excel workbook with 2 sheets (TX &
%                                   RX) comparing the system measurements 
%                                   and the system specs that is saved in
%                                   the user defined location (The script
%                                   will prompt you)
%
% Author:
%   Curtis Neiderer, 12/22/2008
%
% Notes / Changes:
%   Date: 1/19/2009
%   Change 1.1:
%       Added username prompt and record the entered string into the bottom
%       of the system compliance workbook.
%   Date: 1/19/2009
%   Change 1.2: 
%       Now record the system name/serial# on every table of the system
%       compliance workbook.
%

%% Enter the system name whose data you're analyzing
sys_name=input('Enter the name of the system you will be analyzing: ','s');
%% Enter your username
user_name=input('Enter your username: ','s');

%% 
if nargin==1
    mat_fullfilepath=varargin{1};
else
    [mat_file,mat_filepath]=uigetfile('*.mat','Select the *.mat measurement data file',[sys_name,'_measurement_data_',datestr(now,1),'.mat']);
    mat_fullfilepath=fullfile(mat_filepath,mat_file);
end

if ~isempty(mat_fullfilepath)
    data=load(mat_fullfilepath);
else
    error('No *.mat measurement data file was selected!!!')
end


%% Start excel and keep visible
xls=actxserver('Excel.Application');
xls.Visible=1;      % Keep excel visible
% xls.WindowState=2;  % Minimize excel to toolbar

% Add new workbook
[comp_xls,comp_xlspath]=uiputfile('*.xls','Save your system compliance spreadsheet as: ',[sys_name,'_system_compliance_',datestr(now,1),'.xls']);
filename=fullfile(comp_xlspath,comp_xls);
xlsWorkbook=xlsAddnewWorkbook(xls,filename,'S:\Curtis_Neiderer\MATLAB_Toolbox\Templates\system_compliance_template.xlt');

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
% datatype_list={'tx_data'};
datatype_list=fields(data);
for yy=1:length(fields(data))
    
    eval(['measurement_data=data.',datatype_list{yy},';']);
%     eval('measurement_data=data.temp_tx_data;');
    if isempty(measurement_data)
        disp(['Empty Datatype: ',datatype_list{yy},' , skipping to next datatype'])
    else
        
        disp(['Processing ',datatype_list{yy},' measurments ...'])
    
        for zz=1:length(measurement_data)

            if ~isempty(measurement_data(zz).band_name) && ~isempty(measurement_data(zz).center_freq) ...
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

                %
                xlsSetCellVal(sys_name,xlsSheet,2,162);
                xlsSetCellVal(user_name,xlsSheet,2,164);
                xlsSetCellVal(datestr(now,31),xlsSheet,2,165);
                
                %% Find the band location in excel

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


                %% Find antenna location in excel
                if strcmpi(measurement_data(zz).antenna_type,'NB')
                    antenna_location=band_location(1);
                elseif strcmpi(measurement_data(zz).antenna_type,'WB')
                    antenna_location=band_location(2);
                else
                    error('antenna_type does not match any of the cases')
                end


                %% Compare measurements with spec values
                verdict_col=8;
                meas_col=7;
                limit_col=6;
                spec_col=5;
                spec_row=antenna_location-1;
                
                xlsSetCellVal(sys_name,xlsSheet,1,spec_row);
                
                meas_field_list=fields(measurement_data(zz).measurements);
                for xx=1:length(meas_field_list)

                    spec_row=spec_row+1;

                    disp(['   Comparing ',meas_field_list{xx},' value with spec'])    
                    eval(['meas_val=measurement_data(zz).measurements.',meas_field_list{xx},';']);


                    %% Write measurment to spreadsheet
                    xlsSetCellVal(meas_val,xlsSheet,meas_col,spec_row);

                    %% Get spec value
                    spec_cell=xlsGetValue(xlsSheet,spec_col,spec_row);
                    if regexpi(spec_cell,'\d*[.]\d*\s','end') >= 3
                        spec_val=str2num(spec_cell(1:regexpi(spec_cell,'\d*[.]\d*\s','end')-1));
                    elseif regexpi(spec_cell,':','end')
                        spec_val=str2num(spec_cell(1:regexpi(spec_cell,':','end')-1));
                    elseif regexpi(spec_cell,'NA')
                        spec_val=[];
                        continue;
                    else
                        error(['Something is wrong, the expression in spec_cell does not match'...
                            ' any of the regular expression options'])
                    end

                    %% Is spec "Max" or "Min"
                    limit_str=xlsGetValue(xlsSheet,limit_col,spec_row);
                    if strcmpi(limit_str,'Max')
                        verdict_is=compare_values(spec_val,1,meas_val);
                        xlsSetCellVal(verdict_is,xlsSheet,verdict_col,spec_row);
                    elseif strcmpi(limit_str,'Min')
                        verdict_is=compare_values(spec_val,0,meas_val);
                        xlsSetCellVal(verdict_is,xlsSheet,verdict_col,spec_row);
                    else
                        error('limit_str is unrecognized case, please check your spreadsheet')
                    end

                end

            end

        end

    end
    
end

test=1;

% Save and close excel
xlsWorkbook.Save;
xlsWorkbook.Close;
xls.Quit;
xls.delete;

%% --------------- %%%%% Sub-Functions %%%%% --------------- %%

%%
function verdict_is = compare_values(spec_val,max_flag,meas_val)

if max_flag==1
   if meas_val<=spec_val
       verdict_is='Y';
   else
       verdict_is='N';
   end
elseif max_flag==0
   if meas_val>=spec_val
       verdict_is='Y';
   else
       verdict_is='N';
   end    
else
    ('Invalid max_flag value entered, value must be "0" or "1"')
end

% %%
% function meas_val = get_meas_val(measurement_data,field)
% 
% switch field
%     case 1
%         meas_val=measurement_data.measurements.S11_Max;
%     case 2
%         meas_val=measurement_data.measurements.S22_Max;
%     case 3
%         meas_val=measurement_data.measurements.Min_Gain;
%     case 4
%         meas_val=measurement_data.measurements.Max_Gain;
%     case 5
%         meas_val=measurement_data.measurements.Slope;
%     case 6
%         meas_val=measurement_data.measurements.W1_Amp;
%     case 7
%         meas_val=measurement_data.measurements.W2_Amp;
%     case 8
%         meas_val=measurement_data.measurements.Ripple;
%     case 9
%         meas_val=measurement_data.measurements.Edge_to_Edge;
%     case 10
%         meas_val=measurement_data.measurements.W1_GroupDelay;
%     case 11
%         meas_val=measurement_data.measurements.W2_GroupDelay;
%     case 12
%         meas_val=measurement_data.measurements.W3_GroupDelay;
%     otherwise
%         error('Field number does not max fields index')
% end
% 
% %%
% function measurement_data = get_datatype(data,datatype)
% 
% switch datatype
%     case 1
%         measurement_data=data.tx_data;
%     case 2
%         measurement_data=data.rx_data;
%     case 3
%         measurement_data=data.WB_tx_data;
%     case 4
%         measurement_data=data.WB_rx_data;
%     otherwise
%         error('datatype exceeds max datatype index')
% end