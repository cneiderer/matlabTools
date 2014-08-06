function varargout = WEAFIL_to_HFSS_GUI_v1(varargin)
% WEAFIL_TO_HFSS_GUI_V1 M-file for WEAFIL_to_HFSS_GUI_v1.fig
%      WEAFIL_TO_HFSS_GUI_V1, by itself, creates a new WEAFIL_TO_HFSS_GUI_V1 or raises the existing
%      singleton*.
%
%      H = WEAFIL_TO_HFSS_GUI_V1 returns the handle to a new WEAFIL_TO_HFSS_GUI_V1 or the handle to
%      the existing singleton*.
%
%      WEAFIL_TO_HFSS_GUI_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WEAFIL_TO_HFSS_GUI_V1.M with the given input arguments.
%
%      WEAFIL_TO_HFSS_GUI_V1('Property','Value',...) creates a new WEAFIL_TO_HFSS_GUI_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WEAFIL_to_HFSS_GUI_v1_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WEAFIL_to_HFSS_GUI_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help WEAFIL_to_HFSS_GUI_v1

% Last Modified by GUIDE v2.5 17-Apr-2009 09:47:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WEAFIL_to_HFSS_GUI_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @WEAFIL_to_HFSS_GUI_v1_OutputFcn, ...
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


% --- Executes just before WEAFIL_to_HFSS_GUI_v1 is made visible.
function WEAFIL_to_HFSS_GUI_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WEAFIL_to_HFSS_GUI_v1 (see VARARGIN)

% Choose default command line output for WEAFIL_to_HFSS_GUI_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WEAFIL_to_HFSS_GUI_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WEAFIL_to_HFSS_GUI_v1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse_Button.
function Browse_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

orig_dir=cd;
cd('S:\Curtis_Neiderer\WEAFIL_Files');
[DataFile,DataPath]=uigetfile('*.dat','Select file for conversion:');
WEAFIL_file=fullfile(DataPath,DataFile);
cd(orig_dir);

set(handles.Data_File_EditBox,'string',WEAFIL_file);

function Data_File_EditBox_Callback(hObject, eventdata, handles)
% hObject    handle to Data_File_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Data_File_EditBox as text
%        str2double(get(hObject,'String')) returns contents of Data_File_EditBox as a double

WEAFIL_file=get(handles.Data_File_EditBox,'string');
if ~exist('WEAFIL_file','file')
%     error('The selected WEAFIL file does not exist, please check your path.')
    errordlg('The selected WEAFIL file does not exist, please check your path.')
end

% --- Executes during object creation, after setting all properties.
function Data_File_EditBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_File_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function VBScript_File_EditBox_Callback(hObject, eventdata, handles)
% hObject    handle to VBScript_File_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VBScript_File_EditBox as text
%        str2double(get(hObject,'String')) returns contents of VBScript_File_EditBox as a double


% --- Executes during object creation, after setting all properties.
function VBScript_File_EditBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VBScript_File_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in SaveAs_Button.
function SaveAs_Button_Callback(hObject, eventdata, handles)
% hObject    handle to SaveAs_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

orig_dir=cd;
cd('S:\Curtis_Neiderer\VBScript_Files');
[ScriptFile,ScriptPath]=uiputfile('*.vbs','Select name for VBScript file:');
VBScript_file=fullfile(ScriptPath,ScriptFile);
cd(orig_dir);

set(handles.VBScript_File_EditBox,'string',VBScript_file);

% --- Executes on button press in Convert_Button.
function Convert_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Convert_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

WEAFIL_file=get(handles.Data_File_EditBox,'string');
WEAFIL_file=get(handles.Data_File_EditBox,'string');
if ~exist('WEAFIL_file','file')
%     error('The selected WEAFIL file does not exist, please check your path.')
    errordlg('The selected WEAFIL file does not exist, please check your path.')
end

VBScript_file=get(handles.VBScript_File_EditBox,'string');

% Find filter type
if get(handles.WGD_RadioButton,'value')
    filter_type=1;
elseif get(handles.CLD_RadioButton,'value')
    filter_type=2;
elseif get(handles.IDD_RadioButton,'value')
    filter_type=3;
elseif get(handles.CCD_RadioButton,'value')
    filter_type=4;
end

WEAFIL_to_HFSS_GUI_ver(WEAFIL_file,VBScript_file,filter_type);

% --- Executes on button press in WGD_RadioButton.
function WGD_RadioButton_Callback(hObject, eventdata, handles)
% hObject    handle to WGD_RadioButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WGD_RadioButton

