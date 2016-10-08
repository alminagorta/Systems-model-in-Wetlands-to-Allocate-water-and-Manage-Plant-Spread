%% Code to show the SWAMPS results
%Updated: May 14- 2016
%Developed by Omar Alminagorta
%Dept. of Civil & Environmental Engineering and Utah Water Research Lab
%Utah State University
% o.alminagorta@aggiemail.usu.edu  
%
%% This code graphically display results from the SWAMPS code and create the following figures:
% 1)Water allocation for each wetland unit 
% 2)Invasive vegetation cover
% 3)Habitat Suitability related to invasive vegetation cover
% 4)Weighted Usable Area 
% 5) Map of the composed habitat suitability
%%
% If you use the code, cite as:
% Alminagorta, O., D. E. Rosenberg, and K. M. Kettenring, Systems modeling to improve  the  hydro-ecological  performance  of
% diked  wetlands, (Under Review, Water Resources Research Journal).

%%   Licensing:
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

%  close all; clear all; clc;
%% Water depth- Bar plot Simulation and Optimization
% close all; clear all; clc;
%To expand the figure full screen 
figure('Name','wdepth','units','normalized','outerposition',[0 0 1 1])

[WD,text9]=xlsread('Result.xlsx','CheckWater','D36:AB49'); %Here is the Water Depth Optimized

for k4=1:25
     unit4=genvarname(text9{k4}) ;
    %plotting
    subplot(5,5,k4);
        hold on
    bar(WD(:,k4),0.6); hold off %Optimization Water depth
     if k4==23,xlabel('Month','fontsize',20,'FontName','Times New Roman'); end
    if k4==11,ylabel('Water Depth (m)','fontsize',20,'FontName','Times New Roman');end
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

hleg = legend('Model Recommendation','Previous Management');
% Make the text of the legend italic and color it brown 
set(hleg,'Orientation','horizontal',...
    'Position',[0.555067372972596 0.0110239385102722 0.37124183006536 0.0521551724137931],...
    'FontSize',12,...
    'FontName','Times New Roman');

 
%% Plotting Vegetation Cover distribution during the year for each individual units (In Percentage)

[CVinvasive,text9]=xlsread('Result.xlsx','CheckCV','D31:AB43');

figure('Name','VegetationCover')
set(gcf,'position',get(0,'screensize'))

for k9=1:25
     %saving individual files
    unit9=genvarname(text9{k9});
    %plotting
    subplot(5,5,k9);
    bar(CVinvasive(:,k9)*100,0.6);
    hold on
    if k9==23,xlabel('Month','fontsize',20,'FontName','Times New Roman'); end
    %To set only ylabel to one unit
    if k9==11,ylabel({'Invasive Vegetation';'Cover (%)'},'fontsize',20,'FontName','Times New Roman');end
    title(unit9(2:end),'FontSize',12,'FontName','Times New Roman');
        
    hold off
   axis tight
   %axis([1 12 0 1])
   set(gca,'FontSize',11,...
    'FontName','Times New Roman','XTick',[2 4 6 8 10 12])
end     

%% Plotting HSI Coverage Vegetation distribution during the year for each individual units

[HSI_CVinv,text9]=xlsread('Result.xlsx','CheckCV','D61:AB74');

figure('Name','HSI_Vegetation_Cover')
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
    
end

%% WUAW distribution during the year for each individual units

[WUAW,text8]=xlsread('Result.xlsx','CheckWater','D86:AB99');

figure('Name','WUAW','units','normalized','outerposition',[0 0 1 1])
%k is equal to number of units
for k8=1:25
     %saving individual files
    unit8=genvarname(text8{k8}) ;
    %plotting
    subplot(5,5,k8);
    bar(WUAW(:,k8)/1000000); %passing to Km2
   %To set only ylabel to one unit
   if k8==23,xlabel('Month','fontsize',18,'FontName','Times New Roman'); end
    %To set only ylabel to one unit
   if k8==11,ylabel('WUAW (Km^2)','fontsize',18,'FontName','Times New Roman');end
   %ylim([0 1.5])
    title(unit8(2:end),'FontSize',12,'FontName','Times New Roman');
  axis tight
  set(gca,'FontSize',11,...
    'FontName','Times New Roman','XTick',[2 4 6 8 10 12])
  %axis([1 12 0 1])
end

%% HSI composed- Spatially and temporally map 
% close all; clear all; clc;
I=imread('units2.tif');
Igrey=rgb2gray(I);
W=Igrey(:,300:350);
iq=W==162;
W(iq)=170;
Igrey(:,300:350)=W;

%9.1.3 Reading excell between number of map and Units name
U=dataset('xlsfile','unit2.xlsx');
ID1=U.Values;
Name2=U.Unit;
x=U.X;
y=U.Y;

%HSI composed :Using Dataset,Output 
HSI_comp=dataset('xlsfile','Result.xlsx','sheet','HSIcomp','range','A1:E300','ReadVarNames','off');

%Selecting colums 
Umonth1=nominal(HSI_comp.Var2);
UName2=HSI_comp.Var4;
HSIspec1=HSI_comp.Var5;
%To set names to the plot (missing to incorporate)
monthName={'Jan'  'Feb'  'Mar'  'Apr'  'May'  'Jun'  'Jul'  'Aug'  'Sep'  'Oct'  'Nov'  'Dec'};

% Analyzing month by month and for one species
figure('Name','HSI_Composed_Map','units','normalized','outerposition',[0 0 1 1]);
set(gca,'Color','w');
set(gcf,'Color','w')
for j=1:12
ind1=(Umonth1==num2str(j));
%Selecting unit and values based on index1
uName2=UName2(ind1);
uResults3=HSIspec1(ind1); 

%Intersection of Units between Map Code and Values of GAMS 
[cName, iOr2, iuu2] = intersect(Name2,uName2);
Rmon1=uResults3(iuu2);
u1m=zeros(size(ID1));
%Getting only map of the results
u1m(iOr2)=Rmon1;
Igreym=NaN(size(Igrey));
for i=1:length(cName);
    inde=find(Igrey==ID1(iOr2(i)));
Igreym(inde)=Rmon1(i);
end
subplot(4,3,j); 
% To map the results
   mesh(flipud(Igreym));
    %colormap(pink);
    colormap(flipud(pink));
     view(2)
 xlim([50 400]) ;
ylim([0 250]);
axis off;
title([monthName(j)],'FontSize',14,'FontName','Times New Roman');
hold on ;
contour (flipud(Igrey),'Color','k','LineWidth',0.8);
   alpha(0.3);

whitebg('w')
set(gca,'Color','w');
set(gcf,'Color','w')

axis fill
clim=[0 1]; % Data range...
  caxis(clim);
  if j==1,
  h=colorbar;
  set(h,'position',[ 0.0921339998649555 0.104437593984962 0.01219 0.815],'AxisLocation','in',...
    'FontSize',14,...
    'FontName','Times New Roman');
 end

end
 

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
