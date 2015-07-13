function FunctionNeededToFigSM1(X1, YMatrix1)
%CREATEFIGURE(X1,YMATRIX1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 13-Feb-2013 20:55:53

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'XTick',zeros(1,0),'TickDir','out',...
    'FontSize',8);
box(axes1,'on');
hold(axes1,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'Parent',axes1,'LineWidth',1);
set(plot1(1),'DisplayName','G+');
set(plot1(2),'LineStyle','--','Color',[1 0 0],'DisplayName','G-');

% Create xlabel
xlabel({'0'},'FontSize',8,'FontName','Times New Roman');

% Create ylabel
ylabel({'Gate manipulation'},'FontSize',8,'FontName','Times New Roman');

% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.762435567358557 0.155136451934878 0.133928571428571 0.0904761904761905]);

% Create line
annotation(figure1,'line',[0.518377693282636 0.517241379310345],...
    [0.107455882352941 0.927167630057804],'LineStyle','-.');

% Create line
annotation(figure1,'line',[0.71549368074344 0.714733542319748],...
    [0.112889408364502 0.541040462427746],'LineStyle','-.');

% Create line
annotation(figure1,'line',[0.729224088266943 0.728840125391844],...
    [0.588843165589938 0.745664739884395],'LineStyle','-.');

% Create textbox
annotation(figure1,'textbox',...
    [0.732365122312674 0.622704522271336 0.0380228136882129 0.0477941176470588],...
    'String',{'k'},...
    'FontSize',8,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.70014389526386 0.0630256796360148 0.0430925221799746 0.0551470588235294],...
    'String',{'x_0'},...
    'FontSize',8,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.663052538344919 0.0113406559155442 0.211947461655081 0.0477941176470588],...
    'String',{'Positive changes'},...
    'FontSize',8,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none',...
    'EdgeColor','none');

% Create doublearrow
annotation(figure1,'doublearrow',[0.525704209583517 0.906958128078817],...
    [0.0611401248360683 0.0613308762811483]);

% Create doublearrow
annotation(figure1,'doublearrow',[0.125 0.521378190774742],...
    [0.0595238095238096 0.0601748069169894]);

% Create textbox
annotation(figure1,'textbox',...
    [0.214089260243711 0.016518195139326 0.241267882613432 0.0477941176470588],...
    'String',{'Negative changes'},...
    'FontSize',8,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.390874974529424 0.00699438561551648 0.391267882613432 0.0477941176470588],...
    'String',{'Change in release or delivery'},...
    'FontSize',8,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none',...
    'EdgeColor','none');

% Create line
annotation(figure1,'line',[0.714733542319749 0.728571428571429],...
    [0.589595375722543 0.59047619047619],'LineStyle','-.');

% Create textbox
annotation(figure1,'textbox',...
    [0.0188180291366339 0.899064563397614 0.0798479087452471 0.0477941176470588],...
    'String',{'Required'},...
    'FontSize',8,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.0291262060565193 0.0899170835964428 0.0621039290240811 0.0477941176470588],...
    'String',{'None'},...
    'FontSize',8,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none',...
    'EdgeColor','none');