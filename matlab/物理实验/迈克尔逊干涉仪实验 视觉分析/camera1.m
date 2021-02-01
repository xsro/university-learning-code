function varargout = camera1(varargin)
% CAMERA1 MATLAB code for camera1.fig
%      CAMERA1, by itself, creates a new CAMERA1 or raises the existing
%      singleton*.
%
%      H = CAMERA1 returns the handle to a new CAMERA1 or the handle to
%      the existing singleton*.
%
%      CAMERA1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAMERA1.M with the given input arguments.
%
%      CAMERA1('Property','Value',...) creates a new CAMERA1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before camera1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to camera1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help camera1

% Last Modified by GUIDE v2.5 25-Feb-2020 18:01:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @camera1_OpeningFcn, ...
                   'gui_OutputFcn',  @camera1_OutputFcn, ...
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


% --- Executes just before camera1 is made visible.
function camera1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to camera1 (see VARARGIN)

% Choose default command line output for camera1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes camera1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = camera1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
frame = getsnapshot(obj);
image(frame,axes2);
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global obj;obj = videoinput('winvideo');
set(obj, 'FramesPerTrigger', 1);set(obj, 'TriggerRepeat', Inf);
usbVidRes1=get(obj,'videoResolution');
nBands1=get(obj,'NumberOfBands');%'NumberOfBands'
axes(handles.axes1);
hImage1=imshow(zeros(usbVidRes1(2),usbVidRes1(1),nBands1));
preview(obj,hImage1);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
obj= videoinput('winvideo');
preview(axes1,obj);

% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
