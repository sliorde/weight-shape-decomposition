sigma = 0.05;
L = 1; % interval length

x = linspace(-0.2,L+0.2,1000);

psi = sqrt(pi/2)*sigma*(erf(x/(sqrt(2)*sigma))-erf((x-L)/(sqrt(2)*sigma)));

ddpsi = (-x/(sigma^2)).*exp(-(x.^2)/(2*sigma^2)) - ((L-x)/(sigma^2)).*exp(-((L-x).^2)/(2*sigma^2));

V = ((sigma^2)/2)*ddpsi./psi + 1/2;

H = V + log(psi);



%% display

figure_width_inches = 4;
figure_height_inches = 1.7;
font_name = 'Times New Roman';
font_size = 9;
title_font_size = 13;
label_font_size = 8;
from_left = 0.5;
from_bottom = 0.35;
width = 3.1;
height = 1
line_width = 1.3;
clrs = [18,53,250;68,194,54;236,40,40;194,55,198;222,162,20;0,0,0;68,132,159;154,152,73]/255;


fig = figure;
fig.Units = 'inches';
fig.Position = [0.9,0.9,figure_width_inches,figure_height_inches];
fig.PaperUnits = 'inches';
fig.PaperPosition = [0,0,figure_width_inches,figure_height_inches];
fig.Color = 'w';

ax11 = axes('Units','inches','OuterPosition',[0,0.22,figure_width_inches,figure_height_inches],'Position',[from_left,0.22+from_bottom,width,height]);
ax12 = axes('Units','inches','OuterPosition',[0,0.22,figure_width_inches,figure_height_inches],'Position',[from_left,0.22+from_bottom,width,height]);

ax = [ax11,ax12];

set(ax,'ColorOrder',clrs);



axes(ax11);
hold on;
plt1 = plot(x,psi,'LineWidth',line_width,'Color',clrs(1,:));
plt2 = plot(x,exp(H),'LineWidth',line_width,'Color',clrs(2,:));
axes(ax12);
plt3 = plot(x,exp(-V),'LineWidth',line_width,'Color',clrs(3,:));
xlabel('$$x$$','interpreter','latex');
ylabel(ax12,'$$S$$','interpreter','latex');
ylabel(ax11,'$$W$$ , $$\Psi$$','interpreter','latex');
% legend([plt1;plt2],{'$$S$$','$$W$$','$$\psi$$'},'interpreter','latex','Position',[0.3 0.036 0.34 0.046],'orientation','horizontal')
lm = ylim;
text('String',['$$\sigma=' num2str(sigma,2) '$$'],'interpreter','latex','FontSize',11,'Position',[-0.16,lm(1)+(lm(2)-lm(1))*0.9]);
lg = legend([plt1,plt2,plt3],{'$\Psi$','$W$','$S$'},'interpreter','latex','orientation','horozintal');
set(lg,'Position',[0.39 0.04 0.235159189875138 0.0667605668726103]);



%%
% set(ax,'XLim',[-0.,2]);
set(ax,'XGrid','on');
set(ax,'YGrid','on');
set(ax,'Box','on');
set(ax,'LineWidth',0.5);
set(ax,'FontName',font_name);
set(ax,'FontSize',font_size);
set(ax,'TitleFontSizeMultiplier',title_font_size/font_size);
set(ax,'LabelFontSizeMultiplier',label_font_size/font_size);
set(ax,'ActivePositionProperty','position');
set(ax,'TickLength', [0,0]);
set(ax,'YColor','k');
set(ax,'Color','none');
set(ax(2),'YAxisLocation','right');