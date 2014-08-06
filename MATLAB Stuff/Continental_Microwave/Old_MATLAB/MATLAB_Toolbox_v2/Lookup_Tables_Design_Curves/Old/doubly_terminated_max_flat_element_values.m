function [g_matrix] = doubly_terminated_max_flat_element_values

%
% doubly_terminated_max_flat_element_values.m
%

g_matrix=zeros(15,16); % hardcoded for (num_elements+1,num_elements)
for ii=1:15 % hardcoded 1:num_elements
    for jj=1:ii  
        
        % Calculate element value
        g_matrix(ii,jj)=2*sin(((2*jj-1)*pi)/(2*ii));
        g_matrix_cell{ii,jj}=2*sin(((2*jj-1)*pi)/(2*ii));
        
        if jj==ii
            g_matrix(ii,jj+1)=1;
            g_matrix_cell{ii,jj+1}=1;
        end
    
    end
end


%% Put into excel spreadsheet

% Start excel and keep visible
xls=actxserver('Excel.Application');
xls.Visible=1;

% Add new workbook
xlsWorkbook=xls.Workbook.Add;

% Activate and name sheet
xlsSheet=xlsWorkbook.Worksheets.Item(1);
xlsSheet.Activate();
xlsSheet.Name='max_flat';

% Set header font/background colors
num_rows=size(g_matrix,1);
num_cols=size(g_matrix,2);

col_header_range=xlsGetRange(xlsSheet,1,1,num_cols+1,1);
row_header_range=xlsGetRange(xlsSheet,1,1,1,num_rows+1);

xlsSetFontColor(row_header_range,'w');
xlsSetFontColor(col_header_range,'w');

xlsSetBackgroundColor(row_header_range,'k');
xlsSetBackgroundColor(col_header_range,'k');

row_header_range.Cells.Font.Bold=1;
col_header_range.Cells.Font.Bold=1;

row_header_range.HorizontalAlignment=3;
col_header_range.HorizontalAlignment=3;

% Set header values
xlsSetCellVal('Order n',xlsSheet,1,1);

for jj=1:size(g_matrix,2)
    xlsSetCellVal(['g',num2str(jj)],xlsSheet,jj+1,1);
%     xlsSetCellForeground('w',xlsSheet,jj+1,1);
%     xlsSetCellBackground('k',xlsSheet,jj+1,1);
end

for ii=1:size(g_matrix,1)
    xlsSetCellVal(num2str(ii),xlsSheet,1,ii+1);
end
    
% Put data into excel
for ii=1:size(g_matrix,1)
	for jj=1:size(g_matrix,2)
            
        if g_matrix(ii,jj)~=0
            xlsSetCellVal(g_matrix(ii,jj),xlsSheet,jj+1,ii+1);
        else
            xlsSetCellVal('',xlsSheet,jj+1,ii+1);
        end
        xlsSetCellForeground('k',xlsSheet,jj+1,ii+1);
        xlsSetCellBackground('w',xlsSheet,jj+1,ii+1);        
        
    end
end

% Add border
border_range=xlsGetRange(xlsSheet,2,2,jj+1,ii+1);
border_range.Borders.Weight=1;

% Autofit the rows and columns
xlsSheet.Columns.AutoFit;
xlsSheet.Rows.AutoFit;

% Save and close excel
xlsWorkbook.SaveAs(fullfile(cd,'test_actx_excel.xls'));
xlsWorkbook.Close;
xls.Quit;
xls.delete;

x=1;
