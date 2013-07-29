function varargout = poissonGUI(varargin)
%------------------------------------
%Most code for poissonGUI generate by MATLAB
%Code adapted from Merza Klaghstan
%------------------------------------

% POISSONGUI MATLAB code for poissonGUI.fig
%      POISSONGUI, by itself, creates a new POISSONGUI or raises the existing
%      singleton*.
%
%      H = POISSONGUI returns the handle to a new POISSONGUI or the handle to
%      the existing singleton*.
%
%      POISSONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POISSONGUI.M with the given input arguments.
%
%      POISSONGUI('Property','Value',...) creates a new POISSONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before poissonGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to poissonGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help poissonGUI

% Last Modified by GUIDE v2.5 27-Jul-2013 15:29:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @poissonGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @poissonGUI_OutputFcn, ...
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


% --- Executes just before poissonGUI is made visible.
function poissonGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to poissonGUI (see VARARGIN)

% Choose default command line output for poissonGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes poissonGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = poissonGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%------------------------------------
%Executes on button press in source.
% Code adapted from Merza Klaghstan
%------------------------------------
function source_Callback(hObject, eventdata, handles)
% hObject    handle to source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%------------------------------------
%User is prompted to pick a file which is assigned at the img_source 
%------------------------------------
[FileName,PathName,FilterIndex] = uigetfile({'*.jpg';'*.png'},'Select source file');
    sfn = FileName;
    spn = PathName;
    sindex = FilterIndex;
    
assignin('base', 'img_source', strcat(spn,sfn));
guidata(hObject, handles);

%------------------------------------
%Executes on button press in target.
%------------------------------------
function target_Callback(hObject, eventdata, handles)
% hObject    handle to target (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%------------------------------------
%Use is prompted to pick a file which is assigned as the img_target
%------------------------------------
 [FileName,PathName,FilterIndex] = uigetfile({'*.jpg';'*.png'},'Select source file');
    tfn = FileName;
    tpn = PathName;
    tindex = FilterIndex;

assignin('base', 'img_target', strcat(tpn,tfn));
guidata(hObject, handles);

%------------------------------------
% Executes on button press in compute.
%runs mainP function
%------------------------------------
function compute_Callback(hObject, eventdata, handles)
% hObject    handle to compute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mainP


