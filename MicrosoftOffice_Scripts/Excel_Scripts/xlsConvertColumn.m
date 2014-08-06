function [column_text] = xlsConvertColumn(column)

%
% xlsConvertColumn.m converts a column number to the Excel column letter
%
% column_text=xlsConvertColumn(column) converts a number between 1 and 256
%   to the appropriate Excel column letter between A and IV
%

if column > 256
    error(['Column #',column,' is > 256 and therefore too large for Excel']);
end

xls_cols={'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};

if column <= length(xls_cols)
    column_text=xls_cols{column};
else
    count=0;
    while (column > 26)
        count=count+1;
        column=column-26;
    end
    
    column_text=[xls_cols{count},xls_cols{column}];
end
