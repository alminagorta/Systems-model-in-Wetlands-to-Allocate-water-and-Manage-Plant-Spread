function ToCreate_GDX_InitStor()
%This code is to modify the input data of Initial invasive vegetation and create Gdx file 
%Coded by Omar Alminagorta
%Utah State University

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
%%
global G_InitStor; 

% Framework for the figure.
% position is "left bottom width height"
k = figure('position',[80 80 450 650], 'name', 'Initial Storage ', 'MenuBar', 'none','Toolbar', 'none', 'NumberTitle', 'off');
            
%% Table features

%Here is the default data - each row corresponds to the initial cover
%vegetation in their respective wetland units below
dat = repmat(0.1,1,25)'; 

% Create the column and row names in cell arrays 
cnames = {'Initial Storage'};
rnames = {'1','1A','1B','2A','2B','2C','2D','3A','3B','3C','3D','3E','3F','3G','3H','3I','3J','3K','4A','4B','4C','5A','5B','5C','5D'};

% Create the uitable
G_InitStor = uitable(k,'Data',dat,...
            'ColumnName',cnames,... 
            'RowName',rnames,...
            'ColumnWidth',{150},...
            'Position', [20 20 195 303],...
            'ColumnEditable', [true true true] );

% % Set width and height
G_InitStor.Position(3) = G_InitStor.Extent(3);
G_InitStor.Position(4) = G_InitStor.Extent(4);

uicontrol('Style', 'text', 'String', 'Input initial storage per each wetland unit. Select units',...
  'fontsize',10,'BackgroundColor', [ 1 1 1 ],'Position', [230 500 200 80]);

Button = uicontrol('Style', 'pushbutton', 'String', 'Save Data',...
'Position', [280 220 100 30],'Callback', @CreatingGDX);

 %% Creating ratio buttom to implement the units convertion
bg = uibuttongroup('Title','Units',...
                   'Position',[.52 .45 .47 .3]);
%            'Position',[.52 .35 .45 .3],'SelectionChangedFcn',@conversion);

%It needs to be fixed to press only one 
rb1 = uicontrol(bg,'Style','radiobutton','String','hectare meter',...
                'Units','normalized',...
                'Position',[.2 .8 .5 .1]);
            
rb2 = uicontrol(bg,'Style','radiobutton','String','acre foot',...
                'Units','normalized',...
                'Position',[.2 .4 .5 .1]);
            
% rb3 = uicontrol(bg,'Style','radiobutton','String','cubic foot',...
%                 'Units','normalized',...
%                 'Position',[.2 .6 .5 .1]);

                   
set (rb1,'callback',@ham);%In Hectare- meter
set (rb2,'callback',@acreft);%In Acre foot
%set (rb3,'callback',@cf);%In Cubic foot

FactorConversion1 = 8.10713182109; %1ha-m =8.10 acre-ft
FactorConversion2 = 353146.6657220765; %1ha-m =353146 cubic fooot

    function ham (hObject, eventdata, handles)  
    global G_InitStor
a= get(hObject,'Value')

if a==1
  G_InitStorA = get(G_InitStor,'Data');
        set(G_InitStor,'Data',G_InitStorA/8.10713182109);
end
	
    function acreft (hObject, eventdata, handles)  
    global G_InitStor
a= get(hObject,'Value')
%here handles link with "axes1"
if a==1
  G_InitStorA = get(G_InitStor,'Data');
        set(G_InitStor,'Data',G_InitStorA*8.10713182109);

end

    
%% To create the GDX file
function CreatingGDX(hObject,eventdata)
global G_InitStor;% passing the global variable

% Gets the value of the parameter.
Mod_data = get(G_InitStor,'Data');


Mod_data1 = Mod_data; %This is the data that an be transfer to the structure in GAMS

%% Input table with your modified data

i.name='i' %create the structure
i.uels={'1','1A','1B','2A','2B','2C','2D','3A','3B','3C','3D','3E','3F','3G','3H','3I','3J','3K','4A','4B','4C','5A','5B','5C','5D'}; %this is the components of the structure

%to write the Table
d.name='initStor2';
d.val= Mod_data1; 
d.form = 'full'; % Sparse is for integer and full is for decimal
d.type ='parameter';
d.uels={i.uels};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Creating a GDX file with the data above
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% To set up GAMS and  add the path
% Here I need to set the path where Gams file is created
%addpath(genpath('C:\GAMS\win64\24.1\'));
tempDir = genpath([cd,'\24.1\']);
addpath(tempDir);
disp(tempDir);
%To test 
which('gams')

%Here create the GDX file 
wgdx('G_InitStor',i,d); 
gdxInfo 'G_InitStor.gdx' 

close


            
