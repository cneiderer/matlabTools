function [val] = xlsGetConstant(str)

%
% xlsGetConstant.m
%

str=lower(str);

switch str
    case 'xlcenter'
        val=3;
    otherwise
        
        error([str,' is not a valid Excel constant']);
end