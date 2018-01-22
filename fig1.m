%% change these parameters to get all figures
sigma = 1.0;
add_25_points_in_middle = false;



%% additional parameters + create data

rng(6772);
n = 300; % number of points

x = [-8:0.01:8]'; % horizontal axis

mu = [-3,3]'; % Gaussian means
sd = ones(1,1,numel(mu)); sd(1,1,1) = 1; sd(1,1,2) = 1; % Gaussian stds
p = [100,200]; % mixture probabilities of Gaussians
obj = gmdistribution(mu,sd,p);
y = random(obj,n);

if add_25_points_in_middle % add additional 25 points in middle
	y = [y;0.2*randn(25,1)];
end



%% calculate weight-shape decomposition

d = pdist2(x,y).^2;
g = exp(-d/((2*sigma^2)));
psi = sum(g,2);
v = (1/(2*sigma^2))*sum(d.*g,2)./psi;
s = v+log(psi);
exps = exp(s);
expv = exp(-v);



%% display

figure_width_inches = 2.45;
figure_height_inches = 1.2;
font_name = 'Times New Roman';
font_size = 8;
title_font_size = 13;
label_font_size = 8;
from_left = 0.45;
from_bottom = 0.3;
width = 1.8;
height = 0.8;
line_width = 1;

clrs = [18,53,250;68,194,54;236,40,40;194,55,198;222,162,20;0,0,0;68,132,159;154,152,73]/255;


fig = figure;
fig.Units = 'inches';
fig.Position = [0.9,0.9,figure_width_inches,figure_height_inches];
fig.PaperUnits = 'inches';
fig.PaperPosition = [0,0,figure_width_inches,figure_height_inches];
fig.Color = 'w';

ax1 = axes('Units','inches','OuterPosition',[0,0,figure_width_inches,figure_height_inches],'Position',[from_left,from_bottom,width,height]);
ax2 = axes('Units','inches','OuterPosition',[0,0,figure_width_inches,figure_height_inches],'Position',[from_left,from_bottom,width,height]);

ax = [ax1,ax2];



axes(ax1);
hold on;
plt22 = plot(x,psi,'Color',clrs(1,:),'LineWidth',line_width);
plt21 = plot(x,exps,'Color',clrs(2,:),'LineWidth',line_width);
ylabel('$$W$$ , $$\Psi$$','interpreter','latex');
axes(ax2);
plt1 = plot(x,expv,'Color',clrs(3,:),'LineWidth',line_width);
xlabel('$$\bf{x}$$','interpreter','latex');
ylabel('$$S$$','interpreter','latex');


lm = ylim;
text('String',['$\sigma=' num2str(sigma,2) '$'],'interpreter','latex','FontSize',font_size,'Position',[-7.6,lm(1)+(lm(2)-lm(1))*0.9]);
% line([y,y]',[0*y,0*y+lm(2)/11]','color','k','LineWidth',0.05);

% legend([plt22,plt21,plt1],{'$$\Psi$$','$$W$$','$$S$$'},'interpreter','latex','Position',[0.35 0.03 0.34 0.046],'orientation','horizontal')



set(ax,'XLim',[-8,8]);
set(ax1,'XGrid','on');
set(ax1,'YGrid','on');
set(ax2,'XGrid','off');
set(ax2,'YGrid','off');
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
set(ax2,'YAxisLocation','right');
