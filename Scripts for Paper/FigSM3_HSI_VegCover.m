%% Figure SM3 Plotting HSI Coverage Vegetation distribution during the year for each individual units

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

%Input: 1) Excel file "PlotFunctionsPaper" 
close all; clear all;clc;
[HSI_CVinv,text9]=xlsread('PlotFunctionsPaper.xlsx','SM3','D1:AB13');

figure('Name','HSI Vegetation Cover')
set(gcf,'position',get(0,'screensize'))
for k9=1:25
     %saving individual files
    unit9=genvarname(text9{k9}) ;
    %plotting
    subplot(5,5,k9);
    bar(HSI_CVinv(:,k9));
   %To set only ylabel to one unit
   if k9==23,xlabel('Month','fontsize',20,'FontName','Times New Roman'); end
    %To set only ylabel to one unit
   if k9==11,ylabel({'Habitat Suitability of';'Vegetation Cover'},'fontsize',20,'FontName','Times New Roman');end
   %ylim([0 1.5])  ylabel({2010;'Population';'in Years'})
    title(unit9(2:end),'FontSize',12,'FontName','Times New Roman');
    
    axis([1 12 0 1])
    set(gca,'FontSize',11,...
    'FontName','Times New Roman','XTick',[2 4 6 8 10 12],'YTick',[0 1])
    
  % axis tight
end