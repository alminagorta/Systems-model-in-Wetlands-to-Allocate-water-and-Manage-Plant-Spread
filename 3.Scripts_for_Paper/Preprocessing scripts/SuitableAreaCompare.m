%SuitableAreaCompare.m
%
%Plot suitable area results in SuitableAreaDepthVarying.xls to compare suitably area by vertical tank and depth varying approaches
%Used to generate species-specific figures shown in response letter to
%Reviewer Comments - April 2016
%David Rosenberg -17April2016 to better fit curves

%input data from 'SuitableAreaDepthVaying.xls' (staff gage vs suitable area for each species and wetland unit)
%output:parameters of the equations
%
%% Code for Species 1 and 2:Just change hsi data and label of the last block
close all; clear all;clc
%Units 
textx={'1','1A','1B','2A','2B','2C','2D','3A','3B','3C','3D','3E','3F','3G','3H','3I','3J','3K','4A','4B','4C','5A','5B','5C','5D'}; 

figs = zeros(3,1);
specnames = {'American avocet' 'Black-necked stilt'  'Tundra swan'};
scennames = {'Vertical tank' 'Depth varying'};
 param =[];
 nm=[];
 s=3; %number of species
 nScens = size(scennames,2); %Number of scenarios
 cLegendEntries = {};
 
 %Colors for species traces - blues,Reds,  greens; dark to light
 mColors = [0.15	0.06	0.6; 0.562	0.495	0.9; 0.6	0.06	0.06; 0.9	0.495	0.495;  0.42	0.6	0.06; 0.765	0.9	0.495];

 % Handles for the species functions
 hSpecFunc = cell(3,1);
 hSpecFun{1} = @(my_par,staffgage) my_par(3)*( exp(-((staffgage-my_par(1)).^2/(2*my_par(2).^2)))) + my_par(6)*( exp(-((staffgage-my_par(4)).^2/(2*my_par(5).^2))));% Double gaussian
 hSpecFun{2} = hSpecFun{1};
 %hSpecFun{3} = @(my_par,staffgage) my_par(1)*staffgage.^4 + my_par(2)*staffgage.^3 + my_par(3)*staffgage.^2 + my_par(4)*staffgage +my_par(5); %4th-order polynomial
 hSpecFun{3} = @(my_par,staffgage) my_par(1)*exp(-my_par(2)*exp(-my_par(3).*staffgage));    %Gompertz curve
 
    for i=1:25;%input the 25 wetland units
        % Input data from excel
        [data,text]= xlsread('SuitableAreaDepthVarying.xls', textx{i});

        staffgage=data(:,1);%Wdepth in m.
        
        %To plot together       
        SpecSet = [1 2 3];
        for j=SpecSet %work each species
             if i==1
                %create the figure
                figs(j)  = figure('units','normalized','outerposition',[0 0 1 1]);
             end
            
             %Make the figure for the species active
             figure(figs(j));
             subplot(5,5,i);
            plot(staffgage,data(:,3+s),'color',[0 0 0],'linewidth',3.5,'linestyle','-','marker','none'); hold on %Plot wetted area in thick black

            
            hsi=data(:,1+j);%Area in ha- for species
            nm=[nm;{specnames{j} textx{i}}];

            plot(staffgage,data(:,3+s+j),'color',mColors((j-1)*nScens+2,:),'linewidth',1.5,'linestyle','-.','marker','none'); %Plot old HSI area at wetted area in dashed light blue
            plot(staffgage,hsi,'color',mColors((j-1)*nScens+1,:),'linewidth',2,'linestyle','-','marker','none');%Original depth-varying HSI area data in blue            
            %plot(staffgage,new_hsi,':r','LineWidth',2); hold off;%Simulated in red
            title(textx(i),'Fontsize',16);
        
            %set y lim to zero
            yLimCurr = get(gca,'yLim');
            set(gca,'yLim',[0 yLimCurr(2)]);

             if i==23,xlabel('Staff gage reading (m)','fontsize',20,'FontName','Times New Roman'); end
             if i==11,ylabel('Area (Ha)','fontsize',20,'FontName','Times New Roman');end              
             
             hold off
        end            
    end 

    %create legends on each figure
      for j=SpecSet
        figure(figs(j))
            for k=1:nScens
                 %cLegendEntries{1,(j-1)*nScens+k} = sprintf('%s (%s)',specnames{j},scennames{k});
                 cLegendEntries = {cLegendEntries{:} sprintf('Suitable area - %s',scennames{k})};
            end
            
            set(figs(j),'Name',specnames{j})
        
        legend({'Wetted area (LIDAR)' cLegendEntries{:}},'FontSize',14,'position',[0.8072 0.8973 0.1913 0.1011]);   
    end

     
