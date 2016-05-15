function varargout = GUI_GAMS_v1(varargin)
%% Graphical User Interface for the SWAMPS model 
%Created by Omar Alminagorta Cabezas
%Dept. of Civil & Environmental Engineering 
%Utah Water Research Laboratory
%Utah State University
%https://sites.google.com/a/aggiemail.usu.edu/omar-alminagorta-cabezas/

%% This code create the graphical user interface Gams-Matlab for the SWAMPS model
%For description about the model see:
% Alminagorta, O., D. E. Rosenberg, and K. M. Kettenring, Systems modeling to improve  the  hydro-ecological  performance  of
% diked  wetlands, (Under Review, Water Resources Research Journal).
% More information in the GitHub: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread
%%   Licensing:
% Copyright (c) 2015, Omar Alminagorta and David E. Rosenberg
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% 1. Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer.
% 
% 2. Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution.
% 
% 3. Neither the name of the copyright holder nor the names of its
%   contributors may be used to endorse or promote products derived from
%   this software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

%% Additional Notes:
%1)When run the GUI, make sure that Output excel 'Results' is
%closed.Otherwise it will not save the last results 
%%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_GAMS_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_GAMS_v1_OutputFcn, ...
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
% --- Executes just before GUI_GAMS_v1 is made visible.
function GUI_GAMS_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_GAMS_v1 (see VARARGIN)

% Choose default command line output for GUI_GAMS_v1
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% %OA_ Initial configuration
%   clear all; clc
% %Here insert any text to show in the cmr
% disp('SWAMPS please, make sure to check the instructions to setup the GUI')


%% GAMS path
addpath(genpath('C:\GAMS\win64\24.1\'));
% tempDir = genpath([cd,'\24.1\']);
% addpath(tempDir);
% disp(tempDir);

%To test 
% which gams;


%% To add the intial screen logo
    window = figure( 'Name', 'SWAMPS', ...
    'MenuBar', 'none', ...
    'Toolbar', 'none', ...
    'NumberTitle', 'off', ...
    'Position', 500*ones(1,4) );

imshow('Logo_SWAMPS_v2_PNG.png') 

% % Add a text uicontrol to label the slider.
%     uicontrol('Style','text',...
%         'Position',[400 30 350 50],...
%          'fontsize',12,...
%         'String','By Omar Alminagorta ')

uiwait(gcf,2.5); % this is the time
%disp('SWAMP: Systems Modeling to Improve the Hydro-Ecological Performance of Diked Wetlands ');
close(window);
%OA_ Initial configuration
  clear all; clc
%Here insert any text to show in the cmr
disp('SWAMPS_v1.2 please, make sure to check the instructions to setup the GUI')
    
% --- Outputs from this function are returned to the command line.
function varargout = GUI_GAMS_v1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%set (handles.Note,'String','Input data from Excel (Unchecked) or from the GUI (Checked)')


%% Creating the two RUN buttoms : Run the model with GUI data and run the model with Excel Data 

% --- Executes on button press in RunModelGUI_data.
function RunModelGUI_data_Callback(hObject, eventdata, handles)

%  blah = get(handles.ButtonGroup1,'selectedobject')
% 
%  sosSelection = get(blah,'String');
%  simu = get (handles.Simulation,'Value')
%  optim = get (handles.Optimization,'Value')
% 
% % Update handles structure
% guidata(hObject, handles);

% I incorporated the GUI funcionality to work using two input files([1] GUI as a Tank, [2] Excel as a Tank, [3]GUI-spatial WD ,[4]Excel -spatial WD )
% in three types of models([1]optimi, [2]simula,[3]gate). The combination of type of inputs and type of model are:

% As a Tank

% 11=Using GUI data and running simulation
% 12=Using GUI data and running Optimization
% 13=Using GUI data and running Gate constrained
% 21=Using Excel data and running simulation
% 22=Using Excel data and running Optimization
% 23=Using Excel data and running Gate constrained

% Spatial Wdepth

% 31=Using GUI data and running simulation
% 32=Using GUI data and running Optimization
% 33=Using GUI data and running Gate constrained
% 41=Using Excel data and running simulation
% 42=Using Excel data and running Optimization
% 43=Using Excel data and running Gate constrained

switch (findobj(get(handles.ButtonGroup1,'selectedobject')));

%%  GUI input data and running Simulation 
%OA_it means that it only will run if both conditions apply
%Also make sure for the GUI should be existing GDX files
    case ({handles.Simulation,handles.GUI_data})   
        set (handles.Note,'String','Running the simulation using GUI input data...')
      %Here is running independent gams files
      %  system 'gams GAMS_code_Simul_Excel lo=3 gdx=Results_Simul_input_GUI' 

      %Parameters to create the GDX       
        ModelType.name='ModelType';
        ModelType.val=11 % Using the combination of input files([1] GUI and [2] Excel)and (1=Simulation,2=Optimization,3=GateConstraint)
        ModelType.type='parameter';
        wgdx('G_ModelType',ModelType); %Creating a GDX file

    % To run the GAMS file
      if (ModelType.val == 11); 
        system 'gams GAMS_code_GUI_input lo=3 gdx=Results_Matlab'; 

     %This is to prepare the html file for results         
        options_doc_nocode.format = 'html';
        options_doc_nocode.showCode = false;
       publish('Generation_of_Figures.m',options_doc_nocode);
       web('html/Generation_of_Figures.html');
      end
%% GUI input data and running Optimization    
    case  ({handles.Optimization,handles.GUI_data})
        set (handles.Note,'String','Running the optimization using GUI input data...')
   
   %Parameters to create the GDX       
        ModelType.name='ModelType';
        ModelType.val=12 
        ModelType.type='parameter';
        wgdx('G_ModelType',ModelType); %Creating a GDX file

    % To run the GAMS file
      if (ModelType.val == 12); 
        system 'gams GAMS_code_GUI_input lo=3 gdx=Results_Matlab';   

        options_doc_nocode.format = 'html';
        options_doc_nocode.showCode = false;
        publish('Generation_of_Figures.m',options_doc_nocode);
        web('html/Generation_of_Figures.html');
      end
        
%% GUI input data and  running GateConstrained 
        case  ({handles.Gate_constrained,handles.GUI_data})
        set (handles.Note,'String','Running the optimization with gate constrained using GUI input data...')
   %Parameters to create the GDX       
        ModelType.name='ModelType';
        ModelType.val=13 
        ModelType.type='parameter';
        wgdx('G_ModelType',ModelType); 

    % To run the GAMS file
      if (ModelType.val == 13); 
        system 'gams GAMS_code_GUI_input lo=3 gdx=Results_Matlab';       

        options_doc_nocode.format = 'html';
        options_doc_nocode.showCode = false;
        publish('Generation_of_Figures.m',options_doc_nocode);
        web('html/Generation_of_Figures.html');
      end
end
% % Update handles structure
 % guidata(hObject, handles);

%% --- Executes on button to Run_Model_Excel_data.
function Run_Model_Excel_data_Callback(hObject, eventdata, handles)
 %OA_This is to define the folder
%currentFolder = pwd
%addpath(genpath(currentFolder));

switch (findobj(get(handles.ButtonGroup1,'selectedobject')));
%%  Excel input data and running Simulation
      case  ({handles.Simulation,handles.Excel_data})   
        set (handles.Note,'String','Running the Simulation using Excel input data....please wait!');
   %Parameters to create the GDX       
        ModelType.name='ModelType';
        ModelType.val=21 
        ModelType.type='parameter';
        wgdx('G_ModelType',ModelType); 
    % To run the GAMS file
      if (ModelType.val == 21); 
        system 'gams GAMS_code_Excel_input lo=3 gdx=Results_Matlab';       
        options_doc_nocode.format = 'html';
        options_doc_nocode.showCode = false;
        publish('Generation_of_Figures.m',options_doc_nocode);
        web('html/Generation_of_Figures.html');
      end
%%  Excel input data and running Optimization 
       case  ({handles.Optimization,handles.Excel_data})  
        set (handles.Note,'String','Running the Optimization using Excel input data....please wait!');
   %Parameters to create the GDX       
        ModelType.name='ModelType';
        ModelType.val=22 
        ModelType.type='parameter';
        wgdx('G_ModelType',ModelType); 
    % To run the GAMS file
      if (ModelType.val == 22); 
        system 'gams GAMS_code_Excel_input lo=3 gdx=Results_Matlab';       

        options_doc_nocode.format = 'html';
        options_doc_nocode.showCode = false;
        publish('Generation_of_Figures.m',options_doc_nocode);
        web('html/Generation_of_Figures.html');
      end
%%  Excel input data and running Gate COnstrained
       case  ({handles.Gate_constrained,handles.Excel_data})  
        set (handles.Note,'String','Running the Gate Constrained Optimization using Excel input data....please wait!');
    %Parameters to create the GDX       
        ModelType.name='ModelType';
        ModelType.val=23 
        ModelType.type='parameter';
        wgdx('G_ModelType',ModelType); 
    % To run the GAMS file
      if (ModelType.val == 23); 
        system 'gams GAMS_code_Excel_input lo=3 gdx=Results_Matlab';       

        options_doc_nocode.format = 'html';
        options_doc_nocode.showCode = false;
        publish('Generation_of_Figures.m',options_doc_nocode);
        web('html/Generation_of_Figures.html');
      end   
    
 end

% % Update handles structure
%   guidata(hObject, handles);
  
%% Adding the Spatial WD analysis -April-2016
%For GUI 
function RunModelGUI_data_SpatialWD_Callback(hObject, eventdata, handles)

%  blah = get(handles.ButtonGroup1,'selectedobject')
% 
%  sosSelection = get(blah,'String');
%  simu = get (handles.Simulation,'Value')
%  optim = get (handles.Optimization,'Value')
% 
% % Update handles structure
% guidata(hObject, handles);

switch (findobj(get(handles.ButtonGroup1,'selectedobject')));

%%  GUI input data and running Simulation 
%OA_it means that it only will run if both conditions apply
%Also make sure for the GUI should be existing GDX files
    case ({handles.Simulation,handles.GUI_data_SpatialWD})   
        set (handles.Note,'String','Running the simulation using GUI input data [spatial distribution approach]...')
      %Here is running independent gams files
      %  system 'gams GAMS_code_Simul_Excel lo=3 gdx=Results_Simul_input_GUI' 

      %Parameters to create the GDX       
        ModelType.name='ModelType';
        ModelType.val=31 % Using the combination of input files([1] GUI and [2] Excel)and (1=Simulation,2=Optimization,3=GateConstraint)
        ModelType.type='parameter';
        wgdx('G_ModelType',ModelType); %Creating a GDX file

    % To run the GAMS file
      if (ModelType.val == 31); 
        system 'gams GAMS_code_GUI_input lo=3 gdx=Results_Matlab'; 

     %This is to prepare the html file for results         
        options_doc_nocode.format = 'html';
        options_doc_nocode.showCode = false;
       publish('Generation_of_Figures.m',options_doc_nocode);
       web('html/Generation_of_Figures.html');
      end
%% GUI input data and running Optimization    
    case  ({handles.Optimization,handles.GUI_data_SpatialWD})
        set (handles.Note,'String','Running the optimization using GUI input data[spatial distribution approach]...')
   
   %Parameters to create the GDX       
        ModelType.name='ModelType';
        ModelType.val=32 
        ModelType.type='parameter';
        wgdx('G_ModelType',ModelType); %Creating a GDX file

    % To run the GAMS file
      if (ModelType.val == 32); 
        system 'gams GAMS_code_GUI_input lo=3 gdx=Results_Matlab';   

        options_doc_nocode.format = 'html';
        options_doc_nocode.showCode = false;
        publish('Generation_of_Figures.m',options_doc_nocode);
        web('html/Generation_of_Figures.html');
      end
        
%% GUI input data and  running GateConstrained 
        case  ({handles.Gate_constrained,handles.GUI_data_SpatialWD})
        set (handles.Note,'String','Running the optimization with gate constrained using GUI input data [Spatial Distribution approach]...')
   %Parameters to create the GDX       
        ModelType.name='ModelType';
        ModelType.val=33 
        ModelType.type='parameter';
        wgdx('G_ModelType',ModelType); 

    % To run the GAMS file
      if (ModelType.val == 33); 
        system 'gams GAMS_code_GUI_input lo=3 gdx=Results_Matlab';       

        options_doc_nocode.format = 'html';
        options_doc_nocode.showCode = false;
        publish('Generation_of_Figures.m',options_doc_nocode);
        web('html/Generation_of_Figures.html');
      end
end

%% For Excel_data.

function Run_Model_Excel_data_SpatialWD_Callback(hObject, eventdata, handles)
 %OA_This is to define the folder
%currentFolder = pwd
%addpath(genpath(currentFolder));

switch (findobj(get(handles.ButtonGroup1,'selectedobject')));
%%  Excel input data and running Simulation
      case  ({handles.Simulation,handles.Excel_data_SpatialWD})   
        set (handles.Note,'String','Running the Simulation using Excel input data....please wait! (Spatial distribution Of water depth approach)');
   %Parameters to create the GDX       
        ModelType.name='ModelType';
        ModelType.val=41 
        ModelType.type='parameter';
        wgdx('G_ModelType',ModelType); 
    % To run the GAMS file
      if (ModelType.val == 41); 
        system 'gams GAMS_code_Excel_input lo=3 gdx=Results_Matlab';       
        options_doc_nocode.format = 'html';
        options_doc_nocode.showCode = false;
        publish('Generation_of_Figures.m',options_doc_nocode);
        web('html/Generation_of_Figures.html');
      end
%%  Excel input data and running Optimization 
       case  ({handles.Optimization,handles.Excel_data_SpatialWD})  
        set (handles.Note,'String','Running the Optimization using Excel input data....please wait!(Using the Spatial Distribution Of Water Depths)');
   %Parameters to create the GDX       
        ModelType.name='ModelType';
        ModelType.val=42 
        ModelType.type='parameter';
        wgdx('G_ModelType',ModelType); 
    % To run the GAMS file
      if (ModelType.val == 42); 
        system 'gams GAMS_code_Excel_input lo=3 gdx=Results_Matlab';       

        options_doc_nocode.format = 'html';
        options_doc_nocode.showCode = false;
        publish('Generation_of_Figures.m',options_doc_nocode);
        web('html/Generation_of_Figures.html');
      end
%%  Excel input data and running Gate COnstrained
       case  ({handles.Gate_constrained,handles.Excel_data_SpatialWD})  
        set (handles.Note,'String','Running the Gate Constrained Optimization using Excel input data....please wait!(Using the Spatial Distribution Of Water Depths)');
    %Parameters to create the GDX       
        ModelType.name='ModelType';
        ModelType.val=43 
        ModelType.type='parameter';
        wgdx('G_ModelType',ModelType); 
    % To run the GAMS file
      if (ModelType.val == 43); 
        system 'gams GAMS_code_Excel_input lo=3 gdx=Results_Matlab';       

        options_doc_nocode.format = 'html';
        options_doc_nocode.showCode = false;
        publish('Generation_of_Figures.m',options_doc_nocode);
        web('html/Generation_of_Figures.html');
      end   
    
end
 
%% To create the function in menu bar 
function menubarTools_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function RunScenario_Callback(hObject, eventdata, handles)
       
% %%  --------------------------------------------------------------------
% %To Save The scenario and run it 
% function Save_Scenario_Callback(hObject, eventdata, handles)
% 
% [file_name,path] = uiputfile('*.gdx','Save Model Scenario As');
% %this part is really important because allow me to save as gdx and with specific name given by the user 
%  system (['gams BRMBR1_Simulation lo=3 gdx=',file_name]);

%% run saved Scenario
%--------------------------------------------------------------------
% function Run_Saved_Scen_Callback(hObject, eventdata, handles)
% 
% % --- To Retrieve the GDX file 
% [filename pathname] = uigetfile({'*.gdx'},'Please select the file');
% fullpathname = strcat(pathname,filename) 
% %Here read the new scenario
% WUAW.name='WUAW' % for example if i want to know the WU
% WUAW.compress='true' % this is to delete the "uels" that are not used 
% WUAW=rgdx(filename,WUAW)% this will overwrite with the new data
% %WUAW.val
% %remmenbe that there is an input file in GAMS
% %named"BRMBR_Simulationv21.gdx"
% wgdx('MtoG') 
% gdxInfo 'MtoG.gdx' %Always use to inspect 
% system (['gams BRMBR1_Simulation lo=3 gdx=new_output']);

% %% Choose Buttoms
% % --- Executes when selected object is changed in Input_Type.
% function Input_Type_SelectionChangedFcn(hObject, eventdata, handles)
% if hObject == handles.Simulation 
%     set (handles.Note,'String','Option1: All input data is in Excel file')
% elseif hObject == handles.Optimization
%     set (handles.Note,'String','Option2: Use of the GUI to input some data')
% end

%({handles.Simulation,handles.Excel_data}) 
function ButtonGroup1_SelectionChangedFcn(hObject, eventdata, handles)
if hObject == handles.Simulation
    set (handles.Note,'String','Run the model for Simulation')
    
elseif hObject == handles.Optimization
    set (handles.Note,'String','Run the model for Optimization')

elseif hObject == handles.Gate_constrained
    set (handles.Note,'String','Run the model for Optimization with Gates Constrained')
end


%% This is to modify Cover Vegetation items
% --------------------------------------------------------------------
function InputData_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function ModifyBudget_Callback(hObject, eventdata, handles)
%Here call a function that allow to modify the budget and create a GDX file 
ToCreate_GDX_Budget

%% This is to Menu SpeciesPreferences
% % --------------------------------------------------------------------
% function SpeciesPreferences_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function SpeciesWeight_Callback(hObject, eventdata, handles)
%Here call a function that allow to modify speciesweight and create a GDX file 
ToCreate_GDX_SpeciesWeight
% --------------------------------------------------------------------
function VegetationGrowth_Callback(hObject, eventdata, handles)
ToCreate_GDX_VegResp
%Before was "ToCreate_GDX_InitCV"
% --------------------------------------------------------------------
function Initial_Storage_Callback(hObject, eventdata, handles)    
ToCreate_GDX_InitStor 

%% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
%To describe about
% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)

S.windowAbout = figure('units','pixels',...
              'position',[300 300 300 150],...
              'menubar','none',...
              'name','About',...
              'numbertitle','off',...
              'resize','off');
S.button1 = uicontrol('style','push',...
                 'unit','pix',...
                 'position',[20 10 260 50],...
                 'BackgroundColor','white',...
                 'string','Link to Help');
             
S.Texto = uicontrol('style','text',...
                 'unit','pix',...
                 'position',[20 50 260 100],...
                 'fontsize',12,...
                 'string',' SWAMPS GUI includes: Version 1.2 (Wetland units as tanks) and Version 1.5 (Spatial distribution of water depths). Developed by Omar Alminagorta - 2016');
set(S.button1,'callback',{@pb_call,S})  % Set the callback for pushbutton.


function [] = pb_call(varargin)
url = 'https://github.com/alminagorta/Systems-Model-at-the-Refuge';
web(url)
close;


% % --------------------------------------------------------------------
% function Close_Callback(hObject, eventdata, handles)
% close;
%% Menu Options to Select the Type of Inputs 
% --------------------------------------------------------------------
function InputTypeMenu_Callback(hObject, eventdata, handles)
% hObject    handle to InputTypeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% To activate input Excel Data----------------------------------------------
function Excel_data_Callback(hObject, eventdata, handles)
% hObject    handle to Excel_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if strcmp(get(hObject,'Checked'),'on')
   set(hObject,'Checked','off'); % To desactivate Excel input data
   set(handles.GUI_data,'Checked','on'); % To activate GUI input data
   set(handles.InputData, 'enable', 'on');% Allow to unable the input data using GUI
   
    set(handles.RunModelGUI_data, 'Visible', 'off');
    set(handles.Run_Model_Excel_data, 'Visible', 'on');% Make visible the push bottom
    set(handles.Run_Model_Excel_data_SpatialWD, 'Visible', 'off');
    set(handles.RunModelGUI_data_SpatialWD, 'Visible', 'off');
   
else 
   set(hObject,'Checked','on');
   set(handles.GUI_data,'Checked','off');
   set(handles.GUI_data_SpatialWD,'Checked','off');
   set(handles.Excel_data_SpatialWD,'Checked','off');
   set(handles.InputData, 'enable', 'off');% Allow to able to use the input data using GUI
   set (handles.Note,'String','Model will use the data in the Excel file'); %note
  
   set(handles.RunModelGUI_data, 'Visible', 'off');
   set(handles.Run_Model_Excel_data, 'Visible', 'on');% Make visible the push bottom
   set(handles.Run_Model_Excel_data_SpatialWD, 'Visible', 'off');
   set(handles.RunModelGUI_data_SpatialWD, 'Visible', 'off');
end


%  To activate input GUI Data--------------------------------------------------------------------
function GUI_data_Callback(hObject, eventdata, handles)
% hObject    handle to GUI_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject,'Checked'),'on')
    set(hObject,'Checked','off');
    set(handles.Excel_data,'Checked','on');
    
    set(handles.RunModelGUI_data, 'Visible', 'on');
    set(handles.Run_Model_Excel_data, 'Visible', 'off');% Make visible the push bottom
    set(handles.Run_Model_Excel_data_SpatialWD, 'Visible', 'off');
    set(handles.RunModelGUI_data_SpatialWD, 'Visible', 'off');

else 
    set(hObject,'Checked','on');
    set(handles.Excel_data,'Checked','off');
    set(handles.Excel_data_SpatialWD,'Checked','off');
    set(handles.GUI_data_SpatialWD,'Checked','off');
    set(handles.InputData, 'enable', 'on');% Allow to use the input data using GUI
    set (handles.Note,'String','Model will use data from the GUI.Use the option "Input Data" on the menu bar');%note 
    
    set(handles.RunModelGUI_data, 'Visible', 'on');
    set(handles.Run_Model_Excel_data, 'Visible', 'off');% Make visible the push bottom
    set(handles.Run_Model_Excel_data_SpatialWD, 'Visible', 'off');
    set(handles.RunModelGUI_data_SpatialWD, 'Visible', 'off');
end


% Message of Other inputs--------------------------------------
function Other_inputs_Callback(hObject, eventdata, handles)

 uiwait(msgbox('Additional input data (e.g., inflow, initial vegetation cover) can be entered using the Excel file. See the first sheet "readme" in the Excel file to input additional data','Note','modal'));
 
% --------------------------------------------------------------------
% Deleating all figures generated on the results
function Close_Results_Callback(hObject, eventdata, handles)

close wdepth
close VegetationCover
close HSI_Vegetation_Cover
close WUAW
close HSI_Composed_Map



%Here Adding the Spatial Distribution Of Water Depths-April-2016
% --------------------------------------------------------------------
function GUI_data_SpatialWD_Callback(hObject, eventdata, handles)
if strcmp(get(hObject,'Checked'),'on')
    set(hObject,'Checked','off');
    set(handles.Excel_data_SpatialWD,'Checked','on');
     
    set(handles.RunModelGUI_data, 'Visible', 'off');
    set(handles.Run_Model_Excel_data, 'Visible', 'off');% Make visible the push bottom
    set(handles.Run_Model_Excel_data_SpatialWD, 'Visible', 'off');
    set(handles.RunModelGUI_data_SpatialWD, 'Visible', 'on');
    
else 
    set(hObject,'Checked','on');
    set(handles.Excel_data_SpatialWD,'Checked','off');
    set(handles.Excel_data,'Checked','off');
    set(handles.GUI_data,'Checked','off');
    set(handles.InputData, 'enable', 'on');% Allow to use the input data using GUI
    set (handles.Note,'String','Model will use data from the GUI [Spatial Distribution Of Water Depth Approach]');%note 
    
    set(handles.RunModelGUI_data, 'Visible', 'off');
    set(handles.Run_Model_Excel_data, 'Visible', 'off');% Make visible the push bottom
    set(handles.Run_Model_Excel_data_SpatialWD, 'Visible', 'off');
    set(handles.RunModelGUI_data_SpatialWD, 'Visible', 'on');
end


% --------------------------------------------------------------------
function Excel_data_SpatialWD_Callback(hObject, eventdata, handles)
% hObject    handle to Excel_data_SpatialWD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject,'Checked'),'on')
   set(hObject,'Checked','off'); % To desactivate Excel input data
   set(handles.GUI_data_SpatialWD,'Checked','on'); % To activate GUI input data
   set(handles.InputData, 'enable', 'on');% Allow to unable the input data using GUI
   
    set(handles.RunModelGUI_data, 'Visible', 'off');
    set(handles.Run_Model_Excel_data, 'Visible', 'off');% Make visible the push bottom
    set(handles.Run_Model_Excel_data_SpatialWD, 'Visible', 'on');
    set(handles.RunModelGUI_data_SpatialWD, 'Visible', 'off');
  
   
   
   
   
else 
   set(hObject,'Checked','on');
   set(handles.GUI_data_SpatialWD,'Checked','off');
   set(handles.GUI_data,'Checked','off');
   set(handles.Excel_data,'Checked','off');
   
   set(handles.InputData, 'enable', 'off');% Allow to able to use the input data using GUI
   set (handles.Note,'String','Model will use the data in the Excel file [Spatial Distribution Of Water Depth Approach]'); %note
  
    set(handles.RunModelGUI_data, 'Visible', 'off');
    set(handles.Run_Model_Excel_data, 'Visible', 'off');% Make visible the push bottom
    set(handles.Run_Model_Excel_data_SpatialWD, 'Visible', 'on');
    set(handles.RunModelGUI_data_SpatialWD, 'Visible', 'off');
end

%% 
%--- Executes on button press in Optimization.
function Optimization_Callback(hObject, eventdata, handles)

