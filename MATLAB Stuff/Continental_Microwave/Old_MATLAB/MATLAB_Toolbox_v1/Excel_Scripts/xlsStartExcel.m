function [xls] = xlsStartExcel(varargin)

% xlsStartExcel.m starts and returns a handle to an activeX Excel server
%   
%   xls = xlsStartExcel() starts an invisible Excel server
%   xls = xlsStartExcel(true) starts a visible Excel server
%

if nargin > 0 && varargin{1}
    visible=1;
else
    visible=0;
end

try
    xls=actxserver('Excel.Application');
    xls.Visible=visible;
catch
    try xls.Quit, end
    delete xls;
    error('Could not start Excel activeX server')
end
