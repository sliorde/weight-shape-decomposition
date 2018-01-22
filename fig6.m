im_rgb = imread('trump.jpg');
im = double(rgb2gray(im_rgb));

sigma = 1.1;

% preprocess
im2 = 0.1+0.8*(im2-min(im2(:)))./(max(im2(:))-min(im2(:)));

% 
[p,w,s] = WeightShapeDecompositionSingleChannel(im2,sigma,5);

% cutoff s for display
s = 1-min(max((s-quantile(s(:),0.01))./(quantile(s(:),0.99)-quantile(s(:),0.01)),0),1);


%% display


figure_width_inches = 3.15;
figure_height_inches = 3.85;
font_name = 'Times New Roman';
font_size = 9;
title_font_size = 13;
label_font_size = 8;
from_left = 0.05;
from_bottom = 0.02;
width = figure_width_inches/2-from_left*2;
height = figure_height_inches/2-from_bottom*2;
line_width = 1;

fig = figure;
fig.Units = 'inches';
fig.Position = [0.9,0.9,figure_width_inches,figure_height_inches+0.6];
fig.PaperUnits = 'inches';
fig.PaperPosition = [0,0,figure_width_inches,figure_height_inches+0.6];
fig.Color = 'w';

ax1 = axes('Units','inches','OuterPosition',[0,0.6+figure_height_inches/2,figure_width_inches/2,figure_height_inches/2],'Position',[from_left,0.6+figure_height_inches/2+from_bottom,width,height]);
ax2 = axes('Units','inches','OuterPosition',[figure_width_inches/2,0.6+figure_height_inches/2,figure_width_inches/2,figure_height_inches/2],'Position',[figure_width_inches/2+from_left,0.6+figure_height_inches/2+from_bottom,width,height]);
ax3 = axes('Units','inches','OuterPosition',[0,0.6+0,figure_width_inches/2,figure_height_inches/2],'Position',[from_left,0.6,width,height]);
ax4 = axes('Units','inches','OuterPosition',[figure_width_inches/2,0.6+0,figure_width_inches/2,figure_height_inches/2],'Position',[figure_width_inches/2+from_left,0.6,width,height]);
ax5 = axes('Units','inches','OuterPosition',[0,0,figure_width_inches/2,0.15],'Position',[0.05,0,figure_width_inches/2-0.1,0.15]);
ax6 = axes('Units','inches','OuterPosition',[figure_width_inches/2,0,figure_width_inches/2,0.15],'Position',[0.05+figure_width_inches/2,0,figure_width_inches/2-0.1,0.15]);
ax7 = axes('Units','inches','OuterPosition',[0,0.15,figure_width_inches/2,0.45],'Position',[0.05,0.15,figure_width_inches/2-0.1,0.45]);
ax8 = axes('Units','inches','OuterPosition',[figure_width_inches/2,0.15,figure_width_inches/2,0.3],'Position',[0.05+figure_width_inches/2,0.15,figure_width_inches/2-0.1,0.45]);

ax = [ax1,ax2,ax3,ax4,ax5,ax6,ax7,ax8];

colormap(gray);

axes(ax1);
imagesc(im);
if max(im(:))>1
	caxis([0,255]);
else
	caxis([0,1]);
end
text('String',' original image','FontName',font_name,'FontSize',font_size,'Position',[30,12]);
text('String','(a)','FontName',font_name,'FontSize',font_size,'Position',[10,12],'FontWeight','bold');
axis equal;

axes(ax2);
imagesc(p);
text('String','\textbf{(b)} $\Psi$','interpreter','latex','FontName',font_name,'FontSize',font_size,'Position',[12,15]);
axis equal;

axes(ax3);
imagesc(w);
text('String','\textbf{(c)} $W$','interpreter','latex','FontName',font_name,'FontSize',font_size,'Position',[12,15]);
axis equal;

axes(ax4);
imagesc(s);
text('String','\textbf{(d)} $S$','interpreter','latex','FontName',font_name,'FontSize',font_size,'Position',[12,15],'Color','k');
axis equal;

axes(ax5);
imagesc(linspace(0,1,100));

axes(ax6);
imagesc(linspace(0,1,100));

axes(ax7);
[hw,edges] = histcounts(w(:),100);
bar(0.5*(edges(2:end)+edges(1:(end-1))),hw,'BarWidth',1,'EdgeColor','none','FaceColor',[0,162,232]/255,'LineWidth',0.01);
% set(ax7,'YScale','log');
ylim([0,max(hw)]);

axes(ax8);
[hs,edges] = histcounts(s(:),100);
bar(0.5*(edges(2:end)+edges(1:(end-1))),hs,'BarWidth',1,'EdgeColor','none','FaceColor',[0,162,232]/255,'LineWidth',0.01);
% set(ax8,'YScale','log');
ylim([0,max(hs)]);

set(ax,'XGrid','off');
set(ax,'YGrid','off');
set(ax,'XTick',[]);
set(ax,'YTick',[]);
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
