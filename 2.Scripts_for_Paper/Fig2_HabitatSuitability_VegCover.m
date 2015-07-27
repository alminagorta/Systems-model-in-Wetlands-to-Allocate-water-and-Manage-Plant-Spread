%% Figure 2: Plot the curve Habitat Suitability Veg.Cover
%Updated: 3 July-2015
%Developed by Omar Alminagorta
%Dept. of Civil & Environmental Engineering and Utah Water Research Lab
%Utah State University
% o.alminagorta@aggiemail.usu.edu  
%
% If you use the code, cite as:
% Alminagorta, O., D. E. Rosenberg, and K. M. Kettenring, Systems modeling to improve  the  hydro-ecological  performance  of
% diked  wetlands, (Under Review to resubmit to Water Resources Research Journal).

%   Licensing:
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


close all; clear all; clc
%to set a white background
set(0,'DefaultFigureColor', 'white'); 
%Getting the file
[A2,textA2]=xlsread('PlotFunctionsPaper.xlsx','Fig2','A1:B500');

XX2=(A2(:,1)); 
YY2=(A2(:,2));

plot(XX2,YY2,'-b','LineWidth',2);
set(gca,'FontSize',12,'FontName','Times New Roman'); 
set(gca, 'Box', 'off' ); % here gca means get current axis
set(gca,'TickDir','out');
set(gca,'Position',[0.199376947040498 0.173076923076923 0.761697819314642 0.747115384615385]);

% Create xlabel
xlabel('Invasive vegetation cover (%)');

% Create ylabel
ylabel('Habitat suitability index');

% Create textbox
annotation('textbox',...
    [0.0807541619669831 0.154752251626951 0.0594936708860758 0.047970479704797],...
    'String',{'Poor'},...
    'FontSize',12,...
    'FontName','Times New Roman',...
    'LineStyle','none');

% Create textbox
annotation('textbox',...
    [0.0385485819511248 0.903584630735064 0.0860759493670885 0.0479704797047976],...
    'String',{'Excellent'},...
    'FontSize',12,...
    'FontName','Times New Roman',...
    'LineStyle','none');

