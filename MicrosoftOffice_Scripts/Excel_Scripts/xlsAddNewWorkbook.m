function [workbook] = xlsAddNewWorkbook(excel,varargin)

%
% xlsAddNewWorkbook.m creates and returns a handle to a new Excel workbook
%
% workbook=xlsAddNewWorkbook(excel) creates a new workbook and does not
%   save it. Excel is a handle to an Excel interface.
%
% workbook=xlsAddNewWorkbook(excel,filename) creates a new workbook and
%   saves it to filename via SaveAs. Excel is a handle to an Excel 
%   interface
%
% workbook=xlsAddnewWorkbook(excel,filename,template) creates a new
%   workbook with a template and saves it to filename via SaveAs. Excel is
%   a handle to an Excel interface
%

error(nargchk(1,3,nargin))

template=[];
filename=[];

if nargin==2
    filename=varargin{1};
elseif nargin > 2
    filename=varargin{1};
    if nargin == 3
        template = varargin{2};
    end
end

try
    workbook = excel.Workbooks.Add(template);
catch
    if ~isempty(template)
        error(['Could not create new work book with template: ',template])
    else
        error('Could not create new work book')
    end
end

if ~isempty(filename)
    workbook.SaveAs(filename);
end