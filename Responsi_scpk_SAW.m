function varargout = Responsi_scpk_SAW(varargin)
% RESPONSI_SCPK_SAW MATLAB code for Responsi_scpk_SAW.fig
%      RESPONSI_SCPK_SAW, by itself, creates a new RESPONSI_SCPK_SAW or raises the existing
%      singleton*.
%
%      H = RESPONSI_SCPK_SAW returns the handle to a new RESPONSI_SCPK_SAW or the handle to
%      the existing singleton*.
%
%      RESPONSI_SCPK_SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSI_SCPK_SAW.M with the given input arguments.
%
%      RESPONSI_SCPK_SAW('Property','Value',...) creates a new RESPONSI_SCPK_SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Responsi_scpk_SAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Responsi_scpk_SAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Responsi_scpk_SAW

% Last Modified by GUIDE v2.5 26-Jun-2021 04:47:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Responsi_scpk_SAW_OpeningFcn, ...
                   'gui_OutputFcn',  @Responsi_scpk_SAW_OutputFcn, ...
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


% --- Executes just before Responsi_scpk_SAW is made visible.
function Responsi_scpk_SAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Responsi_scpk_SAW (see VARARGIN)

% Choose default command line output for Responsi_scpk_SAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Responsi_scpk_SAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Responsi_scpk_SAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in data.
function data_Callback(hObject, eventdata, handles)
% hObject    handle to data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA_RUMAH.xlsx');%menggunakan data pada file DATA RUMAH.xlsx
opts.SelectedVariableNames = (1:7);%menampilkan data tabel kolom 1-7
data = readmatrix('DATA_RUMAH.xlsx', opts);%membaca isi dari file DATA RUMAH.xlsx
set(handles.tabel1,'data',data,'visible','on');%membaca menampilkan file dan pada tabel


% --- Executes on button press in peringkat.
function peringkat_Callback(hObject, eventdata, handles)
% hObject    handle to peringkat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA_RUMAH.xlsx')%menggunakan data pada file DATA RUMAH.xlsx
opts.SelectedVariableNames = (2:7);%menampilkan data tabel kolom 1-7
data = readmatrix('DATA_RUMAH.xlsx', opts);%membaca isi dari file DATA RUMAH.xlsx
k=[0,1,1,1,1,1]; %nilai benefit / cost
w=[0.3,0.2,0.23,0.1,0.07,0.1]; %nilai bobot kriteria
[m n]=size (data);
R=zeros (m,n); %membuat matriks (R) sebagai matriks kosong
Y=zeros (m,n); %membuat matriks (Y) sebagai titik kosong
for j=1:n, %statement if-else untuk kriteria dengan atribut benefit dan cost
    if k(j)==1, 
        R(:,j)=data(:,j)./max(data(:,j));
    else 
        R(:,j)=min(data(:,j))./data(:,j);
    end;
end;
for i=1:m,
    V(i)= sum(w.*R(i,:)) %Menghitung nilai   
end;

opts = detectImportOptions('DATA_RUMAH.xlsx');
opts.SelectedVariableNames = (1);
baru = readmatrix('DATA_RUMAH.xlsx', opts);
xlswrite('Result_SAW.xlsx', baru, 'Sheet1', 'A1'); %menulis data pada file Result SAW.xlsx di kolom A1 
V=V'; %mengubah data hasil perhitungan dari bentuk horizontal ke vertikal matriks
xlswrite('Result_SAW.xlsx', V, 'Sheet1', 'B1'); %menulis data pada file Result SAW.xlsx di kolom B1

opts = detectImportOptions('Result_SAW.xlsx');
opts.SelectedVariableNames = (1:2);
data = readmatrix('Result_SAW.xlsx', opts); %membaca file Result SAW.xlsx

X=sortrows(data,2,'descend'); %mengurutkan data dari file berdasarkan kolom ke-2 dari yang terbesar
X=X(1:20,1:2); %memilih data 20 teratas
set(handles.tabel3,'data',X,'visible','on'); %menampilkan data yang telah diurutkan ke tabel tersebut
