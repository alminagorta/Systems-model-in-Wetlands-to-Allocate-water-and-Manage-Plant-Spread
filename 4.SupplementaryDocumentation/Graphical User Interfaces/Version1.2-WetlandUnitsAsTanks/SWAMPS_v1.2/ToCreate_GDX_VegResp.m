function ToCreate_GDX_VegResp()
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
global G_VegResp; 

% Framework for the figure.
k = figure('position',[80 80 550 350], 'name', 'Vegetation Growth Rate', 'MenuBar', 'none','Toolbar', 'none', 'NumberTitle', 'off');


%% Table features

%Here is the default data 
dat = [
 0 	  
 0 	 
 0 	 
0.0125
0.0125
0.0125
0.0125
0.0125
0.0125
0.0125
0.0125
0	 
 ];

% Create the column and row names in cell arrays 
cnames = {'Vegetation Growth'};
rnames = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};

% Create the uitable
G_VegResp = uitable(k,'Data',dat,...
            'ColumnName',cnames,... 
            'RowName',rnames,...
            'ColumnWidth',{150},...
            'Position', [20 20 195 303],...
            'ColumnEditable', [true] );

% % Set width and height
G_VegResp.Position(3) = G_VegResp.Extent(3);
G_VegResp.Position(4) = G_VegResp.Extent(4);

% This is to show the text modifie in the GUI
 uicontrol('Style', 'text', 'String', 'Percentage de natural growth of invasive vegetation (with respect to initial vegetation cover conditions). Unit =(m^2 of vegetation growth)/(m^2 of initial vegetation cover)',...
 'BackgroundColor', [ 1 1 1 ],'Position', [350 220 180 100]);

% A button to create the GDX
Button = uicontrol('Style', 'pushbutton', 'String', 'Save Data',...
'Position', [400 150 100 30],'Callback', @CreatingGDX);



%% To create the GDX file
function CreatingGDX(hObject,eventdata)
global G_VegResp;
Mod_data = get(G_VegResp,'Data');

Mod_data1 = Mod_data; 


%% Input table with your modified data

mn.name='mn' %create the structure
mn.uels={'1','2','3','4','5','6','7','8','9','10','11','12'}; %this is the components of the structure

%to write the Table
d.name='VegResp';
d.val= Mod_data1; 
d.form = 'full'; % Sparse is for integer and full is for decimal
d.type ='parameter';
d.uels={mn.uels};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Creating a GDX file with the data above
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% To set up GAMS and  add the path
%addpath(genpath('C:\GAMS\win64\24.1\'));
tempDir = genpath([cd,'\24.1\']);
addpath(tempDir);
disp(tempDir);

which gams
%Here create the GDX file 
wgdx('G_VegResponse',mn,d); 
gdxInfo 'G_VegResponse.gdx' 

close


