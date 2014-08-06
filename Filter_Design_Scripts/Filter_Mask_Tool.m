function varargout = Filter_Mask_Tool(varargin)
% FILTER_MASK_TOOL M-file for Filter_Mask_Tool.fig
%      FILTER_MASK_TOOL, by itself, creates a new FILTER_MASK_TOOL or raises the existing
%      singleton*.
%
%      H = FILTER_MASK_TOOL returns the handle to a new FILTER_MASK_TOOL or the handle to
%      the existing singleton*.
%
%      FILTER_MASK_TOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILTER_MASK_TOOL.M with the given input arguments.
%
%      FILTER_MASK_TOOL('Property','Value',...) creates a new FILTER_MASK_TOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Filter_Mask_Tool_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Filter_Mask_Tool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help Filter_Mask_Tool

% Last Modified by GUIDE v2.5 15-May-2009 14:46:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Filter_Mask_Tool_OpeningFcn, ...
                   'gui_OutputFcn',  @Filter_Mask_Tool_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Filter_Mask_Tool is made visible.
function Filter_Mask_Tool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Filter_Mask_Tool (see VARARGIN)

% Choose default command line output for Filter_Mask_Tool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Filter_Mask_Tool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Filter_Mask_Tool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

handles.attenuation_pts={};


function lo_corner_Callback(hObject, eventdata, handles)
% hObject    handle to lo_corner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lo_corner as text
%        str2double(get(hObject,'String')) returns contents of lo_corner as a double


% --- Executes during object creation, after setting all properties.
function lo_corner_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lo_corner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function hi_corner_Callback(hObject, eventdata, handles)
% hObject    handle to hi_corner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hi_corner as text
%        str2double(get(hObject,'String')) returns contents of hi_corner as a double


% --- Executes during object creation, after setting all properties.
function hi_corner_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hi_corner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function atten_freq_Callback(hObject, eventdata, handles)
% hObject    handle to atten_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of atten_freq as text
%        str2double(get(hObject,'String')) returns contents of atten_freq as a double


% --- Executes during object creation, after setting all properties.
function atten_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to atten_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function atten_level_Callback(hObject, eventdata, handles)
% hObject    handle to atten_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of atten_level as text
%        str2double(get(hObject,'String')) returns contents of atten_level as a double



% --- Executes during object creation, after setting all properties.
function atten_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to atten_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in atten_pt_list.
function atten_pt_list_Callback(hObject, eventdata, handles)
% hObject    handle to atten_pt_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns atten_pt_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from atten_pt_list


% --- Executes during object creation, after setting all properties.
function atten_pt_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to atten_pt_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Ripple_Callback(hObject, eventdata, handles)
% hObject    handle to Ripple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ripple as text
%        str2double(get(hObject,'String')) returns contents of Ripple as a double


% --- Executes during object creation, after setting all properties.
function Ripple_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ripple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in add_pt.
function add_pt_Callback(hObject, eventdata, handles)
% hObject    handle to add_pt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

atten_freq=str2double(get(handles.atten_freq,'String'));
atten_freq=round2(atten_freq,4);
atten_level=str2double(get(handles.atten_level,'String'));
atten_level=round2(atten_level,2);

new_pt={[num2str(atten_freq),'     |     ',num2str(atten_level)]};
current_pt_list=get(handles.atten_pt_list,'String');
updated_pt_list=[new_pt;current_pt_list];
set(handles.atten_pt_list,'String',updated_pt_list)

test=1;

% --- Executes on button press in delete_pt.
function delete_pt_Callback(hObject, eventdata, handles)
% hObject    handle to delete_pt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

current_pt_list=get(handles.atten_pt_list,'String');
selected_entry=get(handles.atten_pt_list,'Value');

if (selected_entry-1)==0
    updated_entry=1;
else
    updated_entry=selected_entry-1;
end

updated_pt_list={};
for ii=1:length(current_pt_list)
    if ii~=selected_entry;
        updated_pt_list=[updated_pt_list;current_pt_list(ii)];
    end
end
set(handles.atten_pt_list,'Value',updated_entry);
set(handles.atten_pt_list,'string',updated_pt_list);

test=1;


% --- Executes on button press in plot_filter_mask.
function plot_filter_mask_Callback(hObject, eventdata, handles)
% hObject    handle to plot_filter_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

f_lo=str2double(get(handles.lo_corner,'String'));
f_hi=str2double(get(handles.hi_corner,'String'));
ripple=str2double(get(handles.ripple,'String'));

atten_pt_list=get(handles.atten_pt_list,'String');
max_rej=0; 
min_freq=f_lo; 
max_freq=f_hi; 
stopband_list=[];
for ii=1:length(atten_pt_list)
    current_pt=atten_pt_list{ii};
    divider_indxs=regexp(current_pt,'\s|\s');
    rej_freq=str2double(current_pt(1:(divider_indxs(1)-1)));
    rej_level=str2double(current_pt((divider_indxs(end)+1):end));    
    
    if rej_level > max_rej
        max_rej=rej_level;
    end
    
    if rej_freq < min_freq
        min_freq=rej_freq;
    elseif rej_freq > max_freq
        max_freq=rej_freq;
    end
    
    stopband_list=[stopband_list;rej_freq,rej_level];
    
end

plot_mask_specs(f_lo,f_hi,ripple,stopband_list,min_freq,max_freq,max_rej,handles);

function ripple_Callback(hObject, eventdata, handles)
% hObject    handle to ripple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ripple as text
%        str2double(get(hObject,'String')) returns contents of ripple as a double


% --- Executes during object creation, after setting all properties.
function ripple_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ripple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


%%%%% ---------- %% Sub-Functions %% ---------- %%%%%
function [h]=plot_mask_specs(f_lo,f_hi,ripple,stopband_list,...
    min_freq,max_freq,max_rej,handles);

pass_level=[f_lo,f_hi];
lo_edge=[ripple,max_rej];
hi_edge=[ripple,max_rej];

h=figure(1);
% h=handles.plot_filter_mask;

hold on;

plot(pass_level,repmat(ripple,1,length(pass_level)));
plot(repmat(f_lo,1,length(lo_edge)),lo_edge);
plot(repmat(f_hi,1,length(hi_edge)),hi_edge);

hold on;

for ii=1:length(stopband_list)
    if stopband_list(ii,1) < f_lo
        stop_level=[(min_freq*.9),stopband_list(ii,1)];
        edge=0:stopband_list(ii,2);
    elseif stopband_list(ii,1) > f_hi
        stop_level=[stopband_list(ii,1),(max_freq*1.1)];
        edge=0:stopband_list(ii,2);
    else
        errordlg('You cannot place rejection points in your passband')
    end

    plot(stop_level,repmat(stopband_list(ii,2),1,length(stop_level)));
    plot(repmat(stopband_list(ii,1),1,length(edge)),edge);
end

xlim([min_freq*.9,max_freq*1.1]);
ylim([0,max_rej]);

xlabel('frequency [GHz]');
ylabel('attenuation [dB]');


% --- Executes on mouse press over axes background.
function filter_mask_plot_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to filter_mask_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function filter_mask_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filter_mask_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate filter_mask_plot


