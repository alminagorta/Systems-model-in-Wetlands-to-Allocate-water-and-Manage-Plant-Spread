%% Figure 5- Water depth Simulated and Optimized
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

[WD,text9]=xlsread('PlotFunctionsPaper.xlsx','Fig5','D1:AB13'); %Here is the Water Depth Optimized
[WD2,text11]=xlsread('PlotFunctionsPaper.xlsx','Fig5','D19:AB31'); %Here is the Water Depth Simulated

for k4=1:25
     %saving individual files
    unit4=genvarname(text9{k4}) ;
    %plotting
    subplot(5,5,k4);
%   WD3=[WD(:,k4),WD2(:,k4)];
    bar(WD2(:,k4),0.6);% Simulation Depth
    hold on
    plot(WD(:,k4),'-r','LineWidth',1.5); hold off %Optimization Water depth
   %To set only ylabel to one unit
   
   if k4==23,xlabel('Month','fontsize',20,'FontName','Times New Roman'); end
    %To set only ylabel to one unit
    if k4==11,ylabel('Water Depth (m)','fontsize',20,'FontName','Times New Roman');end
   %ylim([0 1.5])
    title(unit4(2:end),'FontSize',12,'FontName','Times New Roman');
    hold off
   %axis tight
   axis([1 12 0 3]);
    set(gca,'FontSize',11,...
    'FontName','Times New Roman','XTick',[2 4 6 8 10 12])
for i=1:5
if k4==i set(gca, 'XAxisLocation', 'top');end
end

for j=0:5:25
if k4==j set(gca, 'YAxisLocation', 'right');end
end

for l= [2,3,4,7,8,9,12,13,14,17,18,19,22,23,24]
if k4==l set(gca,'YTick',[]); end
end 

for m= [6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
if k4==m set(gca,'XTick',[]); end
end

end

hleg = legend('Previous Management','Model Recommendation');
   
set(hleg,'Orientation','horizontal',...
    'Position',[0.555067372972596 0.0110239385102722 0.37124183006536 0.0521551724137931],...
    'FontSize',12,...
    'FontName','Times New Roman');
