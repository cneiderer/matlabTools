function [freq,S_param] = readin_S2P_file(filename)

%
% readin_S2P_file.m
%
% Description:
%   Parses an S2P file into a freq array and the complex S_param array
%
% Inputs:
%   filename    ->  fullfile path to the S2P file
%
% Outputs:
%   freq        ->  frequency
%   S_param     ->  complex S parameters
%
% Author:
%   Curtis Neiderer, 1/13/2009
%
% Notes / Changes:
%   Date: 1/13/2009
%   Comment: The way I parse the data lines could be greatly improved and
%       made more efficient with some type of a loop, but at the moment I 
%       don't really care since it doesn't take too long to parse with my 
%       current quick and dirty method.
%

%% Open file from MATLAB
fid=fopen(filename,'rt');

%% Find last header line of S2P file
ii=1;
while ii   
    header_line=fgetl(fid);
    if strfind(header_line,'#')
        ii=0;        
    end
end

%% Read in data lines and store appropriately
% Get first data line    
data_line=fgetl(fid);

% Get pieces from each data line
freq=[];
S_param=[];
while data_line~=-1
    
    line_spaces=regexp(data_line,' ');
    
    freq=[freq;str2num(data_line(1:line_spaces(1)-1))];

    S11_real=str2num(data_line(line_spaces(1)+1:line_spaces(2)-1));
    S11_imag=str2num(data_line(line_spaces(2)+1:line_spaces(3)-1));
    S11=complex(S11_real,S11_imag);

    S21_real=str2num(data_line(line_spaces(3)+1:line_spaces(4)-1));
    S21_imag=str2num(data_line(line_spaces(4)+1:line_spaces(5)-1));
    S21=complex(S21_real,S21_imag);

    S12_real=str2num(data_line(line_spaces(5)+1:line_spaces(6)-1));
    S12_imag=str2num(data_line(line_spaces(6)+1:line_spaces(7)-1));
    S12=complex(S12_real,S12_imag);

    S22_real=str2num(data_line(line_spaces(7)+1:line_spaces(8)-1));
    S22_imag=str2num(data_line(line_spaces(8)+1:end));
    S22=complex(S22_real,S22_imag);

    S_param=[S_param;S11,S21,S12,S22];
     
    % Clear re-used variables
    clear line_spaces S11_real S11_imag S21_real S21_imag S12_real S12_imag...
          S22_real S22_imag S11 S21 S12 S22
    
    % Get next data line
    data_line=fgetl(fid);

end

freq=freq/10^9; % Convert frequency to from Hz to GHz

test=1;