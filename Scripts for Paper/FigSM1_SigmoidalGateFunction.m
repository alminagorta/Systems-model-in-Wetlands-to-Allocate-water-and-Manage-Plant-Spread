%% Figure SM1: Sigmoidal function- Gate Management
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

%% Code to plot Sigmoidal Function 
close all, clear all, clc
[A,textA]=xlsread('PlotFunctionsPaper.xlsx','Sigmoid','A1:C2100');
X1=A(:,1);
Y1=A(:,2);
Y2=A(:,3);


 YMatrix1=[Y1,Y2];
% %Here is the fucntion in Matlab to create the plot
FunctionNeededToFigSM1 (X1, YMatrix1);
