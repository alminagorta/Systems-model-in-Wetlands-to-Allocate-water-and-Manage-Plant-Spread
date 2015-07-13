%% Figure 6- Spatially and temporally map HSI composed- 
%Updated: July 3-2015
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

close all; clear all; clc;
I=imread('units.tif');
Igrey=rgb2gray(I);

%First identify the coordenates x,y,z
W=Igrey(:,300:350);
% Identify the value (162) and reemplaze (170)
iq=W==162;
W(iq)=170;
Igrey(:,300:350)=W;

U=dataset('xlsfile','unit.xlsx');
ID1=U.Values;
Name2=U.Unit;
x=U.X;
y=U.Y;


% Create textbox
annotation('textbox',...
    [0.0111278914747058 0.877737226277371 0.0910518053375196 0.071129046966679],...
    'String',{'Excellent'},...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none');

% Create textbox
annotation('textbox',...
    [0.0383469513025919 0.0941277833855477 0.0806326530612243 0.0448113207547169],...
    'String',{'Poor'},...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none');