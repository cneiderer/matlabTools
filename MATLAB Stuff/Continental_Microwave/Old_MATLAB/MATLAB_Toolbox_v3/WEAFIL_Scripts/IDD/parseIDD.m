function [filter_info]=parseIDD(varargin)

%
% parseIDD.m
%
% Description:
%   Pulls filter design specs from WEAFIL IDD data file and stores them
%   into filter_info structure.
% 
% Inputs:
%   fid             ->  WEAFIL CDL file identifier
%
% Outputs:
%   filter_info     ->  structure containing filter design specs
%
% Author:
%   Curtis Neiderer, xx/xx/2009
%
% Notes / Changes:
%   Version 1: xx/xx/2009
%       Supports tapped input designs with parallel-plate, resonator, and
%       cover loading.
%

%% Get Design Inputs
ii=1;
filter_info=struct;
while ii

    %% Get next line from file
    current_line=fgetl(fid);

    if ~isempty(strfind(current_line,'Read file'))
        if isempty(strfind(current_line,...
                'Tapped Feed         X'))
            disp('Input type is not "Tapped", therefore not supported.')
            break;
        end
        filter_info.read_file=current_line(18:23);
        filter_info.res_gap=str2num(current_line(71:76));
    elseif ~isempty(strfind(current_line,'Outfile'))
        filter_info.out_file=current_line(18:23);
        if ~isempty(strfind(current_line,...
                'Lumped cap.   X'))
            filter_info.load_type='Lumped';
        end
    elseif ~isempty(strfind(current_line,'F Lower'))
        filter_info.F_Lower=str2num(current_line(18:23));
        if ~isempty(strfind(current_line,...
                'Reson. cap.   X'))
            filter_info.load_type='Resonator';
        end
    elseif ~isempty(strfind(current_line,'F Upper'))
        filter_info.F_Upper=str2num(current_line(18:23));
        if ~isempty(strfind(current_line,...
                'Cover cap.     X'))
            filter_info.load_type='Cover';
        end
    elseif ~isempty(strfind(current_line,'VSWR'))
        filter_info.VSWR=str2num(current_line(18:23));
        filter_info.res_diameter=str2num(current_line(45:52));
    elseif ~isempty(strfind(current_line,'Resonators'))
        filter_info.num_res=str2num(current_line(18:23));
        filter_info.tap_diameter=str2num(current_line(45:52));
    elseif ~isempty(strfind(current_line,'Tap line len.'))
        filter_info.tap_length=str2num(current_line(45:52));
        filter_info.connectorK=str2num(current_line(71:76));
    elseif ~isempty(strfind(current_line,'Die. Supports'))
        filter_info.die_supports=current_line(47);
        filter_info.resonatorQ=str2num(current_line(71:76));
    elseif ~isempty(strfind(current_line,'Surface'))
        filter_info.surface=current_line(18:23);
        filter_info.F0_loss=str2num(current_line(71:76));
    elseif ~isempty(strfind(current_line,'UNITS:'))
        filter_info.units.freq='GHz';
        filter_info.units.length='in';
    end

end

%% Get Resonator and Coupling Locations
short_res=[]; open_res=[];
coupling_loc=[];
res_gap_spacing=[];
jj=1;
while jj
    
    %% Get next line from file
    current_line=fgetl(fid);
    
    if ~isempty(strfind(current_line,'*     x     *-----'))
        short_res=[short_res;str2num(current_line(38:43))];
    elseif ~isempty(strfind(current_line,'*     o     *-----'))
        open_res=[open_res;str2num(current_line(38:43))];
    elseif ~isempty(strfind(current_line,'-----*     -     *'))
        coupling_loc=[coupling_loc;str2num(current_line(8:13))];
    elseif ~isempty(strfind(current_line,'-----*     -     *'))
        res_gap_spacing=[res_gap_spacing;str2num(current_line(51:56))];
    elseif ~isempty(strfind(current_line,'*************-----'))
        filter_info.filter_length=str2num(current_line(:));
        jj=0;
    end

end

% Move data to filter_info struct
filter_info.Coupling=coupling_loc;
filter_info.res_loc.short_res=short_res;
filter_info.res_loc.open_res=open_res;
filter_info.res_gap_spacing=res_gap_spacing;

%% In/Out Details
while current_line~=-1
    
    %% Get next line from file
    current_line=fgetl(fid);
    
    if ~isempty(strfind(current_line,...
            '                   **************************** /------------')) % Lumped
        filter_info.filter_height=str2num(current_line(64:69));
    elseif ~isempty(strfind(current_line,...
            '*****************************/------')) % Cover
        filter_info.filter_height=str2num(current_line(57:62));
    elseif ~isempty(strfind(current_line,...
            '                   *****************************/------')) % Resonator
        filter_info.filter_height=str2num(current_line(50:55));
    elseif ~isempty(strfind(current_line,...
            '*     *******------*-----*---/------------')) % Lumped
        filter_info.inputRes_length=str2num(current_line(64:69));
    elseif ~isempty(strfind(current_line,...
            '*     **{ }**-----*-----*----/------')) % Resonator
        filter_info.inputRes_length=str2num(current_line(:));
    elseif ~isempty(strfind(current_line,...
            '*     * {_}_*_____*_____* ___/______')) % Resonator  
    elseif ~isempty(strfind(current_line,...
            '* ******* *---------------------')) % Cover
        filter_info.Cover_thickness=str2num(current_line(:));
    elseif ~isempty(strfind(current_line,...
            '***** *     * **************/-------')) % Cover
        filter_info.filter_height=str2num(current_line(:));
        filter_info.Cover_thickness=filter_info.Cover_thickness-...
            filter_info.filter_height;
    elseif ~isempty(strfind(current_line,'IN/OUT'))
        for kk=1:4
            current_line=fgetl(fid);
            if kk==4 
                filter_info.tap_loc=str2num(current_line(9:15));
            end
        end
    elseif ~isempty(strfind(current_line,...
            '|        *     *     *      *******---/-------------'))
        filter_info.innerRes_length=...
            filter_info.filter_height-str2num(current_line(64:69));
    elseif ~isempty(strfind(current_line,...
            '|       *     *     *     *******    /------')) % Resonator
        
    elseif ~isempty(strfind(current_line,...
            '|        *     *     *    *******    /-------')) % Cover
        
    elseif ~isempty(strfind(current_line,...
            'The diameter of the hole in the tapped resonator =')) % Resonator
        
    end
    
end

% Close WEAFIL *.dat file
fclose(fid);