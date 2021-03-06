%Updated: July-2015
%Developed by Omar Alminagorta
%Dept. of Civil & Environmental Engineering and Utah Water Research Lab
%Utah State University
% o.alminagorta@aggiemail.usu.edu  

%Input: 1) Excel file "PlotFunctionsPaper" and 2) "FunctionNeededToHSI_BirdSpecies'
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
%%
function FunctionNeededToHSI_BirdSpecies(X1, YMatrix1)
%CREATEFIGURE(X1,YMATRIX1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data
%  Auto-generated by MATLAB on 14-Feb-2013 15:17:28
% Create figure
figure1 = figure;

%%To incorporate the position and dimension of the figure
%set(figure1,'units','centimeters','position',[30 15 8.5 6.0])

% Create axes

axes1 = axes('Parent',figure1,'TickDir','out',...
    'Position',[0.201863354037267 0.162995594713656 0.762142857142857 0.762004405286344],...
    'FontSize',12,...
    'XTickLabel',{'0','0.25','0.5','0.75','1','1.25','1.5'},...
    'XTick',[0 0.25 0.5 0.75 1 1.25 1.5],...
    'FontName','Times New Roman');
%% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[0 1.7]);
hold(axes1,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'Parent',axes1,'LineWidth',2);
set(plot1(1),'Color',[1 0 0],'DisplayName','Black-necked Stilt');
set(plot1(2),'LineStyle','-.','Color',[0 0 1],...
    'DisplayName','American Avocet');
set(plot1(3),'LineStyle',':',...
    'Color',[0.168627455830574 0.505882382392883 0.337254911661148],...
    'DisplayName','Tundra Swan');

% Create xlabel
xlabel({'Water depth (m)'},'FontSize',12,'FontName','Times New Roman');

% Create ylabel
ylabel({'Habitat suitability index'},'FontSize',12,...
    'FontName','Times New Roman');

% Create legend
legend1 = legend(axes1,'show');
% set(legend1,'EdgeColor',[1 1 1],'YColor',[1 1 1],'XColor',[1 1 1],...
%     'Position',[0.578975404566412 0.171868251705968 0.434782608695652 0.240822320117474]);
set(legend1,...
    'Position',[0.703350117527615 0.212488101476568 0.256926956164747 0.13408521585596],...
    'EdgeColor',[1 1 1]);

% Create textbox
annotation(figure1,'textbox',...
    [0.0384131527672541 0.922490541591087 0.0861850443599493 0.0477941176470589],...
    'String',{'Excellent'},...
    'FontSize',12,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.0882016262654316 0.156102228556621 0.0595690747782001 0.0477941176470588],...
    'String',{'Poor'},...
    'FontSize',12,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none');
