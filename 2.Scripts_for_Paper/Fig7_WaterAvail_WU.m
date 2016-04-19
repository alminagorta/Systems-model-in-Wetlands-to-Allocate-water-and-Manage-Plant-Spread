%% Fig. 7 - Plot Water Availab vs Weighted Usable Area
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
% 52518.08 - before
%  89300.0- ha-m/year -after workshop with the Refuge. They mentioned 1000 cfs water
% right


%Water Right  
line([89300.0 ; 89300.0],[0;900],'color','r')
%line([89300.0 ; 89300.0],[550;900],'color','r')
xlabel('Water availability (ha-m/year)','fontsize',18,'FontName','Times New Roman');  
ylabel('Weighted usable area for wetland (km^2)','fontsize',18,'FontName','Times New Roman');
%ylim([0 1070])
set(gca,'XTickLabel',get(gca,'XTick'))
legend('No invasive vegetation','2008 initial cover', '3x 2008 initial cover','Refuge’s annual water right','Location',[0.554948627671151 0.185657232110605 0.302739730959069 0.128930820309141])


