function ToCreate_GDX_Budget()
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

% Framework for the figure.
k = figure('position',[350 200 650 250], 'name', 'Budget to reduce invasive vegetation cover', 'MenuBar', 'none','Toolbar', 'none', 'NumberTitle', 'off');

global G_budget

% "left bottom width height"

%Creating the text          
G_budget = uicontrol('style','edit',...
                    'unit','pix',...
                    'position',[300 120 100 30],...
                    'string','180000');
                                           
%Here create the GDX
hbsp = uicontrol('String','Save Data',...
              'Position',[510 120 100 30],'Callback', @CreatingGDX);

% Here is the static text         
StatText1 = uicontrol('style','text',...
                    'position',[190 120 70 30],...
                    'string','Amount',...
                    'fontsize',12);  
  
uicontrol('Style', 'text', 'String', '$/year',...
  'fontsize',10,'BackgroundColor', [ 1 1 1 ],'Position', [415 120 80 30]);    
                
 %% To create the GDX file
function CreatingGDX(hObject,eventdata)

global G_budget
%OA_Default value can be input by GUIDE properties
G_budget=str2double(get (G_budget,'String')); 
 

%% Input table with your modified data
B.name='B'
B.val=G_budget
B.type='parameter'

%% Creating a GDX file with the data above
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% To set up GAMS and  add the path
tempDir = genpath([cd,'\24.1\']);
addpath(tempDir);
disp(tempDir);
%To test 
which('gams')

wgdx('G_Budget',B);
gdxInfo 'G_Budget.gdx'  
close





