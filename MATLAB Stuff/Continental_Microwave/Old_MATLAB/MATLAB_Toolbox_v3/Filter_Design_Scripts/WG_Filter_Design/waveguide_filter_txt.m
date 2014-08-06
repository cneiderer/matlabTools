function waveguide_filter_txt(varargin)

%
% waveguide_filter_txt.m
%
% Description:
%   Creates text file containing the filter design specs and calculated 
%   dimensions based on example 8.6 of Matthaei, Young & Jones.
%
% Inputs:
%   varargin{1} ->  filter_info struct containing design specs
%   varargin{2} ->  TXT_file
%
% Outputs:
%   filter_design text file
%
% Author:
%   Curtis Neiderer, 3/9/2009
%
% Notes / Changes:
%   Version 1: 3/9/2009
%

%% Assign Input Arguments
if nargin==2
    filter_info=varargin{1};
    TXT_file=varargin{2};
elseif nargin==1
    filter_info=varargin{1};
    TXT_file=fullfile('',['filter_',datestr(now,30),'.txt']);
elseif nargin==0
    error('No input arguments')
elseif nargin==3 
    load(varargin{3});
    TXT_file='WG_filter_test.txt';
else
    error('Something weird happened')
end

%% Find Symmetry Point
if mod(filter_info.resonators,2)==1
    SymType='odd';
    SymRes=ceil(filter_info.resonators/2);
    SymIris=SymRes;
    SymPoint=filter_info.cavity_screws(SymRes);
elseif mod(filter_info.resonators,2)==0
    SymType='even';
    SymRes=(filter_info.resonators/2);
    SymIris=SymRes+1;
    SymPoint=filter_info.iris_screws(SymIris);   
end

%% Object Coordinates
% Input Cavity Coordinates
obj_coord.input_coord=struct('obj_name',[],'x',[],'y',[],'z',[],'dx',[],'dy',[],'dz',[]);
obj_coord.input_coord.obj_name='Input Cav';
obj_coord.input_coord.x=-filter_info.waveguide_width/2;
obj_coord.input_coord.y=-filter_info.input_cav_length;
obj_coord.input_coord.z=0;
obj_coord.input_coord.dx=filter_info.waveguide_width;
obj_coord.input_coord.dy=filter_info.input_cav_length;
obj_coord.input_coord.dz=filter_info.waveguide_height;

filter_pos=0;
% Calculate Cavity & Iris Coordinates
obj_coord.iris_coord=struct('obj_name',[],'x',[],'y',[],'z',[],'dx',[],'dy',[],'dz',[]);
obj_coord.cav_coord=struct('obj_name',[],'x',[],'y',[],'z',[],'dx',[],'dy',[],'dz',[]);
if strcmpi(SymType,'odd') % Equal number of irises and cavities
    for ii=1:SymRes
        obj_coord.iris_coord(ii).obj_name=['Iris ',num2str(ii-1),',',num2str(ii)];
        obj_coord.iris_coord(ii).x=-filter_info.iris_widths(ii)/2;
        obj_coord.iris_coord(ii).y=filter_pos;
        obj_coord.iris_coord(ii).z=0;
        obj_coord.iris_coord(ii).dx=filter_info.iris_widths(ii);
        obj_coord.iris_coord(ii).dy=filter_info.iris_thickness;
        obj_coord.iris_coord(ii).dz=filter_info.waveguide_height;

        filter_pos=filter_pos+.04;
            
        obj_coord.cav_coord(ii).obj_name=['Cavity ',num2str(ii)];
        obj_coord.cav_coord(ii).x=-filter_info.waveguide_width/2;
        obj_coord.cav_coord(ii).y=filter_pos;
        obj_coord.cav_coord(ii).z=0;
        obj_coord.cav_coord(ii).dx=filter_info.waveguide_width;
        obj_coord.cav_coord(ii).dy=filter_info.cavity_lengths(ii);
        obj_coord.cav_coord(ii).dz=filter_info.waveguide_height;

        filter_pos=filter_pos+filter_info.cavity_lengths(ii);
    end
elseif strcmpi(SymType,'even') % One more iris than number of cavities
    for ii=1:SymIris
        obj_coord.iris_coord(ii).obj_name=['Iris ',num2str(ii-1),',',num2str(ii)];
        obj_coord.iris_coord(ii).x=-filter_info.iris_widths(ii)/2;
        obj_coord.iris_coord(ii).y=filter_pos;
        obj_coord.iris_coord(ii).z=0;
        obj_coord.iris_coord(ii).dx=filter_info.iris_widths(ii);
        obj_coord.iris_coord(ii).dy=filter_info.iris_thickness;
        obj_coord.iris_coord(ii).dz=filter_info.waveguide_height;

        filter_pos=filter_pos+.04;

        if ii<SymIris
            obj_coord.cav_coord(ii).obj_name=['Cavity ',num2str(ii)];
            obj_coord.cav_coord(ii).x=-filter_info.waveguide_width/2;
            obj_coord.cav_coord(ii).y=filter_pos;
            obj_coord.cav_coord(ii).z=0;
            obj_coord.cav_coord(ii).dx=filter_info.waveguide_width;
            obj_coord.cav_coord(ii).dy=filter_info.cavity_lengths(ii);
            obj_coord.cav_coord(ii).dz=filter_info.waveguide_height;

            filter_pos=filter_pos+filter_info.cavity_lengths(ii);
        end
    end
end

% Open text file for editing
[fid,message]=fopen(TXT_file,'wt+');

% Add file name and date created
fprintf(fid,'\n');
fprintf(fid,'File Name: %s \n',TXT_file);
fprintf(fid,'Date Created: %s \n',datestr(now,1));

fprintf(fid,'\n');
fprintf(fid,'=========================\n');
fprintf(fid,'\n');

% Add Filter Design Specs
fprintf(fid,'Filter Design Specs: \n');
fprintf(fid,'  filter order = %d \n',filter_info.resonators);
fprintf(fid,'  passband ripple = %f dB \n',filter_info.passband_ripple);
fprintf(fid,'  center frequency = %f GHz \n',filter_info.center_freq);
fprintf(fid,'  lower corner freq = %f GHz \n',filter_info.f_lower);
fprintf(fid,'  upper corner freq = %f GHz \n',filter_info.f_upper);
fprintf(fid,'  desired attenuation = %f GHz \n',...
    filter_info.desired_attenuation);
fprintf(fid,'  low rejection frequency = %f GHz \n',...
    filter_info.lo_att_freq);
fprintf(fid,'  high rejection frequency = %f GHz \n',...
    filter_info.hi_att_freq);
fprintf(fid,'  waveguide width: a = %f in \n',filter_info.waveguide_width);
fprintf(fid,'  waveguide height: b = %f in \n',...
    filter_info.waveguide_height);
fprintf(fid,'  iris thickness = %f in \n',filter_info.iris_thickness);
fprintf(fid,'  filter length = %f in \n',SymPoint*2);

fprintf(fid,'\n');

% Add Cavity Lengths
fprintf(fid,'Cavity Lengths [in]: \n');
for yy=1:length(filter_info.cavity_lengths)
    fprintf(fid,'  Cavity %d = \t %f \n',yy,filter_info.cavity_lengths(yy));
end

fprintf(fid,'\n');

% Add Iris Widths
fprintf(fid,'Iris Widths [in]: \n');
for zz=1:length(filter_info.iris_widths)
    fprintf(fid,'  Iris %d,%d = \t %f \n',(zz-1),zz,...
        filter_info.iris_widths(zz));
end

fprintf(fid,'\n');

% Add Symmetry Details
fprintf(fid,'Symmetry Details: \n');
fprintf(fid,'  SymType = %s \n', SymType);
fprintf(fid,'  SymPoint = (%f,%f,%f) \n',0,SymPoint,0);
if strcmpi(SymType,'even')
    fprintf(fid,'  SymIris = %d,%d \n', (SymIris-1),SymIris);
elseif strcmpi(SymType,'odd')
    fprintf(fid,'  SymIris = %d,%d \n', SymIris,(SymIris+1));
end
fprintf(fid,'  SymCavity = %d \n', SymRes);

fprintf(fid,'\n');

% Add HFSS Object Coordinates
fprintf(fid,'HFSS Object Coordinates [in]: \n');
obj_types=fields(obj_coord);
for xx=1:length(obj_types)
    eval(['current_type=obj_coord.',obj_types{xx},';']);
    for mm=1:length(current_type) 
        fprintf(fid, '  %s: \t x=%f, y=%f, z=%f, dx=%f, dy=%f, dz=%f \n',...
            current_type(mm).obj_name,...
            current_type(mm).x,...
            current_type(mm).y,...
            current_type(mm).z,...
            current_type(mm).dx,...
            current_type(mm).dy,...
            current_type(mm).dz);          
    end 
end

% Close text file
fclose(fid);