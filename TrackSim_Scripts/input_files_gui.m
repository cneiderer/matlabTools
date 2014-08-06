function varargout = input_files_gui(varargin)
% INPUT_FILES_GUI M-file for input_files_gui.fig
%      INPUT_FILES_GUI, by itself, creates a new INPUT_FILES_GUI or raises the existing
%      singleton*.
%
%      H = INPUT_FILES_GUI returns the handle to a new INPUT_FILES_GUI or the handle to
%      the existing singleton*.
%
%      INPUT_FILES_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INPUT_FILES_GUI.M with the given input arguments.
%
%      INPUT_FILES_GUI('Property','Value',...) creates a new INPUT_FILES_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before input_files_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to input_files_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help input_files_gui

% Last Modified by GUIDE v2.5 09-Feb-2009 16:26:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @input_files_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @input_files_gui_OutputFcn, ...
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


% --- Executes just before input_files_gui is made visible.
function input_files_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to input_files_gui (see VARARGIN)

% Choose default command line output for input_files_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes input_files_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = input_files_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in map_pb.
function map_pb_Callback(hObject, eventdata, handles)
% hObject    handle to map_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[map_rp map_dir] = uigetfile(fullfile(pwd,'Input_Files','Map_Saps.txt'),'Select MAP_SAP');

if ~isempty(map_rp)
    set(handles.map_loc_edit,'string',fullfile(map_dir, map_rp));
end

function map_loc_edit_Callback(hObject, eventdata, handles)
% hObject    handle to map_loc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of map_loc_edit as text
%        str2double(get(hObject,'String')) returns contents of map_loc_edit as a double


% --- Executes during object creation, after setting all properties.
function map_loc_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to map_loc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sys_pb.
function sys_pb_Callback(hObject, eventdata, handles)
% hObject    handle to sys_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[sys_rp sys_dir] = uigetfile(fullfile(pwd,'Input_Files','Sys_Saps.txt'),'Select SYS_SAP');

if ~isempty(sys_rp)
    set(handles.sys_loc_edit,'string',fullfile(sys_dir, sys_rp));
end

function sys_loc_edit_Callback(hObject, eventdata, handles)
% hObject    handle to sys_loc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sys_loc_edit as text
%        str2double(get(hObject,'String')) returns contents of sys_loc_edit as a double


% --- Executes during object creation, after setting all properties.
function sys_loc_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sys_loc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rl_pb.
function rl_pb_Callback(hObject, eventdata, handles)
% hObject    handle to rl_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[rl_rp rl_dir] = uigetfile(fullfile(pwd,'Input_Files','Radar_Setup.txt'),'Select Radar Setup File');

if ~isempty(rl_rp)
    set(handles.radar_loc_edit,'string',fullfile(rl_dir, rl_rp));
end


function radar_loc_edit_Callback(hObject, eventdata, handles)
% hObject    handle to radar_loc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radar_loc_edit as text
%        str2double(get(hObject,'String')) returns contents of radar_loc_edit as a double


% --- Executes during object creation, after setting all properties.
function radar_loc_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radar_loc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rd_pb.
function rd_pb_Callback(hObject, eventdata, handles)
% hObject    handle to rd_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[rl_rp rl_dir] = uigetfile(fullfile(pwd,'Input_Files','Radar_Defaults.txt'),'Select Radar Defaults File');

if ~isempty(rl_rp)
    set(handles.rd_loc_edit,'string',fullfile(rl_dir, rl_rp));
end


function rd_loc_edit_Callback(hObject, eventdata, handles)
% hObject    handle to rd_loc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rd_loc_edit as text
%        str2double(get(hObject,'String')) returns contents of rd_loc_edit as a double


% --- Executes during object creation, after setting all properties.
function rd_loc_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rd_loc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mp_pb.
function mp_pb_Callback(hObject, eventdata, handles)
% hObject    handle to mp_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[rl_rp rl_dir] = uigetfile(fullfile(pwd,'Input_Files','Mission_Profile.txt'),'Select Mission Profile File');

if ~isempty(rl_rp)
    set(handles.mp_loc_edit,'string',fullfile(rl_dir, rl_rp));
end

function mp_loc_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mp_loc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mp_loc_edit as text
%        str2double(get(hObject,'String')) returns contents of mp_loc_edit as a double


% --- Executes during object creation, after setting all properties.
function mp_loc_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mp_loc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_exit_btn.
function save_exit_btn_Callback(hObject, eventdata, handles)
% hObject    handle to save_exit_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(main_gui,'map_saps_loc',get(handles.map_loc_edit,'string'));
setappdata(main_gui,'sys_saps_loc',get(handles.sys_loc_edit,'string'));
setappdata(main_gui,'radar_setup_loc',get(handles.radar_loc_edit,'string'));
setappdata(main_gui,'radar_defaults_loc',get(handles.rd_loc_edit,'string'));
setappdata(main_gui,'mission_profile_loc',get(handles.mp_loc_edit,'string'));
setappdata(main_gui,'traj_loc',get(handles.traj_file_edit,'string'));

close(gcbf);

% --- Executes on button press in cancel_btn.
function cancel_btn_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;


% --- Executes on button press in traj_pb.
function traj_pb_Callback(hObject, eventdata, handles)
% hObject    handle to traj_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[rl_rp rl_dir] = uigetfile(fullfile(pwd,'Trajectory_Data','*.mat'),'Select Trajectory File');

if ~isempty(rl_rp)
    set(handles.traj_file_edit,'string',fullfile(rl_dir, rl_rp));
end

function traj_file_edit_Callback(hObject, eventdata, handles)
% hObject    handle to traj_file_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of traj_file_edit as text
%        str2double(get(hObject,'String')) returns contents of traj_file_edit as a double


% --- Executes during object creation, after setting all properties.
function traj_file_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to traj_file_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


