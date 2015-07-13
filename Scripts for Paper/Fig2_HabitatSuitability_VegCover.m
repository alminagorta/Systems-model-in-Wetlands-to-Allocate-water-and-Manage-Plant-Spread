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
%   The entire code or part may be used for any non-commercial purpose so as long as the use is cited. Use for any commercial purpose requires 
%   prior written permission from the author.


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

