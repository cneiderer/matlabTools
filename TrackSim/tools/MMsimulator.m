function varargout = MMsimulator(varargin)
%MMSIM M-file for MMsim.fig
%      MMSIM, by itself, creates a new MMSIM or raises the existing
%      singleton*.
%
%      H = MMSIM returns the handle to a new MMSIM or the handle to
%      the existing singleton*.
%
%      MMSIM('Property','Value',...) creates a new MMSIM using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to MMsim_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MMSIM('CALLBACK') and MMSIM('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MMSIM.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MMsim

% Last Modified by GUIDE v2.5 29-Apr-2009 17:03:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MMsim_OpeningFcn, ...
                   'gui_OutputFcn',  @MMsim_OutputFcn, ...
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


% --- Executes just before MMsim is made visible.
function MMsim_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for MMsim
handles.output = hObject;

trj_dir='D:\Documents and Settings\clarkss\My Documents\Raytheon\MATLAB\TrackSim\Trajectory_Data';
trj=dir(fullfile(trj_dir,'*.mat'));

set(handles.trjfiles,'String',{trj.name});
handles.trjdir=trj;



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MMsim wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MMsim_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in run_pb.
function run_pb_Callback(hObject, eventdata, handles)
% hObject    handle to run_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd('D:\Documents and Settings\clarkss\My Documents\Raytheon\MATLAB\TrackSim');
nruns=str2double(get(handles.numruns,'String'));
trj_files=get(handles.trjfiles,'String');
sel_trj=trj_files{get(handles.trjfiles,'Value')};
trj_folder='D:\Documents and Settings\clarkss\My Documents\Raytheon\MATLAB\TrackSim\Trajectory_Data\';
save_dir='D:\Documents and Settings\clarkss\My Documents\Raytheon\MATLAB\TrackSim\MMsim_output';
run_name=strcat(get(handles.savename,'String'),'_',num2str(nruns));
run_name=run_name{:};
set(handles.statustxt,'BackgroundColor','r');
set(handles.statustxt,'String','Busy');

try
    for ii=1:nruns
        load data
        data.traj_loc=fullfile(trj_folder,sel_trj);
        [constants radar truth trackdata Tlower Tupper]=simulate_trackers(data);
       if ii==1
           mkdir(fullfile(save_dir,run_name));
       end
        save(fullfile(save_dir,run_name,strcat('run_',num2str(ii),'_out')),'constants', 'radar', 'truth', 'trackdata', 'Tlower', 'Tupper');
    end
catch
    disp('sim failed');
end

set(handles.statustxt,'BackgroundColor','g');
set(handles.statustxt,'String','Idle');
guidata(hObject, handles);



% --- Executes on selection change in trjfiles.
function trjfiles_Callback(hObject, eventdata, handles)
% hObject    handle to trjfiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns trjfiles contents as cell array
%        contents{get(hObject,'Value')} returns selected item from trjfiles


% --- Executes during object creation, after setting all properties.
function trjfiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trjfiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numruns_Callback(hObject, eventdata, handles)
% hObject    handle to numruns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numruns as text
%        str2double(get(hObject,'String')) returns contents of numruns as a double


% --- Executes during object creation, after setting all properties.
function numruns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numruns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function savename_Callback(hObject, eventdata, handles)
% hObject    handle to savename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of savename as text
%        str2double(get(hObject,'String')) returns contents of savename as a double


% --- Executes during object creation, after setting all properties.
function savename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to savename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



