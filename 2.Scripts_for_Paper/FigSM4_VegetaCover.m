%% Figure SM2 - CVegetation distribution during the year for each individual units (In Percentage)
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


%%
close all; clear all;clc;

[CVinvasive,text9]=xlsread('PlotFunctionsPaper.xlsx','SM2','D1:AB13');

figure('Name','VegetationCover (%)')
set(gcf,'position',get(0,'screensize'))

for k9=1:25
     %saving individual files
    unit9=genvarname(text9{k9});
    %plotting
    subplot(5,5,k9);
    bar(CVinvasive(:,k9)*100,0.6);
    hold on
    %line([1  12],[(InitCV_iv(:,k9)) (InitCV_iv(:,k9))],'Marker','.','LineStyle','-','Color','r') 
   %To set only ylabel to one unit
   if k9==23,xlabel('Month','fontsize',20,'FontName','Times New Roman'); end
    %To set only ylabel to one unit
    if k9==11,ylabel({'Invasive Vegetation';'Cover (%)'},'fontsize',20,'FontName','Times New Roman');end
   %ylim([0 6])
    title(unit9(2:end),'FontSize',12,'FontName','Times New Roman');
    hold off
   axis tight
   axis([1 12 0 6.0])
   set(gca,'FontName','Times New Roman','YTick',[0 3 6.0])
   set(gca,'FontName','Times New Roman','XTick',[2 4 6 8 10 12])
 % set(gca,'FontSize',11)
end      
