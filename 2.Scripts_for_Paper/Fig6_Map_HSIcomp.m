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