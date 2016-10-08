%% Fig. 6 - Plot Water Availab vs Weighted Usable Area
%Updated: April-2016
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

%% Inflow
[data,text1]=xlsread('PlotFunctionsPaper.xlsx','WU_WAvaila','A2:E35'); % Initial Veg.Cover using 2008Landsat downscaling-10% vegResp-Automaic Gates

set(0,'DefaultFigureColor', 'white'); % sets the color to white

% X1=data(:,1);%Water availability
X1=data(:,1)*0.01;%Water availability
YMatrix1=data(:,2);%WU with three different initial vegetation cover
ID =text1(:,4); % 4
Label=text1(:,1);
hScatter=gscatter(X1,YMatrix1,ID)
% text(Label);



%// Set colors manually. 
for k = 1:numel(hScatter)
set(hScatter(1),'Color',[0.700   0.900   1.000],'Marker','o','MarkerSize',6,'MarkerFaceColor',[0.700   0.900   1.000]);
set(hScatter(2),'Color','b','Marker','^','MarkerSize',6,'MarkerFaceColor','b');
set(hScatter(3),'Color',[25 25 112]/255,'Marker','s','MarkerSize',6,'MarkerFaceColor',[25 25 112]/255);

end

%  89300.0- ha-m/year -1000 cfs water right


%Water Right  
% line([89300.0 ; 89300.0],[550;900],'color','r'); In ha-m
line([893.0 ; 893.0],[550;900],'color','r');%In MCM
% xlabel('Water availability (ha-m/year)','fontsize',18,'FontName','Times New Roman');  

xlabel('Water availability (MCM/year)','fontsize',18,...
    'FontName','Times New Roman'); %in million of cubic meters
ylabel('Weighted usable area for wetland (km^2)','fontsize',18,'FontName','Times New Roman');

%ylim([0 1070])
set(gca,'XTickLabel',get(gca,'XTick'),'fontsize',14)
legend('No invasive vegetation','2008 initial cover', '3x 2008 initial cover','Refuge’s annual water right','Location',[0.554948627671151 0.185657232110605 0.202739730959069 0.128930820309141])


% ax=gca
% ax.TickDir = 'out';
%% To create the axis of years [above]

% text(180000,920,'Year availability observed','FontSize',18,'FontName','Times New Roman');
% 
% % xt = [57147.27 92539.58 102296 118070 121813 184136 197390 234687 237375 405997 434857];
% xt = [47147.27 76539.58 92396 109070 125813 180136 197390 220687 237375 400997 430857]*0.01;
% yt = [907 907 907 907 907 907 907 907 907 907 907];
% str = {'1992','2004','2007','2008','2010','2009','1996','2005','2006','2011','1997'};
% text(xt,yt,str)

%% To export Figure 6 to publish format : 
%Details are specified on the export_fig file:This files export as full scream show and the commands 
%https://github.com/altmany/export_fig/blob/master/README.md

 export_fig Fig6_600dpi.tif -r600
%  export_fig Fig6_1200dpi.tif -r1200
% %When exporting to vector format (pdf & eps), this function requires that ghostscript is installed on your system. You can download this from: 
% % http://www.ghostscript.com 
%    
%  export_fig Fig6.pdf 
