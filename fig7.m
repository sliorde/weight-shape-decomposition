sigma = 1.1;
im_names = {'trump.jpg','merkel.jpg','putin.jpg'};

results = {};

for i=1:numel(im_names)
	im_rgb = imread(im_names{i});
	im = double(rgb2gray(im_rgb));
	
	% preprocess
	im = 0.1+0.8*(im-min(im(:)))./(max(im(:))-min(im(:)));
	
	[~,~,s] = WeightShapeDecompositionSingleChannel(im,sigma,5);
	
	% perform threshold
	s = double(s>0.363);
	
	% make sure background is white and not black
	if nnz(s)<(numel(s)/2)
		s = 1-s;
	end
	
	results{end+1} = s;
end
	
s1 = results{1};
s2 = results{2};
s3 = results{3};
	

%% display

figure_width_inches = 4;
figure_height_inches = 2;
font_name = 'Times New Roman';
font_size = 9;
title_font_size = 13;
label_font_size = 8;
from_left = 0;
from_bottom = 0.05;
width = figure_width_inches/3-from_left*4;
height = figure_height_inches-from_bottom;
line_width = 1;

fig = figure;
fig.Units = 'inches';
fig.Position = [0.9,0.9,figure_width_inches,figure_height_inches];
fig.PaperUnits = 'inches';
fig.PaperPosition = [0,0,figure_width_inches,figure_height_inches];
fig.Color = 'w';

ax1 = axes('Units','inches','OuterPosition',[0,0,figure_width_inches/3,figure_height_inches],'Position',[from_left,from_bottom,width,height]);
ax2 = axes('Units','inches','OuterPosition',[figure_width_inches/3,0,figure_width_inches/3,figure_height_inches],'Position',[figure_width_inches/3+from_left,from_bottom,width,height]);
ax3 = axes('Units','inches','OuterPosition',[2*figure_width_inches/3,0,figure_width_inches/3,figure_height_inches],'Position',[2*figure_width_inches/3+from_left,from_bottom,width,height]);

ax = [ax1,ax2,ax3];



colormap(gray);

axes(ax1);
imagesc(s1);
text('String','(a)','FontName',font_name,'FontSize',font_size,'Position',[10,-6],'FontWeight','bold');
axis equal;

axes(ax2);
imagesc(s2);
text('String','(b)','FontName',font_name,'FontSize',font_size,'Position',[10,8],'FontWeight','bold');
axis equal;

axes(ax3);
imagesc(s3);
text('String','(c)','FontName',font_name,'FontSize',font_size,'Position',[10,10],'FontWeight','bold');
axis equal;


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
