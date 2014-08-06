function varargout = untitled2(varargin)
% UNTITLED2 M-file for untitled2.fig
%      UNTITLED2, by itself, creates a new UNTITLED2 or raises the existing
%      singleton*.
%
%      H = UNTITLED2 returns the handle to a new UNTITLED2 or the handle to
%      the existing singleton*.
%
%      UNTITLED2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED2.M with the given input arguments.
%
%      UNTITLED2('Property','Value',...) creates a new UNTITLED2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled2_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help untitled2

% Last Modified by GUIDE v2.5 26-Mar-2009 10:59:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled2_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled2_OutputFcn, ...
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


% --- Executes just before untitled2 is made visible.
function untitled2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled2 (see VARARGIN)

% Choose default command line output for untitled2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled2 wait for user response (see UIRESUME)
% uiwait(handles.System_Compliance_GUI_figure);


% --- Outputs from this function are returned to the command line.
function varargout = untitled2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Select_SN_Directory_Callback(hObject, eventdata, handles)
% hObject    handle to Select_SN_Directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Select_SN_Directory as text
%        str2double(get(hObject,'String')) returns contents of Select_SN_Directory as a double


% --- Executes during object creation, after setting all properties.
function Select_SN_Directory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Select_SN_Directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in Browse_to_SN.
function Browse_to_SN_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_to_SN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in NB_RX_FileList.
function NB_RX_FileList_Callback(hObject, eventdata, handles)
% hObject    handle to NB_RX_FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns NB_RX_FileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from NB_RX_FileList


% --- Executes during object creation, after setting all properties.
function NB_RX_FileList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NB_RX_FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in Add_NB_RX_Files.
function Add_NB_RX_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Add_NB_RX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Remove_NB_RX_Files.
function Remove_NB_RX_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_NB_RX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in System_Compliance_Check.
function System_Compliance_Check_Callback(hObject, eventdata, handles)
% hObject    handle to System_Compliance_Check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in TX_NB_FileList.
function TX_NB_FileList_Callback(hObject, eventdata, handles)
% hObject    handle to TX_NB_FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns TX_NB_FileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX_NB_FileList


% --- Executes during object creation, after setting all properties.
function TX_NB_FileList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX_NB_FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in Add_NB_TX_Files.
function Add_NB_TX_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Add_NB_TX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Remove_NB_TX_Files.
function Remove_NB_TX_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_NB_TX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in WB_RX_FileList.
function WB_RX_FileList_Callback(hObject, eventdata, handles)
% hObject    handle to WB_RX_FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns WB_RX_FileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from WB_RX_FileList


% --- Executes during object creation, after setting all properties.
function WB_RX_FileList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WB_RX_FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in Add_WB_RX_Files.
function Add_WB_RX_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Add_WB_RX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Remove_WB_RX_Files.
function Remove_WB_RX_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_WB_RX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in WB_TX_FileList.
function WB_TX_FileList_Callback(hObject, eventdata, handles)
% hObject    handle to WB_TX_FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns WB_TX_FileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from WB_TX_FileList


% --- Executes during object creation, after setting all properties.
function WB_TX_FileList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WB_TX_FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in Add_WB_TX_Files.
function Add_WB_TX_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Add_WB_TX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Remove_WB_TX_Files.
function Remove_WB_TX_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_WB_TX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


