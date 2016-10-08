% DepthWeightedHSIArea.m
% Script to use water level-wetted area curves for wetland units to convert Habitat
% Suitability Indexes for water depth into depth varying
% suitable areas that consider the spatial
% distribution of water depths in a wetland unit at a particular water level. This script handles the first three of four
% steps of the method described in Section 3.4 and Eqs 2 and 3 to calculate
% suitable area. 
%
% INPUTS
%   ElevationAreaDataFile = Excel file with Elevation data in column A
%      and Area in Column C for each wetland unit. Also wetland unit minimum and maximum
%      elevations. Each wetland unit is on a separate worksheet.
%   HSIDataFile = Excel file with habitat suitability index curve parameters
%      for water depth for each target species.
%   n = number of rows (water levels) listed in the elevation-area tabular
%       input between the minimum and maximum elevations
%   s = number of species for which there are HSI curves
%
% OUTPUTS
%   Results = n by (1 + s) table where column 1 is a staff gage reading and Columns 2 to s+1 are the suitable areas for
%       each species (same area units as input) that consider the spatial distribution of water depths. %      
%
% METHOD
% 
%    1. Read in the habitat suitability of water depth curve parameters for each species - plot to verify readings
%       are correct
%    2. Read in the water level-area curves for each wetland unit plus the
%           min and max water levels
%    3. For an individual wetland unit and species
%        3.1 Iterate over the min and max water levels in the wetland unit:
%           3.1.1  At each water level, divide the wetland unit into zones
%                  where all points in the zone have the same water depth. Zone water depths will vary from 0 to the water level. For each zone:
%                3.1.1.1 Calculate zone area as the difference in wetted
%                areas between the current zone and prior zone (zone with slightly shallower water depth)
%                3.1.1.2 Calculate zone water depth as difference between  the current water level (step 3.1.1) and zone level
%                3.1.1.3 Calculate HSI for species and zone using the zone water depth (step 3.1.1.2)
%                3.1.1.4 Multiply HSI for zone (step 3.1.1.3) by the zone area (step 3.1.1.1)
%           3.1.2 Sum multiplications in step 3.1.1.4 to get a suitable
%           area for the current water level and species. This suitable
%           area considers the spatial distribution of water depths in the
%           wetland unit
%         3.2 Compile a table of water levels versus suitable areas for each wetland unit and species
%         3.3 Fit a curve to the table in Step 3.2 to specify a suitable area of water depth function for each wetland unit i and species s, e.g., dvs_i_s(WD_i,t)
%     4. Substitute the curves into the model objective function for the
%     current hsi_i,s(WD_i,t)*A_i(WD_i,t) term (Done in GAMS)
%
% Script plots the suitable area results for each wetland unit (individual species and total for all species) and
% compares to the prior method that assumes the entire wetland unit is at a
% depth equivalent to the staff gage reading

%%
%Updated: March 22, 2016
%Developed by David E. Rosenberg
%Dept. of Civil & Environmental Engineering and Utah Water Research Lab
%Utah State University
% david.rosenberg@usu.edu  
%Modified by Omar Alminagorta
%alminagorta@gmail.com
%%
% If you use the code, cite as:
% Alminagorta, O., D. E. Rosenberg, and K. M. Kettenring, Systems modeling to improve  the  hydro-ecological  performance  of
% diked  wetlands, (Under Review to resubmit to Water Resources Research Journal).

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

%% Step 1. Set up and read in values from Excel Inputs
%Read in Excel Inputs
ElevationAreaDataFile = 'Lidar_data.xls';
HSIDataFile = 'BRMBR_Input.xls';
%Define Wetland Units
vWUs = {'1' '1A' '1B' '2A' '2B' '2C' '2D' '3A' '3B' '3C' '3D' '3E' '3F' '3G' '3H' '3I' '3J' '3K' '4A' '4B' '4C' '5A' '5B' '5C' '5D'}; %ignore 5D for plot clarity??-OA-I included 5D to create the excel file
nWUs = length(vWUs);
%Define plot attributes for each species
specNames = {'American avocet' 'Black-necked stilt' 'Tundra swan'};
specColors = [0 0 1; 1 0 0; 0.168627455830574 0.505882382392883 0.337254911661148];
lStyle  = {'-.' '-'  ':'};
lWidth = 2;

%Read in the HSI parameters
[num,str] = xlsread(HSIDataFile,'BirdSpec','A:A');
s = length(str);
HSIparams = xlsread(HSIDataFile,'Param_HW','B2:H2');

%construct the HSI alias functions
hsi = cell(1,s);
hsi{1} = @(WDepth,PHW) exp(-((WDepth-PHW(1)).^2/(2*PHW(2).^2)));
hsi{2} = @(WDepth,PHW) exp(-((WDepth-PHW(3)).^2/(2*PHW(4).^2)));
hsi{3} = @(WDepth,PHW) WDepth*PHW(5)+PHW(6)*(1-exp(-PHW(7)*WDepth));

%Plot HSI curves versus water depth to verify the curves were read
%correctly
hHSIVerify = zeros(1,s);
legtext = cell(1,s);

fig1 = figure;
for i=1:s
     hHSIVerify(i) = plot([0:.01:2],hsi{i}([0:.01:2],HSIparams),'color',specColors(i,:),'linestyle',lStyle{i},'linewidth',lWidth);
    if i==1
        hold on
    end
    legtext{i} = sprintf('Species %d',i);
end
xlabel('Water depth (m)');
ylabel('Habitat suitability index');
legend(specNames);

%Creat a matrix plot of results for each wetland unit-OA_This is to omit the
%plot of HSI
%hRes = figure('units','normalized','outerposition',[0 0 1 1]);

%Record max areas
vMaxAreas = zeros(nWUs,1);
hPlot = zeros(nWUs,1);

fig2=figure;

header={'StaffGage','DVS-Spe1(Ha)','DVS-Spe2(Ha)','DVS-Spe3(Ha)','Total-DVS(Ha)','RawLidar(Ha)','Old-Spe1(Ha)','Old-Spe2(Ha)','Old-Spe3(Ha)','Total-OldWU(Ha)'} ;

%Loop over wetland units
for i=1:length(vWUs)
    %Read in the raw data
    LevelArea = xlsread(ElevationAreaDataFile,vWUs{i},'A:C');
    MinElev = xlsread(ElevationAreaDataFile,vWUs{i},'H14');
    MaxElev = xlsread(ElevationAreaDataFile,vWUs{i},'H11');
    
    %Filter data to within min and max elevations. 
    LevelAreaFilt = LevelArea(((LevelArea(:,1) <= MaxElev) + (LevelArea(:,1) >= MinElev) == 2),[1 3]);
    %Covert water level in feet to meters
    LevelAreaFilt(:,1) = LevelAreaFilt(:,1)/3.28084;
    %Convert area in acres to Hectares
    LevelAreaFilt(:,2) = LevelAreaFilt(:,2)*0.404686; 
    
    %Count rows in filtered data
    n = size(LevelAreaFilt,1);
    
    %Calculate zone area as change in wetted area across each water level increment. Covert
    %acres to hectares (10,000 m2)
    ZoneArea = diff(LevelAreaFilt(:,2));
    
    %Create the results matrix
    Results = zeros(n,s+2);
    %First column of results is water levels
    Results(:,1) = LevelAreaFilt(:,1) - LevelAreaFilt(1,1);
        
    %Iterate over water levels
    for j=1:n
        %Calculate water depth in each zone. Depth = water level - level at bottom of zone
        ZoneDepths = LevelAreaFilt(j,1) - LevelAreaFilt(1:j-1,1);
        %iterate over species
        for k=1:s
            %Caclulate suitable area for each zone as produce of the
            %suitabile index and zone area. Add suitable areas across zones
            Results(j,k+1) = sum(ZoneArea(1:j-1).*hsi{k}(ZoneDepths,HSIparams));
        end
    end 
    
    %Sum over the species
    Results(:,2+s) = sum(Results(:,2:1+s),2);
    
    %Calculate HSI by staff gage depth (old) method for comparison
    % sum over species of [hsi_s(WD)] * area(WD)
    HW = zeros(n,s); %Habitat suitability of water depth
    for k=1:s
        HW(:,k) = hsi{k}(Results(:,1),HSIparams);
    end
    
    HWarea = sum(HW(:,1:s),2).*LevelAreaFilt(:,2); %HSI at staff gage reading assuming all area is flooded area
    HWareaSpec = HW(:,1:s).*repmat(LevelAreaFilt(:,2),1,s); %HSI at staff gage reading for individual species assuming all area is flooded area
    
    %Plot of the Results and original elevation area-curve
    hPlot(i) = subplot(5,5,i);
    hold on
    %original water level-area curve (LIDAR data)
     plot(Results(:,1),LevelAreaFilt(:,2),'color',[0 0 0],'linewidth',lWidth+1,'linestyle','-','marker','none')
    %Results - depth-HSI weighted area curves for each species
    for k=1:s
        plot(Results(:,1),Results(:,1+k),'linewidth',lWidth,'color',specColors(k,:),'linestyle',lStyle{k},'marker','none')
    end
    %OA- This is what is label as "Total Old"
    %plot(Results(:,1),HWarea,'linewidth',1.5,'marker','none');
    
    if i==23,xlabel('Staff gage reading (m)','fontsize',20,'FontName','Times New Roman'); end
    if i==11,ylabel('Area (Ha)','fontsize',20,'FontName','Times New Roman');end
    set(gca,'xLim',[0 3]);
    %set(gca,'FontSize',11,'FontName','Times New Roman','XTick',[0:1:3])
    title(sprintf('Unit %s',vWUs{i}));
    hold off
    
    %Record the maximum area for later setting of plot limits on all
    %subplots
    vMaxAreas(i) = max(Results(:,5));   
    
    %OA_To save the parameters
selec=[Results,LevelAreaFilt(:,2),HWareaSpec,HWarea];

%To write an excel file 
  xlswrite('SuitableAreaDepthVarying.xls', header, vWUs{i},'A1');
  xlswrite('SuitableAreaDepthVarying.xls', selec, vWUs{i},'A2');
  clear selec ;
end

%Finish up the plot
%for i=1:nWUs
%    axis(hPlot(i),[0 3 0 max(vMaxAreas)])
%end
lng= legend({'Flooded area (LiDAR)' specNames{:}}); % 'Suitable area - depth varying' 'Suitable area - from wetted area'});
set(lng,'FontSize',12);


