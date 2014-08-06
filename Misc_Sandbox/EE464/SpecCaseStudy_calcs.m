function []=SpecCaseStudy_calcs(varargin)

%
% SpecCaseStudy_calcs.m
%
% Description:
%
% Inputs:
%
% Outputs:
%
% Author:
%   Curtis Neiderer, 7/1/2009
%
% Notes / Changes:
%

% Get workbook name
if nargin==1
    existing_xls=vargin{1};
else
    [filename,filepath]=uigetfile({'*.xls','Excel files (*.xls)';...
        '*.*','All Files (*.*)'},...
        'Select the SpecCaseStudy workbook to add calcs to: ');
    existing_xls=fullfile(filepath,filename);
end

% if ~exist('existing_xls','file')
%     error('You did not select an existing workbook, please try again.')
% end

% Open existing workbook in excel
xls=actxserver('Excel.Application');
xls.Visible=1;
xlsWorkbook=xls.Workbook.Open(existing_xls);

% Calculate spec stats (mean,std,var,etc.) 
for ii=1:2
    
    % Activate sheet
    xlsSheet=xlsWorkbook.Sheets.Item(ii);
    xlsSheet.Activate();
    
    % Load data from sheet
    for head_row=[3,19,35,51,67,83,99,115,131,147]
        
        zz=1;
        test_col=6;
        first_col=6;
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
        
        % Format data columns
        data_range_obj=xlsGetRange(xlsSheet,first_col,head_row,...
            last_col,head_row+12);
        data_range_obj.Borders.LineStyle=1;
        data_range_obj.HorizontalAlignment=3;
        data_range_obj.VerticalAlignment=2;
        
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
        
        calc_head_obj=xlsGetRange(xlsSheet,last_col+2,head_row,...
            last_col+4,head_row);
        calc_head_obj.HorizontalAlignment=3;
        calc_head_obj.VerticalAlignment=2;
        
        % Load data       
        group_cnt=0;
        for row=start_row:(start_row+11)
            
            group_cnt=group_cnt+1;
            
            % Get row of data
            measured_data=[];
            for col=7:last_col
                temp_meas=xlsGetValue(xlsSheet,col,row);
                measured_data=[measured_data,temp_meas];
            end
           
            % Make calculations 
            avg_meas=mean(measured_data);
            standard_dev=std(measured_data);
            var_meas=var(measured_data);

            % Write values to excel
            xlsSetCellVal(avg_meas,xlsSheet,last_col+2,row);            
            xlsSetCellVal(standard_dev,xlsSheet,last_col+3,row);
            xlsSetCellVal(var_meas,xlsSheet,last_col+4,row); 
            
        end
          
        % Add border around calculations
        calc_range_obj=xlsGetRange(xlsSheet,last_col+2,start_row,...
            last_col+4,start_row+11);
        calc_range_obj.Borders.LineStyle=1;
        calc_range_obj.HorizontalAlignment=3;
        
    end 
    
    % Autofit the rows and columns
    xlsSheet.Columns.AutoFit;
    xlsSheet.Rows.AutoFit;

end

% Save and close excel
xlsWorkbook.Save;
xlsWorkbook.Close;
xls.Quit;
xls.delete;
