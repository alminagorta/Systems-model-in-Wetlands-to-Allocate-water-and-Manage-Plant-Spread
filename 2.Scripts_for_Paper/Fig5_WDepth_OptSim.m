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
