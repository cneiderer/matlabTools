function [] = xlsMakeTable(filename,data,col_header,row_header)

%
% xlsMakeTable.m creates an Excel sheet from the matrix and a col_header
%   1) the filename to save the xls to
%   2) the data to be inserted into the sheet
%   3) the col_header (should be a cell)
%

if ~exist('row_header')
    row_header={};
end

if ispc
    
    try
        excel=xlsStartExcel;
%         excel=xlsStartExcel(1);
        workbook=xlsAddNewWorkbook(excel,filename);
        sheet=workbook.Worksheets.Item(1);
        sheet.Activate();
        secret=xlsGetRange(shee,1,1,size(data,2),1);
        xlsAddClassification(secret,'secret');
        
        if ~isempty(row_header)
            col_header_cells=xlsGetRange(sheet,2,2,size(col_header,2)+1,2);
        else
            col_header_cells=xlsGetRange(sheet,1,2,size(col_header,2),2);
        end
        
        col_header_cells.Value=col_header;
        xlsSetFontColor(col_header_cells,'white');
        
        if ~isempty(row_header)
            col_header_cells=xlsGetRange(sheet,1,1,size(col_header,2)+1,2);
        else
            col_header_cells=xlsGetRange(sheet,1,1,size(col_header,2),2);
        end
        
        xlsSetBackgroundColor(col_header_cells,'blue');
        
        if ~isempty(row_header)
            row_header_cells=xlsGetRange(sheet,1,3,1,size(row_header,2)+2);
            
            if (size(row_header,2) > size(row_header,1))
                row_header=row_header';
            end
            
            row_header_cells.Value=row_header;
            xlsSetFontColor(row_header_cells,'white');
            xlsSetBackgroundColor(row_header_cells,'blue');
        end
        
        if isempty(row_header)
            data_cells=xlsGetRange(sheet,1,3,size(data,2),size(data,1)+2);
        else
            data_cells=xlsGetRange(sheet,2,3,size(data,2)+1,size(data,1)+2);
        end
        
        data_cells.Value=data;
        
        if isempty(row_header)
            table_cells=xlsGetRange(sheet,1,2,size(data,2),size(data,1)+2);
        else
            table_cells=xlsGetRange(sheet,1,2,size(data,2)+1,size(data,1)+2);
        end
        
        table_cells.Borders.LineStyle=1;
        sheet.Columns.AutoFit;
        sheet.Rows.AutoFit;
        workbook.Save();
        workbook.Close();
        excel.Quit;
        
        clear secret col_header_cells data_cells table_cells sheet workbook excel;
        
    catch
        
        [msg,id]=lasterr;
        if exist('excel') ~= 0 && exist('excel') ~= 7
            excel.Quit;
        end
        
        error(msg);
        
    end
    
else
    error('This must be run on a pc')
end
