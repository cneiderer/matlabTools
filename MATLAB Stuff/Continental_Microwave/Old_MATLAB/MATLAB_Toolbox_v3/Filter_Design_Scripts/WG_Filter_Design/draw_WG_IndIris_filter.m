function [] = draw_WG_IndIris_filter(varargin)

% 
% draw_waveguide_indiris_filter.m
%
% Description:
%   Draws a waveguide filter design with irises to the symmetry point of 
%   the filter according to data from filter_info structure.
% 
% Inputs:
%   varargin{1} ->  filter_info structure 
%
% Outputs:
%   figure(1)   ->  WG Filter w/ Inductive Irises
%
% Author:
%   Curtis Neiderer, 3/20/2009
%
% Notes / Changes:
%   Version 1: 3/20/2009
%       Draws a simple model based on filter_info
%

%%
if nargin==2
    filter_info=varargin{1};
    modfile=varargin{2};
elseif nargin==1
    filter_info=varargin{1};
    modfile=['WG_3D_FilterModel_',datestr(now,30),'.fig'];
elseif nargin==0
    error('No input arguments')
elseif nargin==3
    load(varargin{3});
    modfile='WG_3D_FilterModel_Test.fig';
else
    error('Something weird happened!!!')
end

%% Find Symmetry Point
if mod(filter_info.resonators,2)==1
    SymType='odd';
    SymRes=ceil(filter_info.resonators/2);
    SymIris=SymRes-1;
    SymPoint=filter_info.cavity_screws(SymRes);
elseif mod(filter_info.resonators,2)==0
    SymType='even';
    SymRes=(filter_info.resonators/2);
    SymIris=SymRes+1;
    SymPoint=filter_info.iris_screws(SymIris);   
end

%% Object Coordinates
% Input Cavity Coordinates
obj_coord.input_coord=...
    struct('obj_name',[],'x',[],'y',[],'z',[],'dx',[],'dy',[],'dz',[]);
obj_coord.input_coord.obj_name='Input_Cavity';
obj_coord.input_coord.x=-filter_info.waveguide_width/2;
obj_coord.input_coord.y=-filter_info.input_cav_length;
obj_coord.input_coord.z=0;
obj_coord.input_coord.dx=filter_info.waveguide_width;
obj_coord.input_coord.dy=filter_info.input_cav_length;
obj_coord.input_coord.dz=filter_info.waveguide_height;

filter_pos=0;
% Calculate Cavity & Iris Coordinates
obj_coord.iris_coord=...
    struct('obj_name',[],'x',[],'y',[],'z',[],'dx',[],'dy',[],'dz',[]);
obj_coord.cav_coord=...
    struct('obj_name',[],'x',[],'y',[],'z',[],'dx',[],'dy',[],'dz',[]);
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

%% Format Figure
close all
WGF_fig=figure(1);
hold on;
% Figure Title
set(WGF_fig,'Name','WG Filter w/ Inductive Irises');
% Position
x0=200; dx=900;
y0=400; dy=400;
set(WGF_fig,'position',[x0,y0,dx,dy])
% Plot Axes Labels
xlabel('Filter Width [in]','FontWeight','bold');
ylabel('Filter Length [in]','FontWeight','bold');
zlabel('Filter Height [in]','FontWeight','bold');
% Plot Title 
title('Waveguide Filter Design w/ Inductive Irises',...
    'FontSize',14,'FontWeight','bold')
% Plot Viewpoint
xView=3*obj_coord.input_coord.dx;
yView=-4*obj_coord.input_coord.dy;
zView=3*obj_coord.input_coord.dz;
view([xView,yView,zView]);

%% Draw Objects
% Input Cavity
[vertices,faces]=createCube(...
    [obj_coord.input_coord.x,obj_coord.input_coord.y,obj_coord.input_coord.z],...
    [obj_coord.input_coord.dx,obj_coord.input_coord.dy,obj_coord.input_coord.dz]);
obj_handles.input.h=drawPolyhedron(vertices,faces,[0.21176,0.21176,0.21176],0.25);
hold on;
% Resonant Cavities
for jj=1:length(obj_coord.cav_coord)
    [vertices,faces]=createCube(...
        [obj_coord.cav_coord(jj).x,obj_coord.cav_coord(jj).y,obj_coord.cav_coord(jj).z],...
        [obj_coord.cav_coord(jj).dx,obj_coord.cav_coord(jj).dy,obj_coord.cav_coord(jj).dz]);
    obj_handles.cav(jj).h=drawPolyhedron(vertices,faces,[0.21176,0.21176,0.21176],0.5);
    hold on;
end
% Irises
for kk=1:length(obj_coord.iris_coord)
    [vertices,faces]=createCube(...
        [obj_coord.iris_coord(kk).x,obj_coord.iris_coord(kk).y,obj_coord.iris_coord(kk).z],...
        [obj_coord.iris_coord(kk).dx,obj_coord.iris_coord(kk).dy,obj_coord.iris_coord(kk).dz]);
    obj_handles.iris(kk).h=drawPolyhedron(vertices,faces,[0.21176,0.21176,0.21176],0.75);
    hold on;
end

saveas(WGF_fig,modfile,'fig');
hold off;

