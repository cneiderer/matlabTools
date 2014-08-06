function [specs,spec_units] = get_spec_values(varargin)

%
% get_spec_values.m
%
% Description:
%   Gets the spec values from the specified excel workbook if one is passed
%   in, otherwise it asks you to specify the workbook to get them from.
%
% Inputs:
%   - varargin{1}   ->  excel workbook with spec values
%   - selected workbook via uigetfile if varargin{1} DNE
% 
% Outputs:
%   - specs struct  ->  contains the tx and rx specs from the excel sheet
%                       that was selected for getting the values
%   - spec_units struct  ->  contains the tx and rx spec units
%
% Author:
%   Curtis Neiderer, 12/15/2008
%
% Notes:
%   None at this time.
%

% Check if input argument exist, else pick 
if nargin==1
    spec_val_workbook=varargin{1};
else
    [spec_file,spec_path]=uigetfile('*.xls','Select the spec val workbook: ');
    spec_val_workbook=fullfile(spec_path,spec_file);
end

% Start excel and keep visible
xls=actxserver('Excel.Application');
xls.Visible=1;

% Open spec val workbook
xlsWorkbook=xls.Workbook.Open(spec_val_workbook);

% Get workbook sheet names 
if strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'Tx_spec')
    Tx_specs=xlsWorkbook.Worksheets.Item(1);
    Rx_specs=xlsWorkbook.Worksheets.Item(2);
elseif strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'Rx_spec')
    Rx_specs=xlsWorkbook.Worksheets.Item(1);
    Tx_specs=xlsWorkbook.Worksheets.Item(2);
else
    error('Something is wrong with the spec val workbook you loaded.')
end
xls_worksheets=[Rx_specs,Tx_specs];

% Get spec values
for ii=1:length(xls_worksheets)
    
    % Activate sheet
    xlsSheet=xls_worksheets(ii);
    xlsSheet.Activate();
    
    for xx=1:13 % Columns
        for yy=1:15 % Rows
            
            % Get spec val
            spec_val=xlsGetValue(xlsSheet,xx,yy);
            if isnan(spec_val)
                spec_val='';
            end
            
            % Record in spec matrix
            if ii==1
                rx_spec_matrix{yy,xx}=spec_val;
            else
                tx_spec_matrix{yy,xx}=spec_val;
            end
                               
        end        
    end
        
end

% Save and close excel
xlsWorkbook.Close;
xls.Quit;
xls.delete;

%% Convert spec matrices into structs
rx_spec_fields=rx_spec_matrix(1:15,1);
tx_spec_fields=tx_spec_matrix(1:15,1);

rx_spec_struct=cell2struct(rx_spec_matrix(1:15,3:13),rx_spec_fields,1);
rx_spec_units=cell2struct(rx_spec_matrix(1:15,2),rx_spec_fields,1);

tx_spec_struct=cell2struct(tx_spec_matrix(1:15,3:13),tx_spec_fields,1);
tx_spec_units=cell2struct(tx_spec_matrix(1:15,2),tx_spec_fields,1);

specs=struct('rx_specs',rx_spec_struct,'tx_specs',tx_spec_struct);
spec_units=struct('rx_spec_units',rx_spec_units,'tx_spec_units',tx_spec_units);

%% Save spec values as .mat file
% [save_name,save_path]=uiputfile('*.mat','Save spec values as .mat file', 'overall_spec_struct.mat')
% save(fullfile(save_path,save_name),'specs','spec_units');

save('S:\Curtis_Neiderer\MATLAB_Toolbox\spec_values.mat','specs','spec_units');

test=0;

