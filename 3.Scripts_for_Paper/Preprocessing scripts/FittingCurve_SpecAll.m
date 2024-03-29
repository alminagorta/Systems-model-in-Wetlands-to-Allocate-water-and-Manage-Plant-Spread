%FittingCurve_SpecAll.m

%Script to find parameters that fit a smooth, nonlinear curve to the emperical suitable area
%versus water level relation (contained in the file
%SuitableAreaDepthVarying.xls output by DepthVaryingSuitableArea_OA.m)
%
%Created by Omar Alminagorta - 24March 2016
%Extended by David Rosenberg -29March2016 to better fit curves and plot

%Reads suitable area versus water level results in SuitableAreaDepthVarying.xls (generated by
%DepthVaryingSuitableArea_OA.m) then fits smooth, nonlinear functions to the
%data and stores the fitted parameters to Paramet_OutputHSI.xls and
%G_DWparams.gdx (for use in the optimization model)
%
% Also prints results to 4 plots
% Figure 1 (Figure S1 in supplemental material) - shows area versus staff
% gage water level reading for each wetland unit with 7 traces per plot:
%     - Wetted area (from LIDAR data; solid black line)
%     - Suitable area calcuations read in from SuitableAreaDepthVarying.xls for the three
%             priority bird species (solid blue, red, and green lines)
%    - Curve sfit to the suitable area calculations for the three priority
%           bird species (dashed blue, red, and green lines)
% Figures 2, 3, and 4: One figure per species. Each figure shows area versus staff gage water level reading for
%                each wetland unit with 4 traces :
%     - Wetted area (from LIDAR data; solid black line)
%     - Suitable area calculated by prior method that assumes entire wetland unit is at the water level in dashed light blue
 %    - Suitable area read in from SuitableAreaDepthVarying.xls calculated
 %           assuming spatial distribution of water depth at particular water level (blue stars)
 %    - Curve fitted to the depth varying suitable area calculations
 %           (dashed red)

%
%% Start
close all; clear all;clc
%Units 
textx={'1','1A','1B','2A','2B','2C','2D','3A','3B','3C','3D','3E','3F','3G','3H','3I','3J','3K','4A','4B','4C','5A','5B','5C','5D'}; 

%Handle for the four figures that will be created
figs = zeros(4,1);
specnames = {'Spec1' 'Spec2' 'Spec3'};
SpecNameFull = {'Avocet' 'Stilt'  'Swan'};
 param =[];
 nm=[];
 s=3; %number of species
 
 % Handles for the species functions
 hSpecFunc = cell(3,1);
 hSpecFun{1} = @(my_par,staffgage) my_par(3)*( exp(-((staffgage-my_par(1)).^2/(2*my_par(2).^2)))) + my_par(6)*( exp(-((staffgage-my_par(4)).^2/(2*my_par(5).^2))));% Double gaussian
 hSpecFun{2} = hSpecFun{1};
 %hSpecFun{3} = @(my_par,staffgage) my_par(1)*staffgage.^4 + my_par(2)*staffgage.^3 + my_par(3)*staffgage.^2 + my_par(4)*staffgage +my_par(5); %4th-order polynomial
 hSpecFun{3} = @(my_par,staffgage) my_par(1)*exp(-my_par(2)*exp(-my_par(3).*staffgage));    %Gompertz curve
 
 cFunDesc ={'double Gaussian' 'double Gaussian' 'Gompertz'};
 
  %Colors for species traces - Reds, blues, greens; dark then light
 mColors = [0.15	0.06	0.6; 0.562	0.495	0.9; 0.6	0.06	0.06; 0.9	0.495	0.495;  0.42	0.6	0.06; 0.765	0.9	0.495];

 
 figs(s+1) = figure;
 
for j=1:s %work each species
    figs(j) = figure;
       
    for i=1:25;%input the 25 wetland units
        % Input data from excel
        [data,text]= xlsread('SuitableAreaDepthVarying.xls', textx{i});

        %Select the data
        staffgage=data(:,1);%Wdepth in m.
        SuitableArea=data(:,1+j);%Suitable Area in ha- for species

        %Implementing the equation

        %Curve depends on the species (species #1 and #2 are double gaussian
        %bell; #3 is 4th order polynomial
        if j==1 || j==2
            EqType = 1; %Double gassian bell curve
             %First find the water depth at whch hsi is maximum
            [max_hsi,max_ind] = max(SuitableArea,[],1);

            %Fit parameters to the staff gage water level vs suitable area
            %data
            my_par =fminsearch(@(par_fit) norm(SuitableArea-hSpecFun{j}(par_fit,staffgage)),[staffgage(max_ind),0.2,max_hsi,staffgage(max_ind)+0.2,.1,max_hsi-100]);
            new_hsi = hSpecFun{j}(my_par,staffgage);
            my_par = [EqType my_par];            
            
        else
            EqType = 2; %Gomertz
            %Fit parameters to the staff gage water level vs suitable area
            %data
            my_par =fminsearch(@(par_fit) norm(SuitableArea-hSpecFun{j}(par_fit,staffgage)),[43.453,-413.63,967.84,-147.09,1]);
            %pad with a zero to expand to 6 to make even with species 1 and
            %2
            my_par = [EqType my_par(1,1:3) zeros(1,3)]; %pad remaining unused parameters with zeros
        end

        %Estimate suitable area using the fitted parameters
        new_hsi = hSpecFun{j}(my_par(:,2:end),staffgage);
        %Save the curve fitting parameters
        param=[param;my_par];
        nm=[nm;{specnames{j} textx{i}}];
        
        
         %Write to the combined Figure S1
         figure(figs(s+1))
        subplot(5,5,i);
        if j==1
            plot(staffgage,data(:,3+s),'color',[0 0 0],'linewidth',3,'linestyle','-','marker','none');  %Plot wetted area in thick black
        end
         hold on
        plot(staffgage,SuitableArea,'color',mColors(2*j,:),'LineWidth',2.5,'marker','none','linestyle','-'); hold on;%Original depth-varying HSI area data in blue
        plot(staffgage,new_hsi,'color',mColors(2*j-1,:),'LineWidth',1.5,'linestyle','-.'); hold off;%Simulated in red
        title(textx(i));
        
        %set y lim to zero
        yLimCurr = get(gca,'yLim');
        set(gca,'yLim',[0 yLimCurr(2)],'Fontsize',14);

         if i==23,xlabel('Staff gage reading (m)','fontsize',20,'FontName','Times New Roman'); end
         if i==11,ylabel('Area (Ha)','fontsize',20,'FontName','Times New Roman');end 
        

        %Species specific figure
        figure(figs(j));
        subplot(5,5,i);
        plot(staffgage,data(:,3+s),'color',[0 0 0],'linewidth',2,'linestyle','-','marker','none'); hold on %Plot wetted area in thick black
        plot(staffgage,data(:,3+s+j),'color',[0.4	0.75	1],'linewidth',2,'linestyle','-.','marker','none'); %Plot old HSI area at wetted area in dashed light blue
        plot(staffgage,SuitableArea,'*b'); hold on;%Original depth-varying HSI area data as blue stars
        plot(staffgage,new_hsi,':r','LineWidth',2); hold off;%Fitted  in dashed red
        title(textx(i));
        
        %set y lim to zero
        yLimCurr = get(gca,'yLim');
        set(gca,'yLim',[0 yLimCurr(2)],'Fontsize',12);

         if i==23,xlabel('Staff gage reading (m)','fontsize',20,'FontName','Times New Roman'); end
         if i==11,ylabel('Area (Ha)','fontsize',20,'FontName','Times New Roman');end
           
    end 

     %Create a legend for the species-specifc figure
    legend({'Wetted area' 'Suitable area-from wetted area', 'Suitable area-depth varying', 'Fitted curve'},'FontSize',14);   
    %title(specnames{j},'Fontsize',16);
end

    % Final formating for the combined Figure
    figure(figs(s+1));
    
    SpecNamesLeg = cell(1,2*s);
    for i=1:s
        SpecNamesLeg{1,2*i-1} = sprintf('%s-%s',SpecNameFull{i},'suitable area');
        SpecNamesLeg{1,2*i} = sprintf('%s-%s (%s)',SpecNameFull{i},'fitted',cFunDesc{i});
    end
    
   lng =  legend({'Wetted area (LIDAR)' SpecNamesLeg{:}},'FontSize',14);   
   set(lng,'Position',[0.7499 0.7753 0.2523 0.1944]);


%Write to an excel file - Species and unit name in columns A and B, Equation Type in Column C and fitted parameter values in Columns D and up 
xlswrite('Paramet_OutputHSI.xls', nm,  'DepthWeightHSIAreaFunc','A1');
xlswrite('Paramet_OutputHSI.xls', param, 'DepthWeightHSIAreaFunc','C1');

%Also write to GDX
%To write Index
sPars.name = 'pars';
sPars.type = 'set';
sPars.uels = {'p0','p1','p2','p3','p4','p5','p6'};

sDWparams.name = 'DWparams';
sDWparams.type = 'parameter';
sDWparams.dim = 3;
sDWparams.form = 'full';
sDWparams.uels = {textx,specnames,sPars.uels};
sDWparams.val = reshape(param,[25 3 7]);
%Here create the GDX file 
wgdx('G_DWparams',sDWparams,sPars); 
     
