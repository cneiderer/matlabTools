function varargout = MMsimulator_tool(varargin)
%MMSIMULATOR_TOOL M-file for MMsimulator_tool.fig
%      MMSIMULATOR_TOOL, by itself, creates a new MMSIMULATOR_TOOL or raises the existing
%      singleton*.
%
%      H = MMSIMULATOR_TOOL returns the handle to a new MMSIMULATOR_TOOL or the handle to
%      the existing singleton*.
%
%      MMSIMULATOR_TOOL('Property','Value',...) creates a new MMSIMULATOR_TOOL using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to MMsimulator_tool_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MMSIMULATOR_TOOL('CALLBACK') and MMSIMULATOR_TOOL('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MMSIMULATOR_TOOL.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MMsimulator_tool

% Last Modified by GUIDE v2.5 30-Apr-2009 08:32:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MMsimulator_tool_OpeningFcn, ...
                   'gui_OutputFcn',  @MMsimulator_tool_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before MMsimulator_tool is made visible.
function MMsimulator_tool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for MMsimulator_tool
handles.output = hObject;


all_runs=dir('D:\Documents and Settings\clarkss\My Documents\Raytheon\MATLAB\TrackSim\MMsim_output');
set(handles.run_list,'String',{all_runs(3:end).name});

set(handles.plot_resid_acc,'Enable','off');
set(handles.plot_ruv_resid,'Enable','off');
set(handles.plot_score,'Enable','off');
set(handles.plot_trk_rel_ref,'Enable','off');




% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MMsimulator_tool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MMsimulator_tool_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_run.
function load_run_Callback(hObject, eventdata, handles)
% hObject    handle to load_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
all_runs=get(handles.run_list,'String');
sel_run=all_runs{get(handles.run_list,'Value')};
run_number=get(handles.mc_run_number,'Value');
load(fullfile('D:\Documents and Settings\clarkss\My Documents\Raytheon\MATLAB\TrackSim\MMsim_output',sel_run,strcat('run_',num2str(run_number),'_out.mat')));
handles.constants=constants;
handles.radar=radar; 
handles.truth =truth;
handles.trackdata=trackdata; 
handles.Tlower=Tlower; 
handles.Tupper=Tupper;
set(handles.load_status,'String',strcat(sel_run,'_Run_',num2str(run_number),' Loaded'));


set(handles.plot_resid_acc,'Enable','on');
set(handles.plot_ruv_resid,'Enable','on');
set(handles.plot_score,'Enable','on');
set(handles.plot_trk_rel_ref,'Enable','on');



guidata(hObject, handles);



% --- Executes on selection change in run_list.
function run_list_Callback(hObject, eventdata, handles)
% hObject    handle to run_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns run_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from run_list
all_runs=get(hObject,'String');
sel_run=all_runs{get(hObject,'Value')};
set(handles.mc_run_number,'String',1:str2num(sel_run(strfind(sel_run,'_')+1:end)));
set(handles.mc_run_number','Value',1);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function run_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to run_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mc_run_number.
function mc_run_number_Callback(hObject, eventdata, handles)
% hObject    handle to mc_run_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns mc_run_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mc_run_number


% --- Executes during object creation, after setting all properties.
function mc_run_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mc_run_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plot_trk_rel_ref.
function plot_trk_rel_ref_Callback(hObject, eventdata, handles)
% hObject    handle to plot_trk_rel_ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_trk_rel_ref2(handles.trackdata,handles.truth,handles.radar);


% --- Executes on button press in plot_resid_acc.
function plot_resid_acc_Callback(hObject, eventdata, handles)
% hObject    handle to plot_resid_acc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_residual_acceleration(handles.truth,handles.trackdata,handles.radar,handles.constants);


% --- Executes on button press in plot_score.
function plot_score_Callback(hObject, eventdata, handles)
% hObject    handle to plot_score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_amm_score(handles.trackdata,handles.Tupper,handles.Tlower);


% --- Executes on button press in plot_ruv_resid.
function plot_ruv_resid_Callback(hObject, eventdata, handles)
% hObject    handle to plot_ruv_resid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_ruv_residuals(handles.trackdata);

