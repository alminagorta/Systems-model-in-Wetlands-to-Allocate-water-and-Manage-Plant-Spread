%% Fig. 7 - Plot Water Availab vs Weighted Usable Area
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

%Here is considering sum of inflow from 3 sources
[data,text]=xlsread('PlotFunctionsPaper.xlsx','WU_WAvaila','A2:E35'); % Initial Veg.Cover using 2008Landsat downscaling-10% vegResp-Automaic Gates

set(0,'DefaultFigureColor', 'white'); % sets the color to white

X11=data(:,1);%Water availability
Y11=data(:,2);%WU with three different initial vegetation cover
ID =text(:,4); % 
hScatter=gscatter(X11,Y11,ID)

%// Set colors manually. 
for k = 1:numel(hScatter)
set(hScatter(1),'Color',[0.700   0.900   1.000],'Marker','o','MarkerSize',6,'MarkerFaceColor',[0.700   0.900   1.000]);
set(hScatter(2),'Color','b','Marker','^','MarkerSize',6,'MarkerFaceColor','b');
set(hScatter(3),'Color',[25 25 112]/255,'Marker','s','MarkerSize',6,'MarkerFaceColor',[25 25 112]/255);
end

%Water Right  
line([52518.08 ; 52518.08],[600;1000],'color','r')
xlabel('Water availability (ha-m/year)','fontsize',18,'FontName','Times New Roman');  
ylabel('Weighted usable area for wetland (km^2)','fontsize',18,'FontName','Times New Roman');

set(gca,'XTickLabel',get(gca,'XTick'))
legend('No invasive vegetation','2008 initial cover', '3x 2008 initial cover','Location',[0.574948627671151 0.185657232110605 0.302739730959069 0.128930820309141])
