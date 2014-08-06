function [range_obj] = xlsGetRange(sheet,start_col,start_row,end_col,end_row)

%
% xlsGetRange.m gets a handle to an Excel cell range object
%
% range_obj=xlsGetRange(sheet,start_col,start_row,end_col,end_row) requires
%   and Excel worksheet object, and then two pairs of numbers that indicate
%   the starting column and row and the ending column and row.
%
% range_obj=xlsGetRange(sheet,start_col,start_row,end_col,end_row) requires
%   and Excel worksheet object,and then the rows and columns with the
%   columns as character strings 'A'-'IV' like in Excel and the rows as
%   numbers
%
% range_obj=xlsGetRange(sheet,start_col,start_row) requires an Excel
%   worksheet object, and then the row and column with the column as
%   character strings 'A'-'IV' like in Excel and the row as numbers
%

if ~exist('end_row','var')
    end_row=start_row;
    if ~exist('end_col','var')
        end_col=start_col;
    end
end

if start_col>256 | end_col>256 | start_row>65536 | end_row>65536
    error('The range falls outside Excel''s limits')
end

if ~ischar(start_col)
    start_col=xlsConvertColumn(start_col);
end

if ~ischar(end_col)
    end_col=xlsConvertColumn(end_col);
end

range_obj=sheet.Range([start_col,num2str(start_row),':',end_col,num2str(end_row)]);

