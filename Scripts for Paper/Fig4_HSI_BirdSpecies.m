%% Figure Habitat Suitability for Bird Species
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

%Input: 1) Excel file "PlotFunctionsPaper" and 2) "FunctionNeededToFig7'


close all; clear all;clc;
%to set a white background
set(0,'DefaultFigureColor', 'white'); 
%Getting the file
[A7,textA7]=xlsread('PlotFunctionsPaper.xlsx','HSI_birds','A6:D707');

Wd=A7(:,1); %water depth
Sp1=A7(:,2); Sp2=A7(:,3); Sp3=A7(:,4); %species.

%To use the function
YMatrix7=[Sp1,Sp2,Sp3];
FunctionNeededToHSI_BirdSpecies(Wd, YMatrix7);

