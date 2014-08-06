function []=parseCSTplotdata(plotdata_file,plot_type)

%
% parseCSTplotdata.m
%
% Description:
%   Pulls CST plot data from CST plot data (ASCII) text file, stores it
%   into pattern_data struct, then plots the pattern.
%
% Author:
%   Curtis Neiderer, 4/9/2009
%
% Notes / Changes:
%

%% Open file from within MATLAB
fid=fopen(plotdata_file,'rt');

%% Parse pattern_data into struct using strread

% Pre-allocate pattern_data struct
pattern_data=...
    struct('Theta_deg',[],...
    'Phi_deg',[],...
    'Abs_dB',[],...
    'Th_dB',[],...
    'Ph_dB',[],...
    'Left_dB',[],...
    'Right_dB',[]);

% Skip header lines of file, then continue to parser with first data line
for ii=1:3
    current_line=fgetl(fid);
end

% Start parsing data line-by-line
cnt=1;
while current_line~=-1

    % Store pattern_data into struct
    [Theta,Phi,Abs,Th,Ph,Left,Right]=strread(current_line);
    pattern_data.Theta_deg(cnt)=Theta;
    pattern_data.Phi_deg(cnt)=Phi;
    pattern_data.Abs_dB(cnt)=Abs;
    pattern_data.Th_dB(cnt)=Th;
    pattern_data.Ph_dB(cnt)=Ph;
    pattern_data.Left_dB(cnt)=Left;
    pattern_data.Right_dB(cnt)=Right;
    
    % Get next line from file
    current_line=fgetl(fid);
    cnt=cnt+1;       
    
end

%% Plot the pattern 
 x=-90:.001:90;
 y=interp1(pattern_data.Theta_deg,pattern_data.Abs_dB,x,'spline');
 plot(x,y) % interpolated data
%  plot(pattern_data.Theta_deg,pattern_data.Abs_dB) % data

