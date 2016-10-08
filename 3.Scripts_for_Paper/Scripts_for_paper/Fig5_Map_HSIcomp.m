%% Figure 5- Spatially and temporally map HSI composed- 
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

close all; clear all; clc;
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
HSI_comp=dataset('xlsfile','PlotFunctionsPaper.xlsx','sheet','HSIcomp','range','A1:E300','ReadVarNames','off');

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

%OA_To add label units
% text(x(i),y(i),Name2(i), 'FontSize',8);

end
subplot(4,3,j); 
% To map the results
   imagesc((Igreym));
% contour (flipud(Igrey),'Color','k','LineWidth',0.8);
 
    %colormap(pink);
    colormap(flipud(pink));

% view(2)
 xlim([50 400]) ;
ylim([0 250]);
axis off;
% title([monthName(j)],'FontSize',14,'FontName','Times New Roman');
hold on ;
contour ((Igrey),'Color','k','LineWidth',0.8);
%    mesh(flipud(Igreym));
% alphamap(0.01);


   
%OA_To make bigger the refuge
axis fill

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

% To put the names of the units
% for i=1:length(cName);
% text(x(i),y(i),Name2(i));
% end

% Create textbox
annotation('textbox',...
    [0.0111278914747058 0.877737226277371 0.0910518053375196 0.071129046966679],...
    'String',{'Excellent'},...
    'FontSize',18,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none');

% Create textbox
annotation('textbox',...
    [0.0383469513025919 0.0941277833855477 0.0806326530612243 0.0448113207547169],...
    'String',{'Poor'},...
    'FontSize',18,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none');
%% Call-outs Wetlan Units  
% Create textarrow
annotation('line',[0.263723876009835 0.283854166666667],...
    [0.809115393040125 0.869618696186962]);

% Create textbox
annotation('textbox',...
    [0.27834375 0.869003690036899 0.0219166666666665 0.0381303813038126],...
    'String','4B',...
    'FontSize',14,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

% Create textarrow
annotation('line',[0.228307209343169 0.244270833333333],...
    [0.846015762043814 0.890528905289053]);

% Create textbox
annotation('textbox',...
    [0.239541666666667 0.900369003690037 0.0292083333333333 0.0270602706027057],...
    'String',{'2B'},...
    'FontSize',14,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);


%% To export Figure 5 to publish format : 
%Details are specified on the export_fig file:This files export as full scream show and the commands 
%https://github.com/altmany/export_fig/blob/master/README.md

export_fig Fig5_600dpi.tif -r600
