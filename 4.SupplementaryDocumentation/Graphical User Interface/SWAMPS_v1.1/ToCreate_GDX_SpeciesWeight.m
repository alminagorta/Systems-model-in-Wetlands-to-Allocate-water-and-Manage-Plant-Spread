function ToCreate_GDX_SpeciesWeight()
%This code is to modify the input data and create Gdx files
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
global G_data; %Defining the global function

% Framework for the figure.
k = figure('position',[80 80 580 350], 'name', 'Species Weight', 'MenuBar', 'none','Toolbar', 'none', 'NumberTitle', 'off');


%% Table features

%Here is the default data - for medium -shallow and deep [column] and each
%month[rows]
dat = [
 0.10 	 0.10 	 1.00 
 0.10 	 0.10 	 1.00 
 0.60 	 0.10 	 1.00 
 1.00 	 0.80 	 0.30 
 1.00 	 0.80 	 0.10 
 1.00 	 0.80 	 0.10 
 1.00 	 0.60 	 0.10 
 1.00 	 0.60 	 0.10 
 1.00 	 0.25 	 0.10 
 0.60 	 0.10 	 0.10 
 0.10 	 0.10 	 1.00 
 0.10 	 0.10 	 1.00 ];


% Create the column and row names in cell arrays 
cnames = {'Avocet','Black Necked','Tundra Swan'};
rnames = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};

% Creating the uitable
G_data = uitable(k,'Data',dat,...
            'ColumnName',cnames,... 
            'RowName',rnames,...
            'ColumnWidth',{100},...
            'Position', [20 20 195 303],...
            'ColumnEditable', [true true true] );

G_data.Position(3) = G_data.Extent(3);
G_data.Position(4) = G_data.Extent(4);

% This is to show the text modified in the GUI
 uicontrol('Style', 'text', 'String', 'Values should be between 0 (not desired) to 1 (desired)',...
 'BackgroundColor', [ 1 1 1 ],'Position', [400 220 180 40]);

% A button to create the Save data
Button = uicontrol('Style', 'pushbutton', 'String', 'Save Data',...
'Position', [430 150 100 30],'Callback', @CreatingGDX);


%% To create the GDX file
function CreatingGDX(hObject,eventdata)
global G_data;
% Gets the value of the parameter.
Mod_data = get(G_data,'Data');

Mod_data1 = Mod_data; %This is the data that can be transfer to the structure in GAMS

%% Input table with your modified data

%To write Index
mn.name='mn' 
mn.uels={'1','2','3','4','5','6','7','8','9','10','11','12'}; %this is the components of the structure
spec.name='spec' %create the structure
spec.uels={'spec1','spec2','spec3'} %this is the components of the structure

%to write the Table
d.name='specweight';
d.val= Mod_data1; 
d.form = 'full'; % Sparse is for integer and full is for decimal
d.type ='parameter';
d.uels={mn.uels,spec.uels};

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
which gams

%Here create the GDX file 
wgdx('G_specweight',mn,spec,d); 
gdxInfo 'G_specweight.gdx' 

close


