function [filter_info] = parseCLD(fid)

%
% parseCLD.m
%
% Version 1: 2/12/2009
%   Supports lumped loaded CLDs only
% Version 2: 3/4/2009
%   Supports lumped, resonator, and cover loaded CLDs
%
% Description:
%   Pulls filter design specs from WEAFIL CLD data file and stores them
%   into filter_info structure.
%
% Inputs:
%   fid             ->  WEAFIL CDL file identifier
%
% Outputs:
%   filter_info     ->  structure containing filter design specs
%
% Author:
%   Curtis Neiderer, 2/12/2009
%
% Notes / Changes:
%

%% Get Design Inputs
ii=1;
filter_info=struct;
while ii

    %% Get next line from file
    current_line=fgetl(fid);

    if ~isempty(strfind(current_line,'Read file'))
        filter_info.read_file=current_line(18:23);
        
        % Resonator & Cover loading
        if ~isempty(strfind(current_line,'Reson. I.D.'))
            filter_info.res_innerDiameter=str2num(current_line(71:end));
        end
        
    elseif ~isempty(strfind(current_line,'Outfile'))
        filter_info.outfile=current_line(18:23);
        
        if strcmpi(current_line(49),'X')
            filter_info.load_type='Lumped';
        end
        
        % Cover loading
        if ~isempty(strfind(current_line,'Cover dia.'))
            filter_info.cover_diameter=str2num(current_line(71:end));
        % Resonator loading
        elseif ~isempty(strfind(current_line,'Fixed dia.'))
            filter_info.fixed_diameter=str2num(current_line(71:end));
        end
        
    elseif ~isempty(strfind(current_line,'F Lower'))
        filter_info.f_lower=str2num(current_line(18:23));
        filter_info.screw_dia=str2num(current_line(71:end));
        
        if strcmpi(current_line(45),'X')
            filter_info.load_type='Resonator';
        end
        
    elseif ~isempty(strfind(current_line,'F Upper'))
        filter_info.f_upper=str2num(current_line(18:23));
                
        if strcmpi(current_line(45),'X')
            filter_info.load_type='Cover';
        end
        
        % Lumped & Resonator loading
        if ~isempty(strfind(current_line,'Reson. Gap'))
            filter_info.resonator_gap=str2num(current_line(71:end)); 
        end
        
    elseif ~isempty(strfind(current_line,'VSWR'))
        filter_info.vswr=str2num(current_line(18:23));
        filter_info.GPS=str2num(current_line(47:end));
    elseif ~isempty(strfind(current_line,'Resonators'))
        filter_info.resonators=str2num(current_line(18:19));
        filter_info.res_diameter=str2num(current_line(47:end));
    elseif ~isempty(strfind(current_line,'Resonator len.'))
        filter_info.res_length=str2num(current_line(47:53));
        filter_info.connector_K=str2num(current_line(71:end));
    elseif ~isempty(strfind(current_line,'Tap line dia.'))
        filter_info.tapline_dia=str2num(current_line(47:53));
        filter_info.resonator_Q=str2num(current_line(71:end));
    elseif ~isempty(strfind(current_line,'Surface'))
        filter_info.surface=current_line(18:23);
        filter_info.tapline_len=str2num(current_line(47:53));
        filter_info.loss_f0=str2num(current_line(71:end));
    elseif ~isempty(strfind(current_line,'UNITS:'))
        filter_info.units.frequency=current_line(23:25);
        filter_info.units.length=current_line(38:39);
    elseif ~isempty(strfind(current_line,...    % Cover loading only
            '--------****************** ------------'))
        filter_info.cover_thickness=(str2num(current_line(45:end)))-...
            filter_info.res_length;
    elseif ~isempty(strfind(current_line,...    % Res loading only
            '*  ------- * ******** * ---------*-----')) && ...
            strcmpi(filter_info.load_type,'Resonator')
        filter_info.loadcolumn_pos=str2num(current_line(46:end));
    elseif ~isempty(strfind(current_line,...    % Cover loading only
            '    Resonator physical length =')) &&...
            strcmpi(filter_info.load_type,'Cover')
        filter_info.res_PhysLength=str2num(current_line(33:39));
    elseif ~isempty(strfind(current_line,'Input tap location'))
        filter_info.tap_location=str2num(current_line(57:63));
        ii=0; % Set ii=0 to exit while loop
    end

end


%% Get Resonator and Coupling Locations
coupling_adj_loc=[];
res_locations=[];
res_gap_spacing=[];
screw_gaps=[];
while current_line~=-1
    
    %% Get next line from file
    current_line=fgetl(fid);
    
    if ~isempty(strfind(current_line,'-----*     -     *'))
        coupling_adj_loc=[coupling_adj_loc,str2num(current_line(7:12))];
        res_gap_spacing=[res_gap_spacing,str2num(current_line(50:end))];
    elseif ~isempty(strfind(current_line,'*     +     *-----'))
        res_locations=[res_locations,str2num(current_line(38:43))];
        screw_gaps=[screw_gaps,str2num(current_line(62:end))];
    elseif ~isempty(strfind(current_line,'     *************-----'))
        filter_info.filter_length=str2num(current_line(38:43));
        jj=0; % Set jj=0 to exit while loop
    end

end

% Move data to filter_info struct
filter_info.coupling_loc=coupling_adj_loc';
filter_info.resonator_loc=res_locations';
filter_info.res_spacing=res_gap_spacing';
filter_info.tuning_gaps=screw_gaps';

% Close WEAFIL *.dat file
fclose(fid);

