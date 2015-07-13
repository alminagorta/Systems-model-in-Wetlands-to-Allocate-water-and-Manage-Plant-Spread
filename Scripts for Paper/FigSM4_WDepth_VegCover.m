%% Figure SM4- Habitat Suitability for Bird Species
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

%%
% Ploting Wdepths under different Initial VegetationCover for three cases
%Update June 2015
[WD_AutGate,text16]=xlsread('PlotFunctionsPaper.xlsx','Wdepth_byDiffeVegCover','D3:AB15'); % Initial Veg.Cover using 2008Landsat downscaling-10% vegResp-Automaic Gates
[WD_0x,text16]=xlsread('PlotFunctionsPaper.xlsx','Wdepth_byDiffeVegCover','D20:AB32'); %No Initial Veg.Cover
[WD_3x,text16]=xlsread('PlotFunctionsPaper.xlsx','Wdepth_byDiffeVegCover','D37:AB49'); %Three fold - Initial Veg.Cover

figure('Name','WaterDepth_IniVcover')
set(gcf,'position',get(0,'screensize'))


for k4=1:25
     %saving individual files
    unit4=genvarname(text16{k4}) ;
    %plotting
    subplot(5,5,k4);
%   WD3=[WD(:,k4),WD2(:,k4)];
    plot(WD_0x(:,k4),'-','LineWidth',1.5,'Color',[0.700   0.900   1.000]); hold off %Zero Initial vegetation cover-lightskyBlue
    hold on
    plot(WD_AutGate(:,k4),'--b','LineWidth',1.5)%2008-downscaled
    plot(WD_3x(:,k4),'-.','LineWidth',1.5,'Color',[25 25 112]/255)%three fold-midnightblue
   %To set only ylabel to one unit   
   if k4==23,xlabel('Month','fontsize',20,'FontName','Times New Roman');
   set(get(gca, 'XLabel'), 'Position', [-7.5 -1.5 0]); % adjust position
   end
    %To set only ylabel to one unit
    if k4==11,ylabel('Water Depth (m)','fontsize',20,'FontName','Times New Roman');end
   %ylim([0 1.5])
    title(unit4(2:end),'FontSize',12,'FontName','Times New Roman');
    hold off
   %axis tight
   axis([1 12 0 3.6]);
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

hleg = legend('No invasive vegetation','2008 initial cover','3x2008 initial cover');
set(hleg,'Orientation','horizontal',...
    'Position',[0.389322656391173 0 0.521023311797367 0.0570274759722755],...
    'FontSize',12,...
    'box','off',...
    'FontName','Times New Roman');