function varargout = Excursion_Analysis_GUI_v1(varargin)
% EXCURSION_ANALYSIS_GUI_V1 M-file for Excursion_Analysis_GUI_v1.fig
%      EXCURSION_ANALYSIS_GUI_V1, by itself, creates a new EXCURSION_ANALYSIS_GUI_V1 or raises the existing
%      singleton*.
%
%      H = EXCURSION_ANALYSIS_GUI_V1 returns the handle to a new EXCURSION_ANALYSIS_GUI_V1 or the handle to
%      the existing singleton*.
%
%      EXCURSION_ANALYSIS_GUI_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXCURSION_ANALYSIS_GUI_V1.M with the given input arguments.
%
%      EXCURSION_ANALYSIS_GUI_V1('Property','Value',...) creates a new EXCURSION_ANALYSIS_GUI_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Excursion_Analysis_GUI_v1_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Excursion_Analysis_GUI_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help Excursion_Analysis_GUI_v1

% Last Modified by GUIDE v2.5 27-Mar-2009 10:54:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Excursion_Analysis_GUI_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @Excursion_Analysis_GUI_v1_OutputFcn, ...
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


% --- Executes just before Excursion_Analysis_GUI_v1 is made visible.
function Excursion_Analysis_GUI_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Excursion_Analysis_GUI_v1 (see VARARGIN)

% Choose default command line output for Excursion_Analysis_GUI_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Excursion_Analysis_GUI_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Excursion_Analysis_GUI_v1_OutputFcn(hObject, eventdata, handles) 
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



function File_Select_EditBox_Callback(hObject, eventdata, handles)
% hObject    handle to File_Select_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Select_EditBox as text
%        str2double(get(hObject,'String')) returns contents of File_Select_EditBox as a double


% --- Executes during object creation, after setting all properties.
function File_Select_EditBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Select_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function nsteps_EditBox_Callback(hObject, eventdata, handles)
% hObject    handle to nsteps_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nsteps_EditBox as text
%        str2double(get(hObject,'String')) returns contents of nsteps_EditBox as a double


% --- Executes during object creation, after setting all properties.
function nsteps_EditBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nsteps_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Ripple_Smoothing_EditBox_Callback(hObject, eventdata, handles)
% hObject    handle to Ripple_Smoothing_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ripple_Smoothing_EditBox as text
%        str2double(get(hObject,'String')) returns contents of Ripple_Smoothing_EditBox as a double


% --- Executes during object creation, after setting all properties.
function Ripple_Smoothing_EditBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ripple_Smoothing_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Amplitude_Smoothing_EditBox_Callback(hObject, eventdata, handles)
% hObject    handle to Amplitude_Smoothing_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Amplitude_Smoothing_EditBox as text
%        str2double(get(hObject,'String')) returns contents of Amplitude_Smoothing_EditBox as a double


% --- Executes during object creation, after setting all properties.
function Amplitude_Smoothing_EditBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Amplitude_Smoothing_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function W1_Amp_Spec_Callback(hObject, eventdata, handles)
% hObject    handle to W1_Amp_Spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W1_Amp_Spec as text
%        str2double(get(hObject,'String')) returns contents of W1_Amp_Spec as a double


% --- Executes during object creation, after setting all properties.
function W1_Amp_Spec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W1_Amp_Spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function W1_Amp_Meas_Callback(hObject, eventdata, handles)
% hObject    handle to W1_Amp_Meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W1_Amp_Meas as text
%        str2double(get(hObject,'String')) returns contents of W1_Amp_Meas as a double


% --- Executes during object creation, after setting all properties.
function W1_Amp_Meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W1_Amp_Meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function W1_BW_Spec_Callback(hObject, eventdata, handles)
% hObject    handle to W1_BW_Spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W1_BW_Spec as text
%        str2double(get(hObject,'String')) returns contents of W1_BW_Spec as a double


% --- Executes during object creation, after setting all properties.
function W1_BW_Spec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W1_BW_Spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function W1_BW_Meas_Callback(hObject, eventdata, handles)
% hObject    handle to W1_BW_Meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W1_BW_Meas as text
%        str2double(get(hObject,'String')) returns contents of W1_BW_Meas as a double


% --- Executes during object creation, after setting all properties.
function W1_BW_Meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W1_BW_Meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function W2_Amp_Spec_Callback(hObject, eventdata, handles)
% hObject    handle to W2_Amp_Spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W2_Amp_Spec as text
%        str2double(get(hObject,'String')) returns contents of W2_Amp_Spec as a double


% --- Executes during object creation, after setting all properties.
function W2_Amp_Spec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W2_Amp_Spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function W2_Amp_Meas_Callback(hObject, eventdata, handles)
% hObject    handle to W2_Amp_Meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W2_Amp_Meas as text
%        str2double(get(hObject,'String')) returns contents of W2_Amp_Meas as a double


% --- Executes during object creation, after setting all properties.
function W2_Amp_Meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W2_Amp_Meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function W1_Amp_Comp_Callback(hObject, eventdata, handles)
% hObject    handle to W1_Amp_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W1_Amp_Comp as text
%        str2double(get(hObject,'String')) returns contents of W1_Amp_Comp as a double


% --- Executes during object creation, after setting all properties.
function W1_Amp_Comp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W1_Amp_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function W1_BW_Comp_Callback(hObject, eventdata, handles)
% hObject    handle to W1_BW_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W1_BW_Comp as text
%        str2double(get(hObject,'String')) returns contents of W1_BW_Comp as a double


% --- Executes during object creation, after setting all properties.
function W1_BW_Comp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W1_BW_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function W2_Amp_Comp_Callback(hObject, eventdata, handles)
% hObject    handle to W2_Amp_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W2_Amp_Comp as text
%        str2double(get(hObject,'String')) returns contents of W2_Amp_Comp as a double


% --- Executes during object creation, after setting all properties.
function W2_Amp_Comp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W2_Amp_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function W2_BW_Spec_Callback(hObject, eventdata, handles)
% hObject    handle to W2_BW_Spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W2_BW_Spec as text
%        str2double(get(hObject,'String')) returns contents of W2_BW_Spec as a double


% --- Executes during object creation, after setting all properties.
function W2_BW_Spec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W2_BW_Spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function W2_BW_Meas_Callback(hObject, eventdata, handles)
% hObject    handle to W2_BW_Meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W2_BW_Meas as text
%        str2double(get(hObject,'String')) returns contents of W2_BW_Meas as a double


% --- Executes during object creation, after setting all properties.
function W2_BW_Meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W2_BW_Meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function W2_BW_Comp_Callback(hObject, eventdata, handles)
% hObject    handle to W2_BW_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W2_BW_Comp as text
%        str2double(get(hObject,'String')) returns contents of W2_BW_Comp as a double


% --- Executes during object creation, after setting all properties.
function W2_BW_Comp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W2_BW_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function W1_exist_Callback(hObject, eventdata, handles)
% hObject    handle to W1_exist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W1_exist as text
%        str2double(get(hObject,'String')) returns contents of W1_exist as a double


% --- Executes during object creation, after setting all properties.
function W1_exist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W1_exist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in Analysis_Button.
function Analysis_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Analysis_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Step_Button.
function Step_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Step_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function W2_exist_Callback(hObject, eventdata, handles)
% hObject    handle to W2_exist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W2_exist as text
%        str2double(get(hObject,'String')) returns contents of W2_exist as a double


% --- Executes during object creation, after setting all properties.
function W2_exist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W2_exist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


