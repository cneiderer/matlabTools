function [filter_info] = parseWGD(fid)

%
% parseWGD.m
%
% Version 1: 3/4/2009
% Supports vane iris WGDs only.
%
% Version 2: 
%
% Description:
%   Pulls filter design specs from WEAFIL WGD data file and stores them
%   into filter_info structure.
%
% Inputs:
%   fid     ->  WEAFIL WGD file identifier
%
% Outputs:
%   filter_info     ->  structure containing filter design specs
%
% Author:
%   Curtis Neiderer, 3/4/2009
%
% Notes / Changes:
%

%% Get Design Inputs
ii=1;
while ii

    %% Get next line from file
    current_line=fgetl(fid);
   
    if ~isempty(strfind(current_line,'Read file'))
        filter_info.read_file=current_line(18:23);
    elseif ~isempty(strfind(current_line,'Outfile'))
        filter_info.outfile=current_line(18:23);
        
        if length(current_line)==48 && strcmpi(current_line(47),'X')
            filter_info.iris_type='Vane';
        end
        
    elseif ~isempty(strfind(current_line,'F Lower'))
        filter_info.f_lower=str2num(current_line(18:23));
        
        if length(current_line)==48 && strcmpi(current_line(47),'X')
            filter_info.iris_type='Round';
        end
        
    elseif ~isempty(strfind(current_line,'F Upper'))
        filter_info.f_upper=str2num(current_line(18:23));
        
        if length(current_line)==48 && strcmpi(current_line(47),'X')
            filter_info.iris_type='Square';
        end
    
    elseif ~isempty(strfind(current_line,'VSWR'))
        filter_info.vswr=str2num(current_line(18:23));
        filter_info.iris_thickness=str2num(current_line(46:end));
    elseif ~isempty(strfind(current_line,'Resonators'))
        filter_info.resonators=str2num(current_line(18:19));
        filter_info.waveguide_width=str2num(current_line(46:end));  
    elseif ~isempty(strfind(current_line,'Waveguide height'))
        filter_info.waveguide_height=str2num(current_line(46:end)); 
    elseif ~isempty(strfind(current_line,'Cav. reduction %'))
        filter_info.cav_reduction_percentage=str2num(current_line(46:51));
        filter_info.res_Q=str2num(current_line(71:end));
    elseif ~isempty(strfind(current_line,'Surface'))
        filter_info.surface=current_line(18:23);
        filter_info.loss_f0=str2num(current_line(71:end));
    elseif ~isempty(strfind(current_line,'UNITS'))
        filter_info.units.frequency=current_line(23:25);
        filter_info.units.length=current_line(38:39);
        ii=0; % Set ii=0 to exit while loop
    end
    
end

%% Get Cavity Lengths and Iris widths
cavity_lengths=[];
iris_widths=[];
cavity_screws=[];
iris_screws=[];
while current_line~=-1
    
    %% Get next line from file
    current_line=fgetl(fid);
    
    if ~isempty(strfind(current_line,'--- *   +   *     --'))
        iris_widths=[iris_widths;str2num(current_line(10:15))];
        iris_screws=[iris_screws;str2num(current_line(37:end))];
    elseif ~isempty(strfind(current_line,'*       +       * --'))
        cavity_lengths=[cavity_lengths;str2num(current_line(55:end))];
        cavity_screws=[cavity_screws;str2num(current_line(37:42))];
    end
    
end

% Move data to filter_info struct
filter_info.iris_widths=iris_widths;
filter_info.iris_screws=iris_screws;
filter_info.cavity_lengths=cavity_lengths;
filter_info.cavity_screws=cavity_screws;

%% Calculate input Cavity Dimensions
center_freq=filter_info.f_upper-...
    ((filter_info.f_upper-filter_info.f_lower)/2);
center_freqGuideLambda=1/sqrt((0.08472*center_freq)^2-...
    (1/(2*filter_info.waveguide_width))^2);
filter_info.input_cav_length=center_freqGuideLambda/4;

%% Close WEAFIL *.dat file
fclose(fid);