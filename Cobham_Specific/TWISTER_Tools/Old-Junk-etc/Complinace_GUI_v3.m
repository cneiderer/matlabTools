function varargout = Complinace_GUI_v3(varargin)
% COMPLINACE_GUI_V3 M-file for Complinace_GUI_v3.fig
%      COMPLINACE_GUI_V3, by itself, creates a new COMPLINACE_GUI_V3 or raises the existing
%      singleton*.
%
%      H = COMPLINACE_GUI_V3 returns the handle to a new COMPLINACE_GUI_V3 or the handle to
%      the existing singleton*.
%
%      COMPLINACE_GUI_V3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPLINACE_GUI_V3.M with the given input arguments.
%
%      COMPLINACE_GUI_V3('Property','Value',...) creates a new COMPLINACE_GUI_V3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Complinace_GUI_v3_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Complinace_GUI_v3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help Complinace_GUI_v3

% Last Modified by GUIDE v2.5 14-Apr-2009 13:53:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Complinace_GUI_v3_OpeningFcn, ...
                   'gui_OutputFcn',  @Complinace_GUI_v3_OutputFcn, ...
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


% --- Executes just before Complinace_GUI_v3 is made visible.
function Complinace_GUI_v3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Complinace_GUI_v3 (see VARARGIN)

% Choose default command line output for Complinace_GUI_v3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Complinace_GUI_v3 wait for user response (see UIRESUME)
% uiwait(handles.System_Compliance_GUI_figure);


% --- Outputs from this function are returned to the command line.
function varargout = Complinace_GUI_v3_OutputFcn(hObject, eventdata, handles) 
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

handles.SN_directory=get(handles.Select_SN_Directory,'string');

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

% Browse to SN directory
if exist('F:\','dir')
    SN_directory=...
        uigetdir('F:\NEW_WARRIOR_DESIGN\NEW FULL TWISTER SYSTEM DATA',...
        'Browse to TWISTER SN Data:'); 
else
    SN_directory=uigetdir('C:\','Browse to TWISTER SN Data:');
end

% Set default SN_directory if necessary
if isempty(SN_directory) || (length(SN_directory)==1 && SN_directory==0)
    SN_directory='C:\';
    set(handles.System_Name_EditBox,'String','');
else
    % Find SN from dir path
    slash_inds=regexpi(SN_directory,'\');
    system_SN=SN_directory(slash_inds(end)+1:end);
    % Update System_Name_EditBox
    set(handles.System_Name_EditBox,'String',system_SN);
end

% Update SN_Directory handle
set(handles.Select_SN_Directory,'String',SN_directory);

guidata(hObject,handles)

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

current_dir=cd;
SN_dirpath=get(handles.Select_SN_Directory,'String');
cd(SN_dirpath);

NB_RX_FileList=get(handles.NB_RX_FileList,'string');

[NB_RX_files,NB_RX_path]=uigetfile({'*.cti';'*.s2p';'*.*'},...
    'Select the NB "RX" data files to be analyzed:','MultiSelect','on');
[edited_FileList]=filelist_edit(SN_dirpath,NB_RX_path,NB_RX_files);

updated_FileList=[NB_RX_FileList;edited_FileList];
set(handles.NB_RX_FileList,'String',updated_FileList);

cd(current_dir);

% --- Executes on button press in Remove_NB_RX_Files.
function Remove_NB_RX_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_NB_RX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

current_dir=cd;
SN_dirpath=get(handles.Select_SN_Directory,'String');
cd(SN_dirpath);

NB_RX_FileList=get(handles.NB_RX_FileList,'string');
selected_entry=get(handles.NB_RX_FileList,'Value');

if (selected_entry-1)==0
    updated_entry=1;
else
    updated_entry=selected_entry-1;
end

updated_FileList={};
for ii=1:length(NB_RX_FileList)
    if ii~=selected_entry;
        updated_FileList=[updated_FileList;NB_RX_FileList(ii)];
    end
end
set(handles.NB_RX_FileList,'Value',updated_entry);
set(handles.NB_RX_FileList,'string',updated_FileList);

cd(current_dir);

% --- Executes on button press in System_Compliance_Check.
function System_Compliance_Check_Callback(hObject, eventdata, handles)
% hObject    handle to System_Compliance_Check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get parent SN directory & number of children files selected
SN_Directory=get(handles.Select_SN_Directory,'string');
Master_FileList.Selected_FileList=[get(handles.NB_TX_FileList,'string');...
                   get(handles.NB_RX_FileList,'string');...
                   get(handles.WB_TX_FileList,'string');...
                   get(handles.WB_RX_FileList,'string')];
Master_FileList.num_files=length(Master_FileList.Selected_FileList);

% Build fullfile lists
NB_RX_FileList=get(handles.NB_RX_FileList,'string');
Master_FileList.NB_RX_FileList=...
    build_fullfile_list(SN_Directory,NB_RX_FileList);
NB_TX_FileList=get(handles.NB_RX_FileList,'string');
Master_FileList.NB_TX_FileList=...
    build_fullfile_list(SN_Directory,NB_TX_FileList);
WB_RX_FileList=get(handles.WB_RX_FileList,'string');
Master_FileList.WB_RX_FileList=...
    build_fullfile_list(SN_Directory,WB_RX_FileList);
WB_TX_FileList=get(handles.WB_TX_FileList,'string');
Master_FileList.WB_TX_FileList=...
    build_fullfile_list(SN_Directory,WB_TX_FileList);

% % Get nstep and GDSmoothie, set defaults if necessary
% Master_FileList.nstep=get(handles.nstep_EditBox,'string');
% if strcmpi(Master_FileList.nstep,'')
%     Master_FileList.nstep='50';
% end
% Master_FileList.GDSmoothie=get(handles.GDSmoothie_EditBox,'string');
% if strcmpi(Master_FileList.GDSmoothie,'')
%     Master_FileList.GDSmoothie='140';
% end

% Get system_name and user_name from edit boxes 
Master_FileList.system_name=get(handles.System_Name_EditBox,'string');
if strcmpi(Master_FileList.system_name,'')
    Master_FileList.system_name='Default_SN';
end
Master_FileList.user_name=get(handles.User_Name_EditBox,'string');
if strcmpi(Master_FileList.user_name,'')
    Master_FileList.user_name='Default_User';
end

% Make sure at least some data files were selected
if isempty(NB_RX_FileList) && isempty(NB_TX_FileList) && ...
   isempty(WB_RX_FileList) && isempty(WB_TX_FileList)
        error('You did not select any files for analysis!!!');
end

% Check system compliance with the ATP
disp('Checking System Compliance with the ATP ...');
system_measurement_data=...
    sys_comp_chk_GUI_ver(Master_FileList);
% Create system compliance spreadsheet
system_measurement_data.user_name=get(handles.User_Name_EditBox,'string');
disp('Creating System Compliance Spreadsheet ...');
sys_comp_xls_GUI_ver(system_measurement_data,Master_FileList);


% --- Executes on selection change in NB_TX_FileList.
function NB_TX_FileList_Callback(hObject, eventdata, handles)
% hObject    handle to NB_TX_FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns NB_TX_FileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from NB_TX_FileList


% --- Executes during object creation, after setting all properties.
function NB_TX_FileList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NB_TX_FileList (see GCBO)
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
function Add_NB_TX_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Add_NB_RX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

current_dir=cd;
SN_dirpath=get(handles.Select_SN_Directory,'String');
cd(SN_dirpath);

NB_TX_FileList=get(handles.NB_TX_FileList,'string');

[NB_TX_files,NB_TX_path]=uigetfile({'*.cti';'*.s2p';'*.*'},...
    'Select the NB "RX" data files to be analyzed:','MultiSelect','on');
[edited_FileList]=filelist_edit(SN_dirpath,NB_TX_path,NB_TX_files);

updated_FileList=[NB_TX_FileList;edited_FileList];
set(handles.NB_TX_FileList,'String',updated_FileList);

cd(current_dir);

% --- Executes on button press in Remove_NB_TX_Files.
function Remove_NB_TX_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_NB_TX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

current_dir=cd;
SN_dirpath=get(handles.Select_SN_Directory,'String');
cd(SN_dirpath);

NB_TX_FileList=get(handles.NB_TX_FileList,'string');
selected_entry=get(handles.NB_RX_FileList,'Value');

if (selected_entry-1)==0
    updated_entry=1;
else
    updated_entry=selected_entry-1;
end

updated_FileList={};
for ii=1:length(NB_TX_FileList)
    if ii~=selected_entry;
        updated_FileList=[updated_FileList;NB_TX_FileList(ii)];
    end
end

set(handles.NB_TX_FileList,'Value',updated_entry);
set(handles.NB_TX_FileList,'string',updated_FileList);

cd(current_dir);

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

current_dir=cd;
SN_dirpath=get(handles.Select_SN_Directory,'String');
cd(SN_dirpath);

WB_RX_FileList=get(handles.WB_RX_FileList,'String');

[WB_RX_files,WB_RX_path]=uigetfile({'*.cti';'*.s2p';'*.*'},...
    'Select the WB "RX" data files to be analyzed:','MultiSelect','on');
[edited_FileList]=filelist_edit(SN_dirpath,WB_RX_path,WB_RX_files);

updated_FileList=[WB_RX_FileList;edited_FileList];
set(handles.WB_RX_FileList,'String',updated_FileList);

cd(current_dir);

% --- Executes on button press in Remove_WB_RX_Files.
function Remove_WB_RX_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_WB_RX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

current_dir=cd;
SN_dirpath=get(handles.Select_SN_Directory,'String');
cd(SN_dirpath);

WB_RX_FileList=get(handles.WB_RX_FileList,'string');
selected_entry=get(handles.NB_RX_FileList,'Value');

if (selected_entry-1)==0
    updated_entry=1;
else
    updated_entry=selected_entry-1;
end

updated_FileList={};
for ii=1:length(WB_RX_FileList)
    if ii~=selected_entry;
        updated_FileList=[updated_FileList;WB_RX_FileList(ii)];
    end
end

set(handles.WB_RX_FileList,'Value',updated_entry);
set(handles.WB_RX_FileList,'string',updated_FileList);

cd(current_dir);

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

current_dir=cd;
SN_dirpath=get(handles.Select_SN_Directory,'String');
cd(SN_dirpath);

WB_TX_FileList=get(handles.WB_TX_FileList,'String');

[WB_TX_files,WB_TX_path]=uigetfile({'*.cti';'*.s2p';'*.*'},...
    'Select the WB "TX" data files to be analyzed:','MultiSelect','on');
[edited_FileList]=filelist_edit(SN_dirpath,WB_TX_path,WB_TX_files);

updated_FileList=[WB_TX_FileList;edited_FileList];
set(handles.WB_TX_FileList,'String',updated_FileList);

cd(current_dir);

% --- Executes on button press in Remove_WB_TX_Files.
function Remove_WB_TX_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_WB_TX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

current_dir=cd;
SN_dirpath=get(handles.Select_SN_Directory,'String');
cd(SN_dirpath);

WB_TX_FileList=get(handles.WB_TX_FileList,'string');
selected_entry=get(handles.NB_RX_FileList,'Value');

if (selected_entry-1)==0
    updated_entry=1;
else
    updated_entry=selected_entry-1;
end

updated_FileList={};
for ii=1:length(WB_TX_FileList)
    if ii~=selected_entry;
        updated_FileList=[updated_FileList;WB_TX_FileList(ii)];
    end
end

set(handles.WB_TX_FileList,'Value',updated_entry);
set(handles.WB_TX_FileList,'string',updated_FileList);

cd(current_dir);

% --- Executes during object creation, after setting all properties.
function Remove_NB_RX_Files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Remove_NB_RX_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function System_Name_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to System_Name_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of System_Name_Edit as text
%        str2double(get(hObject,'String')) returns contents of System_Name_Edit as a double


% --- Executes during object creation, after setting all properties.
function System_Name_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to System_Name_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function User_Name_EditBox_Callback(hObject, eventdata, handles)
% hObject    handle to User_Name_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of User_Name_EditBox as text
%        str2double(get(hObject,'String')) returns contents of User_Name_EditBox as a double


% --- Executes during object creation, after setting all properties.
function User_Name_EditBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to User_Name_EditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


%% ---------- Sub-Functions ---------- %%
function [updated_list]=filelist_edit(SN_dirpath,file_dirpath,selected_files)

% Find detailed dir path
slash_inds=regexpi(SN_dirpath,'\');
SN_dir=SN_dirpath(slash_inds(end):end);
[SN_startind,SN_stopind]=regexpi(file_dirpath,SN_dir);
file_dir=file_dirpath(SN_stopind+1:end);

% Add detailed dir path to selected file list
if iscell(selected_files)
    for ii=1:length(selected_files)
        updated_list{ii,1}=[file_dir,selected_files{ii}];   
    end
elseif isstr(selected_files)
    updated_list={[file_dir,selected_files]};
else
    error('Something is wrong, selected files should be type cell or type string')
end

function [complete_list]=build_fullfile_list(parent_dir,child_dirs)

complete_list={};
for ii=1:length(child_dirs)
    complete_list=[complete_list;{[parent_dir,child_dirs{ii}]}];
end