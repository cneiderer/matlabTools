
function varargout = Keyboard(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Keyboard_OpeningFcn, ...
                   'gui_OutputFcn',  @Keyboard_OutputFcn, ...
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



function Keyboard_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
handles.Fs = 1/41000;
handles.T =(0:handles.Fs:.3488372093);
handles.Note = 0;
handles.Nf = [130.81 138.59 146.83 155.56 164.81 174.61 ...
             185.00 196.00 207.65 220.00 233.08 246.94 ...
             261.63 277.18 293.66 311.13 329.63 349.23 ...
             369.99 392.00 415.30 440.00 466.16 493.88];
handles.Nfreq = handles.Nf;
handles.Tp = handles.T;

photo=imread('photoaxes.jpg');
axes(handles.axes1);
image(photo)
guidata(hObject, handles);

function varargout = Keyboard_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function Play(handles,F)
Fs = handles.Fs;
T = handles.Tp;
Note = handles.Note;
Nf = handles.Nf;
V = get(handles.volumecontrol,'Value');

Note = V*sin(2*pi*F*T);

sound(Note, 1/Fs)

RecOn = get(handles.rec, 'Value');

if RecOn == 1
  Notes = handles.Note;
  if Notes == 0
    Notes = Note;
  else
    Notes = cat(2, Notes, Note);
  end
  handles.Note = Notes;
  guidata(handles.figure1, handles);  
end



function save_Callback(hObject, eventdata, handles)
Note = handles.Note;
Fs = handles.Fs;

if Note == 0
    error('Record first before saving');
    return;
else
  Filename = get(handles.Filename, 'String');
  wavwrite(Note, 1/Fs, 32, Filename);
end

function play_Callback(hObject, eventdata, handles)
set(handles.play,'value',1)
set(handles.reset,'value',0)
set(handles.rec,'value',0)
V = get(handles.volumecontrol,'value');
Note = V*handles.Note;
Fs = handles.Fs;
sound(Note,1/Fs)


function reset_Callback(hObject, eventdata, handles)
set(handles.play,'value',0)
set(handles.reset,'value',1)
set(handles.rec,'value',0)

handles.Note=0;
guidata(handles.figure1, handles);

function rec_Callback(hObject, eventdata, handles)
set(handles.play,'value',0)
set(handles.reset,'value',0)
set(handles.rec,'value',1)

function Exit_Callback(hObject, eventdata, handles)
close(gcf)


function center_Callback(hObject, eventdata, handles)
set(handles.center,'value',1)
set(handles.lower,'value',0)
set(handles.higher,'value',0)
CenterOn = get(handles.center,'value');
LowerOn = get(handles.lower,'value');
HigherOn = get(handles.higher,'value');

if CenterOn == 1
    Nf=handles.Nf;
elseif LowerOn == 1
    Nf=handles.Nf/4;
elseif HigherOn == 1
    Nf=handles.Nf*4;
end
handles.Nfreq=Nf;
guidata(handles.figure1, handles);

function lower_Callback(hObject, eventdata, handles)
set(handles.lower,'value',1)
set(handles.center,'value',0)
set(handles.higher,'value',0)

CenterOn = get(handles.center,'value');
LowerOn = get(handles.lower,'value');
HigherOn = get(handles.higher,'value');

if CenterOn == 1
    Nf=handles.Nf;
elseif LowerOn == 1
    Nf=handles.Nf/4;
elseif HigherOn == 1
    Nf=handles.Nf*4;
end
handles.Nfreq = Nf;
guidata(handles.figure1, handles);

function higher_Callback(hObject, eventdata, handles)
set(handles.higher,'value',1)
set(handles.center,'value',0)
set(handles.lower,'value',0)

CenterOn = get(handles.center,'value');
LowerOn = get(handles.lower,'value');
HigherOn = get(handles.higher,'value');

if CenterOn == 1
    Nf=handles.Nf;
elseif LowerOn == 1
    Nf=handles.Nf/4;
elseif HigherOn == 1
    Nf=handles.Nf*4;
end
handles.Nfreq = Nf;
guidata(handles.figure1, handles);


function C_Callback(hObject, eventdata, handles)
F=handles.Nfreq(1);
Play(handles,F)
function D_Callback(hObject, eventdata, handles)
F=handles.Nfreq(3);
Play(handles,F)
function E_Callback(hObject, eventdata, handles)
F=handles.Nfreq(5);
Play(handles,F)
function F_Callback(hObject, eventdata, handles)
F=handles.Nfreq(6);
Play(handles,F)
function G_Callback(hObject, eventdata, handles)
F=handles.Nfreq(8);
Play(handles,F)
function A_Callback(hObject, eventdata, handles)
F=handles.Nfreq(10);
Play(handles,F)
function B_Callback(hObject, eventdata, handles)
F=handles.Nfreq(12);
Play(handles,F)
function A2_Callback(hObject, eventdata, handles)
F=handles.Nfreq(22);
Play(handles,F)
function B2_Callback(hObject, eventdata, handles)
F=handles.Nfreq(24);
Play(handles,F)
function C2_Callback(hObject, eventdata, handles)
F=handles.Nfreq(13);
Play(handles,F)
function D2_Callback(hObject, eventdata, handles)
F=handles.Nfreq(15);
Play(handles,F)
function E2_Callback(hObject, eventdata, handles)
F=handles.Nfreq(17);
Play(handles,F)
function F2_Callback(hObject, eventdata, handles)
F=handles.Nfreq(18);
Play(handles,F)
function G2_Callback(hObject, eventdata, handles)
F=handles.Nfreq(20);
Play(handles,F)
function Asharp_Callback(hObject, eventdata, handles)
F=handles.Nfreq(11);
Play(handles,F)
function Csharp_Callback(hObject, eventdata, handles)
F=handles.Nfreq(2);
Play(handles,F)
function Dsharp_Callback(hObject, eventdata, handles)
F=handles.Nfreq(4);
Play(handles,F)
function Fsharp_Callback(hObject, eventdata, handles)
F=handles.Nfreq(7);
Play(handles,F)
function Gsharp_Callback(hObject, eventdata, handles)
F=handles.Nfreq(9);
Play(handles,F)
function Asharp2_Callback(hObject, eventdata, handles)
F=handles.Nfreq(23);
Play(handles,F)
function Csharp2_Callback(hObject, eventdata, handles)
F=handles.Nfreq(14);
Play(handles,F)
function Dsharp2_Callback(hObject, eventdata, handles)
F=handles.Nfreq(16);
Play(handles,F)
function Gsharp2_Callback(hObject, eventdata, handles)
F=handles.Nfreq(21);
Play(handles,F)
function Fsharp2_Callback(hObject, eventdata, handles)
F=handles.Nfreq(19);
Play(handles,F)


function Filename_Callback(hObject, eventdata, handles)

function Filename_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eighth_Callback(hObject, eventdata, handles)

Eight = get(handles.eighth,'value');
T=60/172;
if Eight == 1
    T = T/2;
end
handles.Tp = 0:handles.Fs:T;
guidata(handles.figure1, handles);



function fourth_Callback(hObject, eventdata, handles)

Four = get(handles.fourth,'value');
T=60/172;
if Four == 1
    T = T;
end
handles.Tp = 0:handles.Fs:T;
guidata(handles.figure1, handles);



function half_Callback(hObject, eventdata, handles)

Half = get(handles.half,'value');
T=60/172;
if Half == 1
    T = T*2;
end
handles.Tp = 0:handles.Fs:T;
guidata(handles.figure1, handles);



function whole_Callback(hObject, eventdata, handles)

Whole = get(handles.whole,'value');
T=60/172;
if Whole == 1
    T = T*4;
end
handles.Tp = 0:handles.Fs:T;
guidata(handles.figure1, handles);


function volumecontrol_Callback(hObject, eventdata, handles)

function volumecontrol_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


