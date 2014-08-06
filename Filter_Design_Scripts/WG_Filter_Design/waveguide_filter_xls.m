function waveguide_filter_xls(varargin)

%
% waveguide_filter_xls.m
%
% Description:
%   Creates excel file containing the filter design specs and calculated 
%   dimensions based on example 8.6 of Matthaei, Young & Jones.
%
% Inputs:
%   varargin{1} ->  filter_info struct containing design specs
%   varargin{2} ->  HFSS_proj name
%
% Outputs:
%   excel file containing detailed filter design specs
%
% Author:
%   Curtis Neiderer, 3/9/2009
%
% Notes / Changes:
%   Version 1: 3/9/2009
%
%   Note 1: 3/9/2009
%   Need to double-check the xls.SaveAs code to figure out why my workbooks
%   aren't being saved to the proper file name.
%

%% Assign Input Arguments
if nargin==2
    filter_info=varargin{1};
    XLS_file=varargin{2};
elseif nargin==1
    filter_info=varargin{1};
    XLS_file=fullfile('',['combline_',datestr(now,30),'.txt']);
elseif nargin==0
    error('No input arguments')
elseif nargin==3 
    load(varargin{3});
    XLS_file='WG_filter_test.txt';
else
    error('Something weird happened')
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
obj_coord.input_coord=struct('obj_name',[],'x',[],'y',[],'z',[],'dx',[],'dy',[],'dz',[]);
obj_coord.input_coord.obj_name='Input_Cavity';
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

%% Start excel and keep visible
xls=actxserver('Excel.Application');
xls.Visible=1; 

%% Add workbook
xlsWorkbook=xlsAddNewWorkbook(xls,XLS_file);

%% Activate sheet1
xlsSheet=xlsWorkbook.Worksheets.Item(1);

%% File Info
% xlsSetCellVal(value,sheet,col,row)
xlsSetCellVal('File Name:',xlsSheet,1,1);
xlsSetCellVal(XLS_file,xlsSheet,2,1);
xlsSetCellVal('Date Created:',xlsSheet,1,2);
xlsSetCellVal(datestr(now,31),xlsSheet,2,2);

%% Filter Specs
xlsSetCellVal('Filter Design Specs:',xlsSheet,1,4);
xlsSetCellVal('filter order',xlsSheet,2,5);
xlsSetCellVal(filter_info.resonators,xlsSheet,3,5);
xlsSetCellVal('passband ripple [dB]',xlsSheet,2,6);
xlsSetCellVal(filter_info.passband_ripple,xlsSheet,3,6);
xlsSetCellVal('center freq [GHz]',xlsSheet,2,7);
xlsSetCellVal(filter_info.center_freq,xlsSheet,3,7);
xlsSetCellVal('lo corner freq [GHz]',xlsSheet,2,8);
xlsSetCellVal(filter_info.f_lower,xlsSheet,3,8);
xlsSetCellVal('hi corner freq [GHz]',xlsSheet,2,9);
xlsSetCellVal(filter_info.f_upper,xlsSheet,3,9);
xlsSetCellVal('desired attenuation [GHz]',xlsSheet,2,10);
xlsSetCellVal(filter_info.desired_attenuation,xlsSheet,3,10);
xlsSetCellVal('lo rejection freq [GHz]',xlsSheet,2,11);
xlsSetCellVal(filter_info.lo_att_freq,xlsSheet,3,11);
xlsSetCellVal('hi rejection freq [GHz]',xlsSheet,2,12);
xlsSetCellVal(filter_info.hi_att_freq,xlsSheet,3,12);
xlsSetCellVal('waveguide width [GHz]',xlsSheet,2,13);
xlsSetCellVal(filter_info.waveguide_width,xlsSheet,3,13);
xlsSetCellVal('waveguide_height [GHz]',xlsSheet,2,14);
xlsSetCellVal(filter_info.waveguide_height,xlsSheet,3,14);
xlsSetCellVal('iris thickness [GHz]',xlsSheet,2,15);
xlsSetCellVal(filter_info.iris_thickness,xlsSheet,3,15);
xlsSetCellVal('filter_length [in]',xlsSheet,2,16);
xlsSetCellVal(SymPoint*2,xlsSheet,3,16)

%% Cavity Lengths
xlsSetCellVal('Cavity Lengths [in]:',xlsSheet,1,18)
cur_line=19;
for ii=1:length(filter_info.cavity_lengths)
    cur_line=cur_line+1;
    xlsSetCellVal(['Cavity ',num2str(ii)],xlsSheet,2,cur_line);
    xlsSetCellVal(filter_info.cavity_lengths(ii),xlsSheet,3,cur_line);
end

%% Iris Widths
cur_line=cur_line+2;
xlsSetCellVal('Iris Widths [in]:',xlsSheet,1,cur_line);
for jj=1:length(filter_info.iris_widths)
    cur_line=cur_line+1;
    xlsSetCellVal(['Iris ',num2str(jj-1),',',num2str(jj)],xlsSheet,2,cur_line);
    xlsSetCellVal(filter_info.iris_widths(jj),xlsSheet,3,cur_line);
end

%% Symmetry Details
cur_line=cur_line+2;
xlsSetCellVal('Symmetry Details:',xlsSheet,1,cur_line);
xlsSetCellVal('SymType',xlsSheet,2,cur_line+1);
xlsSetCellVal(SymType,xlsSheet,3,cur_line+1);
xlsSetCellVal('SymPoint',xlsSheet,2,cur_line+2);
xlsSetCellVal(SymPoint,xlsSheet,3,cur_line+2);
if strcmpi(SymType,'even')
    xlsSetCellVal('SymIris',xlsSheet,2,cur_line+3);
    xlsSetCellVal([num2str(SymIris-1),',',num2str(SymIris)],xlsSheet,3,cur_line+3);
elseif strcmpi(SymType,'odd')
    xlsSetCellVal('SymIris',xlsSheet,2,cur_line+3);
    xlsSetCellVal([num2str(SymIris),',',num2str(SymIris+1)],xlsSheet,3,cur_line+3);
end
xlsSetCellVal('SymCav',xlsSheet,2,cur_line+4);
xlsSetCellVal(SymRes,xlsSheet,3,cur_line+4);

%% HFSS Coordinates
% Column Header
cur_line=cur_line+6;
xlsSetCellVal('HFSS Coordinates [in]:',xlsSheet,1,cur_line);
xlsSetCellVal('x',xlsSheet,3,cur_line+1);
xlsSetCellVal('y',xlsSheet,4,cur_line+1);
xlsSetCellVal('z',xlsSheet,5,cur_line+1);
xlsSetCellVal('dx',xlsSheet,6,cur_line+1);
xlsSetCellVal('dy',xlsSheet,7,cur_line+1);
xlsSetCellVal('dz',xlsSheet,8,cur_line+1);
% Data
cur_line=cur_line+1;
obj_types=fields(obj_coord);
for xx=1:length(obj_types)
    eval(['current_type=obj_coord.',obj_types{xx},';']);
    for mm=1:length(current_type)
        cur_line=cur_line+1;
        xlsSetCellVal(current_type(mm).obj_name,xlsSheet,2,cur_line);
        xlsSetCellVal(current_type(mm).x,xlsSheet,3,cur_line);
        xlsSetCellVal(current_type(mm).y,xlsSheet,4,cur_line);
        xlsSetCellVal(current_type(mm).z,xlsSheet,5,cur_line);
        xlsSetCellVal(current_type(mm).dx,xlsSheet,6,cur_line);
        xlsSetCellVal(current_type(mm).dy,xlsSheet,7,cur_line);
        xlsSetCellVal(current_type(mm).dz,xlsSheet,8,cur_line);
    end
end

%% Save and close excel
xlsWorkbook.Save;
xlsWorkbook.Close;
xls.Quit;
xls.delete;

